# Converting web apps to 'Progressive Web Apps' (PWA's)
## Converting a `Create-react-app` app to PWA
* Register the serviceWorker:  
Go to your `src/index.js` file and change `serviceWorker.unregister();` to `serviceWorker.register();`.

* Create a `/public/images/icons-192.png` and `/public/images/icons-512.png` image,
since they are required for the PWA 'Add to Homescreen' prompt.   
These images will be shown on the splash screen and as launch icons on the homescreen.
They should be `192x192` and `512x512` pixel `.png` image versions of your favicon,
preferably with a visible background. A visible background is preferable since a single-color-no-background image
could end up invisible if the homescreen color palette plays against you.  
This is why the `/public/favicon.ico` is best kept separately; e.g. for displaying without background in browser tabs.

* Modify `/public/manifest.json`'s icons entry to:
  ```
  "icons": [
    {
      "src": "/images/icons-192.png",
      "type": "image/png",
      "sizes": "192x192"
    },
    {
      "src": "/images/icons-512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ],
  ```
  (The favicon entry can be deleted since the icons will replace it now.  
  However, the `public/favicon.ico` image itself should not be deleted since it's still used for regular browser tabs;   
  it's still included through the `<link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">` tag in `public/index.html`.)

* Push your changes to Github.

* Pull your changes on VPS.

* $ `npm run build`   
(If you added any packages, don't forget to run `npm install` first!)

* If necessary, restart Nginx:   
$ `sudo service nginx restart`   

* Debugging any issues:   
Open Chrome Devtools, click the `Audits` tab, and in the 'Audits' section of it,
uncheck everything except 'Progressive Web App'.
Then, click `Run Audits`, and you will be presented with the PWA requirements you do not fulfill yet.

* For testing purposes:  
If you have uninstalled your PWA on your phone, and you do not get the install prompt again,
clear out the cookies for the website.
In Google Chrome, this is done in 'History' > 'Clear browsing data' > Uncheck everything except
'Cookies and other site data'.   
If you want to delete cookies from a single site, go to 'Settings' > 'Advanced' > 'Privacy and security' >
at the bottom of the section: 'Content settings' > 'Cookies' > 'See all cookies and site data' >
Find the specific site in the list and remove its data.

* Obsolete serviceworkers often have a nasty habit of sticking around, resulting in the error:
  ```
  ￼A bad HTTP response code (404) was received when fetching the script.
  Failed to load resource: net::ERR_INVALID_RESPONSE
  ```
  To fix this, the serviceworker should be removed, which can be tricky since it's hard to track where it was added.  
  To conveniently remove it, run this in the browser's console:
  ```
  navigator.serviceWorker.getRegistrations().then(function(registrations) {
    for(let registration of registrations) { registration.unregister() }
  })
  ```
