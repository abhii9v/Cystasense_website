# GitHub Pages Deployment Guide

This document explains how to deploy the CystaSense landing page to GitHub Pages.

## 🚀 Quick Start - Deploy in 3 Steps

### ⚠️ IMPORTANT: GitHub Pages Must Be Enabled First!

The deployment workflow is ready but **will fail until GitHub Pages is enabled** in repository settings.

### Step 1: Enable GitHub Pages (REQUIRED!)
1. Go to your GitHub repository: `https://github.com/abhii9v/Cystasense_website`
2. Click on **Settings** (top menu)
3. Click on **Pages** in the left sidebar (under "Code and automation")
4. Under "Build and deployment":
   - **Source**: Select **"GitHub Actions"** (NOT "Deploy from a branch")
5. Click Save

### Step 2: Deploy the Site
**After enabling Pages**, either:
- **Option A**: Merge any branch to `main` - workflow auto-runs
- **Option B**: Go to Actions tab → "Deploy to GitHub Pages" → "Run workflow"

### Step 3: Access Your Site
- Your site will be live at: `https://abhii9v.github.io/Cystasense_website/`
- First deployment takes 1-2 minutes

---

## What Has Been Set Up

1. **Static Landing Page** (`docs/index.html`)
   - A static HTML version of the CystaSense landing page
   - No server-side dependencies
   - Uses Bootstrap 5 and Bootstrap Icons from CDN
   - Fully responsive design

2. **GitHub Actions Workflow** (`.github/workflows/deploy.yml`)
   - Automatically deploys the `docs/` directory to GitHub Pages
   - Triggers on pushes to the `main` branch
   - Can also be manually triggered via workflow_dispatch

## Workflow Explanation

The GitHub Actions workflow does the following:
1. Checks out your repository code
2. Configures GitHub Pages
3. Uploads the `docs/` directory as an artifact
4. Deploys the artifact to GitHub Pages

## Important Notes

### Static vs. Dynamic Application
- **GitHub Pages** hosts the static landing page (information only)
- **Full Flask Application** requires a backend server and cannot run on GitHub Pages
- The full application includes:
  - User authentication and database
  - Symptom tracking and analytics
  - AI health assistant (OpenAI integration)
  - Community forum

### For Full Application Deployment
To deploy the complete Flask application, you would need:
- A platform that supports Python/Flask (e.g., Heroku, Railway, Render, PythonAnywhere)
- PostgreSQL or another database
- Environment variables (SESSION_SECRET, DATABASE_URL, OPENAI_API_KEY)

Refer to the main [README.md](README.md) for local development setup.

## Troubleshooting

### Workflow Fails
- Ensure GitHub Pages is enabled in repository settings
- Check that the source is set to "GitHub Actions"
- Verify the workflow file is on the `main` branch

### Site Not Updating
- Check the Actions tab for workflow status
- Clear your browser cache
- Wait a few minutes for deployment to complete

### 404 Error
- Ensure the `docs/` directory exists on the `main` branch
- Verify `index.html` is present in the `docs/` directory
- Check that GitHub Pages is enabled

## Customization

To customize the landing page:
1. Edit `docs/index.html`
2. Commit and push to the `main` branch
3. The workflow will automatically redeploy

## Testing Locally

To test the static page locally:
```bash
cd docs
python -m http.server 8000
```
Then visit `http://localhost:8000` in your browser.
