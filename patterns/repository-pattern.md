# Repository Pattern
## Decoupling Business Logic from Data Access

**Use When**: Business logic is tightly coupled to database queries
**Problem**: Hard to test, violates single responsibility principle
**Solution**: Abstract data access behind repository traits

---

## Before (Anti-Pattern)

```rust
// ❌ WRONG: Business logic mixed with database queries
pub async fn calculate_comparison(
    pool: &PgPool,
    user1_id: Uuid,
    user2_id: Uuid,
) -> Result<Comparison, AppError> {
    // Direct database access in business logic
    let user1 = sqlx::query_as!(
        User,
        "SELECT * FROM users WHERE id = $1",
        user1_id
    )
    .fetch_one(pool)
    .await?;

    let user2 = sqlx::query_as!(
        User,
        "SELECT * FROM users WHERE id = $2",
        user2_id
    )
    .fetch_one(pool)
    .await?;

    // Business logic
    let score = calculate_score(&user1, &user2);

    // More database access
    sqlx::query!(
        "INSERT INTO comparisons (user1_id, user2_id, score) VALUES ($1, $2, $3)",
        user1_id, user2_id, score
    )
    .execute(pool)
    .await?;

    Ok(Comparison { user1, user2, score })
}
```

**Problems**:
- Can't test without database
- Business logic scattered across data access code
- Hard to mock or swap data sources
- Violates single responsibility

---

## After (Repository Pattern)

### Step 1: Define Repository Trait

```rust
#[async_trait]
pub trait UserRepository {
    async fn find_by_id(&self, id: Uuid) -> Result<User, AppError>;
    async fn create(&self, user: &User) -> Result<Uuid, AppError>;
    async fn update(&self, user: &User) -> Result<(), AppError>;
}

#[async_trait]
pub trait ComparisonRepository {
    async fn create(&self, comparison: &Comparison) -> Result<Uuid, AppError>;
    async fn find_by_users(&self, user1_id: Uuid, user2_id: Uuid) -> Result<Option<Comparison>, AppError>;
}
```

### Step 2: Implement for PostgreSQL

```rust
pub struct PostgresUserRepository {
    pool: PgPool,
}

#[async_trait]
impl UserRepository for PostgresUserRepository {
    async fn find_by_id(&self, id: Uuid) -> Result<User, AppError> {
        sqlx::query_as!(
            User,
            "SELECT * FROM users WHERE id = $1",
            id
        )
        .fetch_one(&self.pool)
        .await
        .map_err(Into::into)
    }

    async fn create(&self, user: &User) -> Result<Uuid, AppError> {
        sqlx::query!(
            "INSERT INTO users (id, name, email) VALUES ($1, $2, $3) RETURNING id",
            user.id, user.name, user.email
        )
        .fetch_one(&self.pool)
        .await
        .map(|row| row.id)
        .map_err(Into::into)
    }

    async fn update(&self, user: &User) -> Result<(), AppError> {
        sqlx::query!(
            "UPDATE users SET name = $2, email = $3 WHERE id = $1",
            user.id, user.name, user.email
        )
        .execute(&self.pool)
        .await?;
        Ok(())
    }
}
```

### Step 3: Business Logic Uses Traits

```rust
// ✅ CORRECT: Business logic depends on abstractions, not concretions
pub async fn calculate_comparison<UR, CR>(
    user_repo: &UR,
    comparison_repo: &CR,
    user1_id: Uuid,
    user2_id: Uuid,
) -> Result<Comparison, AppError>
where
    UR: UserRepository,
    CR: ComparisonRepository,
{
    // Clean data access through repository
    let user1 = user_repo.find_by_id(user1_id).await?;
    let user2 = user_repo.find_by_id(user2_id).await?;

    // Pure business logic (testable without database)
    let score = calculate_score(&user1, &user2);

    // Save through repository
    let comparison = Comparison {
        id: Uuid::new_v4(),
        user1_id,
        user2_id,
        score,
        created_at: Utc::now(),
    };
    comparison_repo.create(&comparison).await?;

    Ok(comparison)
}

// Pure function (easily testable)
fn calculate_score(user1: &User, user2: &User) -> f64 {
    // Business logic here
    0.85
}
```

### Step 4: Easy Testing with Mocks

```rust
#[cfg(test)]
mod tests {
    use super::*;

    struct MockUserRepository {
        users: HashMap<Uuid, User>,
    }

    #[async_trait]
    impl UserRepository for MockUserRepository {
        async fn find_by_id(&self, id: Uuid) -> Result<User, AppError> {
            self.users.get(&id)
                .cloned()
                .ok_or(AppError::NotFound)
        }

        async fn create(&self, user: &User) -> Result<Uuid, AppError> {
            Ok(user.id)
        }

        async fn update(&self, user: &User) -> Result<(), AppError> {
            Ok(())
        }
    }

    #[tokio::test]
    async fn test_calculate_comparison() {
        let user1 = User { id: Uuid::new_v4(), name: "Alice".into(), email: "alice@example.com".into() };
        let user2 = User { id: Uuid::new_v4(), name: "Bob".into(), email: "bob@example.com".into() };

        let user_repo = MockUserRepository {
            users: vec![(user1.id, user1.clone()), (user2.id, user2.clone())].into_iter().collect(),
        };
        let comparison_repo = MockComparisonRepository::new();

        let result = calculate_comparison(&user_repo, &comparison_repo, user1.id, user2.id).await;

        assert!(result.is_ok());
        assert_eq!(result.unwrap().score, 0.85);
    }
}
```

---

## Benefits

✅ **Testability**: Mock repositories for unit tests
✅ **Flexibility**: Swap PostgreSQL for in-memory, Redis, etc.
✅ **Separation of Concerns**: Business logic separate from data access
✅ **DRY**: Repository methods reusable across the codebase
✅ **Type Safety**: Trait bounds enforce correct usage

---

## Checklist for Ox

When refactoring to repository pattern:

- [ ] Identify all direct database calls in business logic
- [ ] Define repository trait with needed methods
- [ ] Implement PostgreSQL version
- [ ] Update business logic to use repository trait
- [ ] Add mock repository for testing
- [ ] Ensure all tests pass with mocks
- [ ] Update integration tests to use real repository

---

## File Structure

```
src/
├── domain/
│   ├── models/
│   │   ├── user.rs
│   │   └── comparison.rs
│   └── repositories/  # <-- Repository traits
│       ├── mod.rs
│       ├── user_repository.rs
│       └── comparison_repository.rs
├── infrastructure/
│   └── postgres/  # <-- PostgreSQL implementations
│       ├── user_repository_impl.rs
│       └── comparison_repository_impl.rs
└── application/
    └── services/  # <-- Business logic using repositories
        └── comparison_service.rs
```

---

**DMX Approval Criteria**:
- All repositories have trait definitions
- Business logic has zero direct database calls
- Unit tests use mocks, not real database
- Integration tests verify PostgreSQL implementation works
