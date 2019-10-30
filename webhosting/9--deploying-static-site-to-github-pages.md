# Deploying a static site to Github Pages
There are 2 types of GitHub Pages:

* **Project Pages:**  
  A separate website for each repo/project you wish to demo.  
  Hosted at `https://<USERNAME|ORGANIZATION>.github.io/<PROJECT>/`.
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
  baseURL = "https://<USERNAME>.github.io/<PROJECT>/"
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

* If your site does not appear at `https://<USERNAME>.github.io/<PROJECT>/`,
  check if your project's settings are properly configured.
  You can find these at the top of your project's url, `https://github.com/<USERNAME>/<PROJECT>`.
  (In the same row as 'Code', 'Issues' and 'Pull requests').  
  Scroll down in the Settings tab until you encounter the 'Github Pages' section.  
  Make sure the source is properly configured as the `gh-pages branch`.  
  When everything is set up right, it should say:  
  `Your site is published at https://<USERNAME>.github.io/<PROJECT>/`  

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

## Turn the static site into a PWA
* Add a `/static/images/icons-192.png` and `/static/images/icons-512.png` image,  
  since they are required for the PWA "Add to Homescreen" prompt.

* Create a manifest file at `static/manifest.json`, and add the before-mentioned icons.  
  Make sure that the `src` attribute does not start with a `/`:
  ```
    {
    ￼  "short_name": "site",
    ￼  "name": "Full website name and function",
    ￼  "icons": [
    ￼    {
    ￼      "src": "/images/icons-192.png",  <- BAD
  ￼        "src": "images/icons-192.png",   <- GOOD!
    ￼      "type": "image/png",
    ￼      "sizes": "192x192"
    ￼    },
    ￼    {
    ￼      "src": "/images/icons-512.png",  <- BAD
          "src": "images/icons-512.png",   <- GOOD!
    ￼      "type": "image/png",
    ￼      "sizes": "512x512"
    ￼    }
    ￼  ],
    ￼  "start_url": ".",
    ￼  "display": "standalone",
    ￼  "theme_color": "#000000",
    ￼  "background_color": "#ffffff"
    ￼}
  ```

* Link the manifest.json in the `<head>` section of your website:  
  ```html
    <head>
  ￼    <!-- Adding the manifest.json here to get PWA functionality: -->
  ￼    <link rel="manifest" href="{{ "manifest.json" | relURL }}">
  ￼    <meta charset="utf-8">
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
  ￼  {{ end }}

  <!-- Serviceworker Registration script: -->
  <script>
  ￼    /**
  ￼     * Copyright 2015 Google Inc. All rights reserved.
  ￼     *
  ￼     * Licensed under the Apache License, Version 2.0 (the "License");
  ￼     * you may not use this file except in compliance with the License.
  ￼     * You may obtain a copy of the License at
  ￼     *
  ￼     *     http://www.apache.org/licenses/LICENSE-2.0
  ￼     *
  ￼     * Unless required by applicable law or agreed to in writing, software
  ￼     * distributed under the License is distributed on an "AS IS" BASIS,
  ￼     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ￼     * See the License for the specific language governing permissions and
  ￼     * limitations under the License.
  ￼     */
  ￼
  ￼    /* eslint-env browser */
  ￼    'use strict';
  ￼
  ￼    if ('serviceWorker' in navigator) {
  ￼      // Delay registration until after the page has loaded, to ensure that our
  ￼      // precaching requests don't degrade the first visit experience.
  ￼      // See https://developers.google.com/web/fundamentals/instant-and-offline/service-worker/registration
  ￼      window.addEventListener('load', function() {
  ￼        // Your service-worker.js *must* be located at the top-level directory relative to your site.
  ￼        // It won't be able to control pages unless it's located at the same level or higher than them.
  ￼        // *Don't* register service worker file in, e.g., a scripts/ sub-directory!
  ￼        // See https://github.com/slightlyoff/ServiceWorker/issues/468
  ￼        navigator.serviceWorker.register('service-worker.js').then(function(reg) {
  ￼          console.log('Service Worker Registered with Scope:', reg.scope);
  ￼          // updatefound is fired if service-worker.js changes.
  ￼          reg.onupdatefound = function() {
  ￼            // The updatefound event implies that reg.installing is set; see
  ￼            // https://w3c.github.io/ServiceWorker/#service-worker-registration-updatefound-event
  ￼            var installingWorker = reg.installing;
  ￼
  ￼            installingWorker.onstatechange = function() {
  ￼              switch (installingWorker.state) {
  ￼                case 'installed':
  ￼                  if (navigator.serviceWorker.controller) {
  ￼                    // At this point, the old content will have been purged and the fresh content will
  ￼                    // have been added to the cache.
  ￼                    // It's the perfect time to display a "New content is available; please refresh."
  ￼                    // message in the page's interface.
  ￼                    console.log('New or updated content is available.');
  ￼                  } else {
  ￼                    // At this point, everything has been precached.
  ￼                    // It's the perfect time to display a "Content is cached for offline use." message.
  ￼                    console.log('Content is now available offline!');
  ￼                  }
  ￼                  break;
  ￼
  ￼                case 'redundant':
  ￼                  console.error('The installing service worker became redundant.');
  ￼                  break;
  ￼              }
  ￼            };
  ￼          };
  ￼        }).catch(function(e) {
  ￼          console.error('Error during service worker registration:', e);
  ￼        });
  ￼      });
  ￼    }
  ￼</script>

  {{ partial "footer.html" . }}
  ```

* Your static site should now also be a PWA.  
  If you do not get the "Add to Homescreen" prompt, here's how to troubleshoot:  
  - Open Chrome Devtools and click the `Audits` tab.
  - Uncheck everything except 'Progressive Web App', and click `Run Audits`.
  - You will be presented with the PWA requirements you do not fulfill yet.

## 