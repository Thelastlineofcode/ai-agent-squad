# 🔧 TAPIN CLEANUP - TROUBLESHOOTING GUIDE

**Having issues? Check here first!**

---

## 🐍 BACKEND ISSUES

### Issue: "Module not found" or Import Errors

**Symptoms:**
```
ImportError: No module named 'flask'
ModuleNotFoundError: No module named 'sqlalchemy'
```

**Solutions:**

1. **Make sure virtual environment is activated:**
   ```bash
   cd src/backend
   source .venv/bin/activate  # Mac/Linux
   # .venv\Scripts\activate  # Windows
   
   # Check if activated (should show .venv in prompt)
   which python  # Should point to .venv/bin/python
   ```

2. **Reinstall dependencies:**
   ```bash
   pip install -r requirements.txt
   
   # If still issues, upgrade pip first:
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

3. **Check Python version:**
   ```bash
   python --version  # Should be 3.10+
   
   # If wrong version, use specific version:
   python3.10 -m venv .venv
   ```

---

### Issue: "Port 5000 already in use"

**Symptoms:**
```
OSError: [Errno 48] Address already in use
```

**Solutions:**

**Mac/Linux:**
```bash
# Find process using port 5000
lsof -ti:5000

# Kill it
lsof -ti:5000 | xargs kill -9

# Or kill all Python processes (CAREFUL!)
killall python
```

**Windows:**
```bash
# Find process
netstat -ano | findstr :5000

# Kill it (replace <PID> with the process ID)
taskkill /PID <PID> /F
```

**Alternative: Use different port:**
```bash
# In .env or when starting
PORT=5001 python app.py
```

---

### Issue: Database Errors

**Symptoms:**
```
sqlalchemy.exc.OperationalError: no such table
sqlite3.OperationalError: database is locked
```

**Solutions:**

1. **Reset database (CAUTION: deletes all data):**
   ```bash
   cd src/backend
   rm data.db
   python app.py  # Will create new DB
   ```

2. **Run migrations:**
   ```bash
   flask --app backend.app db upgrade
   
   # Or if using manage.py
   python manage.py db upgrade
   ```

3. **Database locked (SQLite):**
   ```bash
   # Kill any processes using the database
   lsof data.db
   kill -9 <PID>
   
   # Or restart your computer if nothing else works
   ```

4. **Check database path in .env:**
   ```bash
   # Make sure path is correct
   SQLALCHEMY_DATABASE_URI=sqlite:///data.db  # relative path
   # OR
   SQLALCHEMY_DATABASE_URI=sqlite:////absolute/path/to/data.db
   ```

---

### Issue: "SECRET_KEY not set" or JWT Errors

**Symptoms:**
```
RuntimeError: The session is unavailable because no secret key was set
```

**Solutions:**

1. **Generate proper secret keys:**
   ```bash
   # Generate secrets
   python3 -c "import secrets; print(secrets.token_hex(32))"
   
   # Add to .env:
   SECRET_KEY=your-generated-secret-here
   JWT_SECRET_KEY=your-generated-jwt-secret-here
   ```

2. **Check .env is being loaded:**
   ```bash
   # Add to app.py to debug
   print(os.getenv('SECRET_KEY'))
   
   # Make sure python-dotenv is installed
   pip install python-dotenv
   ```

---

### Issue: LLM/API Errors

**Symptoms:**
```
Error: GEMINI_API_KEY not found
APIError: Rate limit exceeded
```

**Solutions:**

1. **Use dev provider for testing:**
   ```bash
   # In .env
   LLM_PROVIDER=dev
   
   # This bypasses all API calls - perfect for testing!
   ```

2. **Check API key format:**
   ```bash
   # In .env (no quotes needed)
   GEMINI_API_KEY=your-key-here
   
   # NOT this:
   GEMINI_API_KEY="your-key-here"  # Wrong!
   ```

3. **Rate limit issues:**
   ```bash
   # Use caching to reduce API calls
   CACHE_ENABLED=True
   CACHE_TTL=3600
   
   # Or stick with dev provider
   LLM_PROVIDER=dev
   ```

---

## ⚛️ FRONTEND ISSUES

### Issue: "npm install" Fails

**Symptoms:**
```
ERESOLVE unable to resolve dependency tree
npm ERR! code EACCES
```

**Solutions:**

1. **Clear npm cache:**
   ```bash
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install
   ```

2. **Use --legacy-peer-deps:**
   ```bash
   npm install --legacy-peer-deps
   ```

3. **Check Node version:**
   ```bash
   node --version  # Should be 18+ or 20+
   
   # Update Node if needed using nvm or download from nodejs.org
   ```

4. **Permission issues (Mac/Linux):**
   ```bash
   sudo chown -R $(whoami) ~/.npm
   npm install
   ```

---

### Issue: "npm run dev" Fails or Won't Start

**Symptoms:**
```
Error: Cannot find module 'vite'
Port 5173 already in use
```

**Solutions:**

1. **Missing dependencies:**
   ```bash
   npm install
   npm run dev
   ```

2. **Port in use:**
   ```bash
   # Mac/Linux
   lsof -ti:5173 | xargs kill -9
   
   # Windows
   netstat -ano | findstr :5173
   taskkill /PID <PID> /F
   ```

3. **Vite config issues:**
   ```bash
   # Check vite.config.js exists
   ls -la vite.config.js
   
   # If missing, check package.json for correct dev script
   cat package.json | grep "dev"
   ```

---

### Issue: CORS Errors in Browser

**Symptoms:**
```
Access to fetch at 'http://localhost:5000' from origin 'http://localhost:5173' 
has been blocked by CORS policy
```

**Solutions:**

1. **Check CORS configuration in .env:**
   ```bash
   # Add to .env
   CORS_ORIGINS=http://localhost:5173,http://localhost:3000
   ```

2. **Check Flask-CORS in backend:**
   ```python
   # In app.py, make sure you have:
   from flask_cors import CORS
   CORS(app, origins=os.getenv('CORS_ORIGINS', '').split(','))
   ```

3. **Restart both servers:**
   ```bash
   # Backend
   # (Ctrl+C to stop, then restart)
   python app.py
   
   # Frontend
   # (Ctrl+C to stop, then restart)
   npm run dev
   ```

---

### Issue: API Calls Failing (Network Errors)

**Symptoms:**
```
Failed to fetch
Network request failed
ERR_CONNECTION_REFUSED
```

**Solutions:**

1. **Check backend is running:**
   ```bash
   # Should see Flask server running
   curl http://localhost:5000/health  # or /api/health
   
   # If nothing, start backend:
   cd src/backend
   source .venv/bin/activate
   python app.py
   ```

2. **Check VITE_BACKEND_URL:**
   ```bash
   # In .env
   VITE_BACKEND_URL=http://localhost:5000
   
   # NOT https or wrong port!
   ```

3. **Check browser console:**
   ```
   F12 → Console → Look for error details
   F12 → Network → See which requests are failing
   ```

---

### Issue: Images Not Loading

**Symptoms:**
- Broken image icons
- 404 errors in console
- Missing event images

**Solutions:**

1. **Check image URLs:**
   ```javascript
   // In EventCard.jsx or similar
   console.log('Image URL:', imageUrl);
   ```

2. **Add placeholder images:**
   ```javascript
   <img 
     src={imageUrl} 
     onError={(e) => e.target.src = '/placeholder.png'}
     alt="Event"
   />
   ```

3. **Check public folder:**
   ```bash
   ls -la src/front/public/
   # Make sure placeholder images are there
   ```

---

## 🔐 SECURITY ISSUES

### Issue: .env File in Git

**Symptoms:**
```
git status shows .env
git history contains .env
```

**Solutions:**

1. **Remove from tracking (not from disk):**
   ```bash
   git rm --cached .env
   git commit -m "security: remove .env from git tracking"
   ```

2. **Add to .gitignore:**
   ```bash
   echo ".env" >> .gitignore
   git add .gitignore
   git commit -m "chore: add .env to .gitignore"
   ```

3. **If .env already in history:**
   ```bash
   # WARNING: This rewrites history!
   git filter-branch --force --index-filter \
     'git rm --cached --ignore-unmatch .env' \
     --prune-empty --tag-name-filter cat -- --all
   
   # Force push (be careful!)
   git push origin --force --all
   ```

---

### Issue: Hardcoded Credentials Found

**Symptoms:**
- Audit script flags passwords/API keys
- Code contains actual credentials

**Solutions:**

1. **Move to .env:**
   ```python
   # WRONG:
   api_key = "sk-abc123..."
   
   # RIGHT:
   api_key = os.getenv('API_KEY')
   ```

2. **Update all references:**
   ```bash
   # Find all hardcoded keys
   grep -rn "api.*key.*=.*['\"]" src/ --include="*.py"
   
   # Fix each one by moving to .env
   ```

3. **Rotate compromised keys:**
   - If keys were pushed to Git, consider them compromised
   - Generate new keys from the provider
   - Update .env with new keys

---

## 🐛 GIT ISSUES

### Issue: Merge Conflicts

**Symptoms:**
```
CONFLICT (content): Merge conflict in src/backend/app.py
```

**Solutions:**

1. **See conflict files:**
   ```bash
   git status
   ```

2. **Resolve manually:**
   ```bash
   # Edit conflicted files
   code src/backend/app.py
   
   # Look for:
   <<<<<<< HEAD
   your changes
   =======
   their changes
   >>>>>>> branch-name
   
   # Keep what you want, remove conflict markers
   ```

3. **Mark as resolved:**
   ```bash
   git add src/backend/app.py
   git commit -m "merge: resolve conflicts"
   ```

4. **Abort merge if needed:**
   ```bash
   git merge --abort
   ```

---

### Issue: Accidentally Committed Wrong Files

**Solutions:**

1. **Undo last commit (keep changes):**
   ```bash
   git reset --soft HEAD~1
   ```

2. **Undo last commit (discard changes):**
   ```bash
   git reset --hard HEAD~1  # CAREFUL!
   ```

3. **Remove specific file from last commit:**
   ```bash
   git reset HEAD~1 -- path/to/file
   git commit --amend
   ```

---

## 🧪 TESTING ISSUES

### Issue: Tests Won't Run

**Solutions:**

1. **Check test files exist:**
   ```bash
   find . -name "*test*.py" -o -name "test_*.py"
   ```

2. **Install test dependencies:**
   ```bash
   pip install pytest pytest-flask
   ```

3. **Run tests:**
   ```bash
   # Python
   pytest
   
   # JavaScript
   npm test
   ```

---

### Issue: Application Works Locally But Not in Demo

**Solutions:**

1. **Fresh start:**
   ```bash
   # Kill all processes
   killall python node
   
   # Clear caches
   rm -rf src/backend/__pycache__
   rm -rf node_modules/.cache
   
   # Restart everything
   ```

2. **Test on the actual presentation computer:**
   ```bash
   # Before presentation day
   # Test on the laptop you'll use
   # Check projector/screen resolution
   ```

3. **Have backups:**
   - Screenshots of working app
   - Screen recording
   - Code walkthrough slides

---

## 🎯 COMMON MISTAKES & FIXES

### Mistake: Modified Code in node_modules or venv

**Fix:**
```bash
# Never edit these!
# Reinstall instead:
rm -rf node_modules
npm install

rm -rf .venv
python3 -m venv .venv
pip install -r requirements.txt
```

---

### Mistake: Forgot to Activate Virtual Environment

**Fix:**
```bash
cd src/backend

# Mac/Linux
source .venv/bin/activate

# Windows
.venv\Scripts\activate

# You should see (.venv) in your prompt
```

---

### Mistake: Wrong Directory

**Fix:**
```bash
# Always check where you are
pwd

# Backend commands need backend directory
cd src/backend

# Frontend commands need root directory
cd ../..  # back to root
```

---

### Mistake: Edited Production Code Instead of Cleanup Branch

**Fix:**
```bash
# Check current branch
git branch

# Switch to correct branch
git checkout cleanup/presentation-prep

# If you made changes on wrong branch:
git stash
git checkout cleanup/presentation-prep
git stash pop
```

---

## 🆘 NUCLEAR OPTIONS (When All Else Fails)

### Start Fresh

```bash
# 1. Commit current work
git add .
git commit -m "wip: before fresh start"

# 2. Go back to clean state
git checkout claude/cutting-edge-features-011TEbFEyE1jHzGBJw82CvPt

# 3. Start cleanup again
git checkout -b cleanup/presentation-prep-v2
```

---

### Reinstall Everything

```bash
# Backend
cd src/backend
deactivate  # if in venv
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cd ../..

# Frontend
rm -rf node_modules package-lock.json
npm install
```

---

### Reset Database

```bash
cd src/backend
rm data.db
python app.py  # Creates fresh database
```

---

## 📞 GETTING HELP

### Check Logs

```bash
# Backend logs
python app.py 2>&1 | tee backend.log

# Frontend logs
npm run dev 2>&1 | tee frontend.log
```

### Debug Mode

```python
# In app.py
app.run(debug=True, host='0.0.0.0', port=5000)
```

### Browser Console

```
F12 → Console tab
F12 → Network tab (see API calls)
F12 → Application tab (check localStorage)
```

---

## ✅ PREVENTION CHECKLIST

To avoid issues:
- [ ] Always activate venv before backend work
- [ ] Always work in correct directory
- [ ] Always commit before major changes
- [ ] Always test after changes
- [ ] Always check .env configuration
- [ ] Always use dev LLM for testing
- [ ] Always keep backups

---

## 🎯 STILL STUCK?

1. **Check the error message carefully** - Google it!
2. **Review the START-CLEANUP-NOW.md** - Step-by-step guide
3. **Check QUICK-REFERENCE.md** - Common commands
4. **Document the issue** - What were you doing? What error?
5. **Try the nuclear options** - Fresh start sometimes helps

---

**Remember: Every error is a learning opportunity! 💪**

Most issues have simple solutions - don't panic, read the error message, and work through it systematically.

You've got this! 🚀
