# Deploy CystaSense Website to GitHub Pages - Quick Start Guide

## Current Status
- ✅ Static landing page created in `docs/index.html`
- ✅ GitHub Actions workflow configured (`.github/workflows/deploy.yml`)
- ⚠️ **GitHub Pages NOT ENABLED** - This is blocking deployment

## Quick Deployment Steps

### Step 1: Enable GitHub Pages (Required!)

1. Go to your repository on GitHub: https://github.com/abhii9v/Cystasense_website
2. Click **Settings** (in the top menu bar)
3. In the left sidebar, click **Pages** (under "Code and automation")
4. Under "Build and deployment":
   - **Source**: Select **"GitHub Actions"** from the dropdown
5. Click **Save** (if applicable)

### Step 2: Merge This Branch or Manually Trigger Workflow

**Option A: Merge to Main (Recommended)**
1. Create a pull request from `claude/deploy-website-now` to `main`
2. Merge the pull request
3. The workflow will automatically run and deploy your site

**Option B: Manual Trigger**
1. Go to the **Actions** tab in your repository
2. Click on "Deploy to GitHub Pages" workflow
3. Click "Run workflow" button
4. Select the `main` branch
5. Click "Run workflow"

### Step 3: Access Your Deployed Website

After the workflow completes successfully (takes ~1-2 minutes):
- Your site will be live at: **https://abhii9v.github.io/Cystasense_website/**

## Troubleshooting

### Workflow Still Failing?
If you enabled GitHub Pages but the workflow still fails:
1. Wait 1-2 minutes after enabling Pages
2. Re-run the workflow from the Actions tab
3. Check that "Source" is set to "GitHub Actions" (not "Deploy from a branch")

### Can't Find Pages Settings?
- Make sure you're in the repository **Settings** (not your account settings)
- Pages option is in the left sidebar under "Code and automation"
- If you don't see Pages, check that your repository is public

### 404 Error on Website?
- Wait a few minutes after deployment completes
- Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Verify the workflow completed successfully in the Actions tab

## What Gets Deployed?

The static landing page includes:
- Responsive design with Bootstrap 5
- Information about CystaSense features
- Links to the GitHub repository
- Mobile-friendly layout

## Important Notes

### This is a Static Landing Page
- The deployed site is **static HTML only** (no backend)
- It serves as an informational landing page
- The full Flask application with database, authentication, and features requires separate deployment

### For Full Application Deployment
To deploy the complete Flask application with all features:
- Requires a platform supporting Python/Flask (Render, Railway, Heroku, etc.)
- Needs PostgreSQL database
- Requires environment variables setup
- See `README.md` for full application setup

## Need Help?
- Check the Actions tab for detailed workflow logs
- Review `DEPLOYMENT.md` for more detailed information
- Ensure GitHub Pages source is set to "GitHub Actions"
