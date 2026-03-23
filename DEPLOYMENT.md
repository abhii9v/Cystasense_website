# GitHub Pages Deployment Guide

This document explains how to deploy the CystaSense landing page to GitHub Pages.

## What Has Been Set Up

1. **Static Landing Page** (`docs/index.html`)
   - A static HTML version of the CystaSense landing page
   - No server-side dependencies
   - Uses Bootstrap 5 and Bootstrap Icons from CDN
   - Fully responsive design

2. **GitHub Actions Workflow** (`.github/workflows/deploy.yml`)
   - Automatically deploys the `docs/` directory to GitHub Pages
   - Triggers on pushes to the `main` branch
   - Can also be manually triggered

## How to Enable GitHub Pages

To complete the deployment, you need to enable GitHub Pages in your repository settings:

### Step 1: Navigate to Repository Settings
1. Go to your GitHub repository: `https://github.com/abhii9v/Cystasense_website`
2. Click on **Settings** (top menu)
3. Click on **Pages** in the left sidebar (under "Code and automation")

### Step 2: Configure GitHub Pages
1. Under "Build and deployment":
   - **Source**: Select "GitHub Actions"
2. Save the settings

### Step 3: Merge This Branch
1. Merge this branch (`claude/deploy-to-github-pages`) into your `main` branch
2. The GitHub Actions workflow will automatically run
3. Your site will be deployed to: `https://abhii9v.github.io/Cystasense_website/`

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
