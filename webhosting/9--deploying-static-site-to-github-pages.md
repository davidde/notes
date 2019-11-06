# Deploying a static site to Github Pages
There are 2 types of GitHub Pages:

* **Project Pages:**  
  A separate website for each repo/project you wish to demo.  
  Hosted at `https://<USERNAME|ORGANIZATION>.github.io/<REPO>/`.
* **User/Organization Pages:**  
  A single website per user/organization.  
  Hosted at `https://<USERNAME|ORGANIZATION>.github.io/`.

We will be using the **Project Pages** method in this tutorial.

# Hugo static sites
Check out the complete
[Hugo documentation for Github Pages](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
if you run into trouble.

## Deploying from a gh-pages branch
We will be deploying our Project Pages from a separate `gh-pages` branch.  
This means source code and generated website are kept in different branches:

  * `master branch`: source code
  * `gh-pages branch`: website built from master branch with the `hugo` command  

In this way we maintain separate version control history for both the source and the 'final' website.

**Steps:**  
* Make sure the public folder is added to your `.gitignore` file:  
  `echo "public" >> .gitignore`  

* Add the correct Project Pages url in your `config.toml` file:
  ```
  baseURL = "https://<USERNAME>.github.io/<REPO>/"
  ```

* Initialize the gh-pages branch as an empty
  [orphan branch](https://git-scm.com/docs/git-checkout/#Documentation/git-checkout.txt---orphanltnewbranchgt):
  ```
  git checkout --orphan gh-pages
  git reset --hard
  git commit --allow-empty -m "Initialize gh-pages branch"
  git push origin gh-pages
  git checkout master
  ```

* Check out the `gh-pages` branch into your public folder using git’s worktree feature.
  Essentially, [git worktree](https://git-scm.com/docs/git-worktree) allows you to have
  multiple branches of the same local repository be checked out in different directories:
  ```
  rm -rf public
  git worktree add -B gh-pages public origin/gh-pages
  ```

* Regenerate the site using the hugo command and commit the generated files on the gh-pages branch:
  ```
  hugo
  cd public && git add --all && git commit -m "Publishing to gh-pages" && cd ..
  ```

* If the gh-pages build looks alright, push it to the remote repo:
  ```
  git push origin gh-pages
  ```

* If your site does not appear at `https://<USERNAME>.github.io/<REPO>/`,
  check if your project's settings are properly configured.
  You can find these at the top of your project's url, `https://github.com/<USERNAME>/<REPO>`.
  (In the same row as 'Code', 'Issues' and 'Pull requests').  
  Scroll down in the Settings tab until you encounter the 'Github Pages' section.  
  Make sure the source is properly configured as the `gh-pages branch`.  
  When everything is set up right, it should say:  
  `Your site is published at https://<USERNAME>.github.io/<REPO>/`  

## Put it all in a shell script
To automate all of this for new commits, you can create a publish.sh script:  
`$ cat > publish.sh`  
```bash
#!/bin/sh

# This script automatically deploys the current branch to github pages:
# - It generates a new build from the current branch
# - Commits it to the local gh-pages branch
# - Pushes both the master and gh-pages branches to the remote

if [ "`git status -suno`" ]
# -suno = --short --untracked-files=no
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publish to gh-pages (publish.sh)"

echo "Pushing to github"
git push --all
```
After committing your changes, you can now simply run `./publish.sh` to publish to Github Pages.

## Use Github Actions to publish automatically
> **NOTE:**  
> This method obsoletes the publish.sh script, by redeploying
> automatically whenever the master branch is modified.

* If Github Actions is still in beta, do not forget to
[sign up for the beta](https://github.com/features/actions).

* Add an SSH deploy key:  
  * Generate it with the following command:  
    ```
    ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""
    ```
  * This will get you 2 files:
    - *gh-pages.pub*: the public key
    - *gh-pages*: the private key
  * Next, go to your repository's **Settings**:
    - Go to **Deploy Keys**, and add the public key with `Allow write access` checked.
    - Go to **Secrets** and add the private key as `ACTIONS_DEPLOY_KEY`.  
      (Note that the **Secrets** tab will not be available if Github Actions is still
      in beta and you haven't signed up!)

* Create your workflow:  
  * Create a `.github/workflows/gh-pages.yml` file for configuring the workflow:  
    ```
    mkdir -p .github/workflows
    touch .github/workflows/gh-pages.yml
    ```
  * Inside `.github/workflows/gh-pages.yml`:  
    ```yml
    name: github pages

    on:
      push:
        branches:
        - master

    jobs:
      build-deploy:
        runs-on: ubuntu-18.04
        steps:
        - uses: actions/checkout@master
          with:
            submodules: true

        - name: Setup Hugo
          uses: peaceiris/actions-hugo@v2.2.3
          with:
            hugo-version: '0.59.0'

        - name: Build
          run: hugo --minify

        - name: Deploy
          uses: peaceiris/actions-gh-pages@v2.5.1
          env:
            ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
            PUBLISH_BRANCH: gh-pages
            PUBLISH_DIR: ./public
    ```
    Make sure that submodules are activated if you're using one
    (see 2 lines below `- uses: actions/checkout@master`),  
    since the build command would fail if the submodule was not present.

  * See [actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) and
    [actions-hugo](https://github.com/peaceiris/actions-hugo) for more information or troubleshooting.

* From now on, every push to master should automatically redeploy Github Pages.

## Turn the static site into a PWA
* Add a `/static/images/icons-192.png` and `/static/images/icons-512.png` image,  
  since they are required for the PWA "Add to Homescreen" prompt.

* Create a manifest file at `static/manifest.json`, and add the before-mentioned icons.  
  Make sure that the `src` attribute does not start with a `/`:
  ```
  {
    "short_name": "site",
    "name": "Full website name and function",
    "icons": [
      {
        "src": "/images/icons-192.png",  <- BAD
        "src": "images/icons-192.png",   <- GOOD!
        "type": "image/png",
        "sizes": "192x192"
      },
      {
        "src": "/images/icons-512.png",  <- BAD
        "src": "images/icons-512.png",   <- GOOD!
        "type": "image/png",
        "sizes": "512x512"
      }
    ],
    "start_url": ".",
    "display": "standalone",
    "theme_color": "#000000",
    "background_color": "#ffffff"
  ￼}
  ```

* Link the manifest.json in the `<head>` section of your website:  
  ```html
  <head>
    <!-- Adding the manifest.json here to get PWA functionality: -->
    <link rel="manifest" href="{{ "manifest.json" | relURL }}">
    <meta charset="utf-8">
    ...
  ```
  If you are using a Hugo theme, you may have to copy the theme's relevant partial
  to your own layout folder, e.g.:
  ```
  cp themes/<theme-name>/layouts/partials/header.html layouts/partials/header.html
  ```
  Now you have your own version of header.html to modify, without polluting the theme's git history.  
  This is the file to add the before-mentioned link to.

* Create the serviceworker that will do the actual work:  
  ```
  curl https://raw.githubusercontent.com/DavidDeprost/mirabello-hugo/master/static/service-worker.js
       --output static/service-worker.js
  ```  
  It should be located right next to the `manifest.json` file in the `static` directory.

* Register the serviceworker at your site's root by adding a registration script.  
  Again, if you're using a theme, you should probably copy the theme's index.html layout to
  your own layouts folder:  
  ```
  cp themes/<theme-name>/layouts/index.html layouts/index.html
  ```
  Now you can modify `layouts/index.html` to include the registration script:
  ```html
  {{ partial "header.html" . }}

  {{if ... }}
  ...
  {{ end }}

  <!-- Serviceworker Registration script: -->
  <script>
    /*
     * Copyright 2015 Google Inc. All rights reserved.
     *
     * Licensed under the Apache License, Version 2.0 (the "License");
     * you may not use this file except in compliance with the License.
     * You may obtain a copy of the License at
     *
     *     http://www.apache.org/licenses/LICENSE-2.0
     *
     * Unless required by applicable law or agreed to in writing, software
     * distributed under the License is distributed on an "AS IS" BASIS,
     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     * See the License for the specific language governing permissions and
     * limitations under the License.
     */
  ￼
    /* eslint-env browser */
    'use strict';
  ￼
    if ('serviceWorker' in navigator) {
      // Delay registration until after the page has loaded, to ensure that our
      // precaching requests don't degrade the first visit experience.
      // See https://developers.google.com/web/fundamentals/
      //             instant-and-offline/service-worker/registration
      window.addEventListener('load', function() {
        // Your service-worker.js *must* be located at the top-level directory
        // relative to your site; it won't be able to control pages unless
        // it's located at the same level or higher than them.
        // *Don't* register service worker file in, e.g., a scripts/ sub-directory!
        // See https://github.com/slightlyoff/ServiceWorker/issues/468
        navigator.serviceWorker.register('service-worker.js').then(function(reg) {
          console.log('Service Worker Registered with Scope:', reg.scope);
          // updatefound is fired if service-worker.js changes.
          reg.onupdatefound = function() {
            // The updatefound event implies that reg.installing is set; see
            // https://w3c.github.io/ServiceWorker/#service-worker-registration-updatefound-event
            var installingWorker = reg.installing;
  ￼
            installingWorker.onstatechange = function() {
              switch (installingWorker.state) {
                case 'installed':
                  if (navigator.serviceWorker.controller) {
                    // At this point, the old content will have been purged
                    // and the fresh content will have been added to the cache.
                    // It's the perfect time to display a "New content is available;
                    // please refresh." message in the page's interface.
                    console.log('New or updated content is available.');
                  } else {
                    // At this point, everything has been precached.
                    // It's the perfect time to display a
                    // "Content is cached for offline use." message.
                    console.log('Content is now available offline!');
                  }
                  break;
  ￼
                case 'redundant':
                  console.error('The installing service worker became redundant.');
                  break;
              }
            };
          };
        }).catch(function(e) {
          console.error('Error during service worker registration:', e);
        });
      });
    }
  ￼</script>

  {{ partial "footer.html" . }}
  ```

* Your static site should now also be a PWA.  
  If you do not get the "Add to Homescreen" prompt, here's how to troubleshoot:  
  - Open Chrome Devtools and click the `Audits` tab.
  - Uncheck everything except 'Progressive Web App', and click `Run Audits`.
  - You will be presented with the PWA requirements you do not fulfill yet.

## Adding Netlify CMS to an existing GitHub Pages Hugo site
> **GOALS:**  
> * Functioning CMS for static Hugo site.
> * Hosted by GitHub Pages, not Netlify.
> * Logging into the CMS through GitHub OAuth, with Netlify auth server (not git-gateway).  
>   (Note that unlike Gitlab, Github OAuth does not support *implicit grant*, which means that  
>   **every login through GitHub requires a server-side Oauth component**.  
>   Netlify is so kind to provide such an auth server completely free of charge  
>   at `https://api.netlify.com/auth/done`, which we will be using.)

This method is based on a [blog post](https://cnly.github.io/2018/04/14/just-3-steps-adding-netlify-cms-to-existing-github-pages-site-within-10-minutes.html)
by [Alex Chen](https://github.com/Cnly).  
On top of that, the [Netlify CMS Docs](https://www.netlifycms.org/docs/add-to-your-site/)
are *really* useful!

### 1. Creating a GitHub OAuth App
* Go to [GitHub Dev Settings](https://github.com/settings/developers) and click **New OAuth App**.

* Enter the **Application name**; for maximal transparency the repository's name
  is most convenient here.
  
* Enter the **Homepage URL**; either your project pages URL (`https://<USERNAME>.github.io/<REPO>/`)
  or a custom domain name.

* In **Authorization callback URL**, enter `https://api.netlify.com/auth/done`.

* When finished, keep the page open; we still need to add the **Client ID** and
  **Client Secret** to the Netlify site.

### 2. Creating a Netlify Site
**Note:**
This Netlify site is required for logging into the CMS, since the auth server cannot be hosted on Github Pages.
As such, the content of the site is irrelevant; its only function is providing the authentication.

* Log into your Netlify account and create a new site from any repo;
  we aren't using this site anyway.

* Go to **Settings**, and copy your **Site name**. It should be something like `zen-mestorf-23ec0c`.

* From the sidebar go to **Domain Management** and add your GitHub Pages domain (`<USERNAME>.github.io`)
  as a custom domain. Choose **Yes** when asked if you are `github.io`’s owner.

* From the sidebar go to **Access control**, scroll down to **OAuth** and click **Install provider**.

* Choose **GitHub** as provider, and enter the **Client ID** and **Client Secret**
  from the GitHub OAuth app page mentioned above.

### 3. Installing Netlify CMS
The most straightforward way for installing Netlify CMS is by simply adding its files,
an `index.html` and `config.yml` file, to our static site in an **admin** folder.
For Hugo this admin folder should be located in the static folder:  
```
mkdir static/admin
cd static/admin
touch index.html config.yml
```

* The `admin/index.html` file is the entry point for the Netlify CMS admin interface;
  this means that users should navigate to `https://<USERNAME>.github.io/<REPO>/admin/` to log in.
  On the code side, it's a basic HTML starter page that loads the Netlify CMS JavaScript file.
  It should look like this:
  ```html
  <!doctype html>
  <html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Content Manager</title>
  </head>
  <body>
    <!-- Include the script that builds the page and powers Netlify CMS -->
    <script src="https://unpkg.com/netlify-cms@^2.0.0/dist/netlify-cms.js"></script>
  </body>
  </html>
  ```

* The `admin/config.yml` file is the heart of your Netlify CMS installation, and a bit more complex.
  See the [Configuration](https://www.netlifycms.org/docs/add-to-your-site/#configuration)
  and [Collection fields](https://www.netlifycms.org/docs/configuration-options/#fields) sections
  of the Netlify CMS Docs for more details.

  It should look something like this:
  ```yml
  backend:
    name: github
    repo: <USERNAME>/<REPO>
    branch: master
    site_domain: zen-mestorf-23ec0c.netlify.com

  # Use this if you don't want to commit directly to the publication branch,
  # and add an interface for drafting, reviewing, and approving posts:
  # publish_mode: editorial_workflow

  # Media files will be stored in the repo under static/images/uploads:
  media_folder: "static/images/uploads"
  # The src attribute for uploaded media will begin with /images/uploads:
  public_folder: "/images/uploads"

  collections:
    - name: "posts"     # Used in routes, e.g., /admin/collections/posts
      label: "Post"     # Used in the UI
      folder: "content" # The path to the folder where the documents are stored
      create: true      # Allow users to create new documents in this collection
      slug: "{{slug}}"  # Filename template; {{slug}} is a url-safe version of the post's title
      fields:           # The fields for each document, usually in front matter:
      # Fields listed here are shown as fields in the content editor,
      # then saved as front matter at the beginning of the document
      # (except for body, which follows the front matter).
      # Each field contains the following properties:
      # - label: Field label in the editor UI.
      # - name: Field name in the document front matter.
      # - widget: Determines UI style and value data type; When a content editor enters
      #           a value here, that value is saved in the document front matter
      #           as the value for the name specified for the field.
      # - default (optional): Sets a default value for the field.
      # - required (optional): Specify as false to make a field optional; defaults to true.
        - label: "Title"
          name: "title"
          widget: "string"
        - label: "Weight"
          name: "weight"
          widget: "number"
          valueType: "int"
          required: false
        - label: "Publish Date"
          name: "date"
          widget: "datetime"
          required: false
        - label: "Draft"
          name: "draft"
          widget: "boolean"
          required: false
          default: true
        - label: "Body"
          name: "body"
          widget: "markdown"
  ```
  Be sure to replace `zen-mestorf-23ec0c.netlify.com` with the Netlify site you created in step 2.

* Save the files, commit, and push to GitHub.  
  Navigate to `https://<USERNAME>.github.io/<REPO>/admin/` to see your CMS!