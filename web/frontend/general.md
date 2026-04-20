# General Tips
## Optimizing SVG's for the web
> [!Important] .ico favicons
> * An `.ico` image as favicon (the image in the browser's tab) is **generally outdated** and only required for ancient browsers.
> * Best practice is to just use a single **`favicon.svg`** instead of a `favicon.ico` (which usually holds multiple images of e.g. 16px, 32px, 64px and 128px).

### Inkscape
* If you create the svg yourself in e.g. Inkscape, make sure to first save the file as an Inkscape SVG: `File > Save As... > Inkscape SVG (.svg)`. This version preserves all Inkscape-specific data, which is necessary if you want to update it later.
* Create an optimized version to put on the web with `File > Save As... > Plain SVG (.svg) or Optimized SVG (.svg)`:
  - **Plain SVG**: Strips out all the "Inkscape-only" data. Best for general use where you want a clean file that still has a **human-readable** code structure.
  - **Optimized SVG**: Removes Inkscape data *and* rewrites the SVG code to be **as small as possible**. Best for production-ready web assets, icons, and animations.

### SVGO
A more general tool for optimizing SVG images for the web is the NodeJS tool [svgo](https://github.com/svg/svgo):
```shell
npm install -g svgo
```
It allows using a config file (e.g. [svgo.config.js](./svgo.config.js)) to easily keep track of your preferred settings:
```
svgo --config=svgo.config.js <SRC> -o <DEST>
```
The `-o` flag can be omitted if you want to replace the input svg with the optimized svg.

### The SVG "Sprite Sheet" Symbol Library Method
Traditionally, the most performant way to include svg images in a webpage was always to just inline them in the HTML directly; there are no additional network requests, and they just load instantly together with the html pages.

However, there are quite a few downsides to doing this. Reusing the svg anywhere else requires a new copy of the svg, which can quickly bloat a site with lots of "technically redundant" code. On top of this, it is a total maintainability nightmare if you ever decide to replace or update those svgs. While this is the fastest method for the initial page load, another big negative is that the code is basically re-downloaded wherever it is used, and never cached by the browser.

A "sprite sheet" or "symbol library" solves most of these problems by putting all svgs together in a large `.svg` file, and referencing them from there. It is completely DRY (you never need to copy anything), and it is nearly as fast as the old fashioned inline/copying method. On top of that the sprite sheet itself is cached by the browser, so it doesn't need to be re-downloaded again.

#### Practically:
* Create the svg file, e.g. `svg-library.svg`:
  ```xml
  <svg xmlns="http://www.w3.org/2000/svg">
    <symbol id="logo" viewBox="0 0 100 100">
      <circle cx="50" cy="50" r="40" stroke="black" fill="red" />
    </symbol>

    <symbol id="arrow" viewBox="0 0 24 24">
      <path d="M5 12h14M12 5l7 7-7 7" stroke="currentColor" fill="none" />
    </symbol>
  </svg>
  ```
* And use it in the HTML like so:
  ```html
  <svg width="50" height="50">
    <use href="svg-library.svg#logo" />
  </svg>

  <svg width="24" height="24" style="color: blue;">
    <use href="svg-library.svg#arrow" />
  </svg>
  ```


## Fonts
The `.woff2` font type is currently the most optimal for the web.

### Glyphhanger (NodeJS)
To further optimize specific fonts, you can use the NodeJS tool Glyphhanger:
```shell
# (Requires Python and fonttools: pip install fonttools)
npm install -g glyphhanger
```

* Subset an existing font to standard Latin characters (English, Spanish, etc.). This can often shrink a font to ~10% its original size:
  ```
  glyphhanger --subset=myfont.ttf --formats=woff2 --LATIN
  ```
* Even more extreme size reduction by analyzing the actual website and create a font containing only the letters visible on the pages:
  ```
  glyphhanger http://localhost:8080 --subset=myfont.ttf
  ```

### Fonttools (Python)
The previously mentioned `fonttools` is also excellent; its `pyftsubset` command gives you the most control:
```shell
# Install:
pip install fonttools brotli

# Subset to Basic Latin / ASCII (U+0000-007F),
# + Euro symbol (U+20AC):
pyftsubset MyFont.ttf --unicodes="U+0000-007F,U+20AC" --flavor=woff2 --output-file=MyFont.subset.woff2
```

## Light/Dark Themes
```css
:root {
  /* Step 1: Tell the browser to support both schemes: */
  color-scheme: light dark;

  /* Step 2: Define your global color variables */
  /* Syntax: light-dark(VALUE_FOR_LIGHT, VALUE_FOR_DARK) */
  --brand-primary: light-dark(#1a1a1a, #ffffff);
  --brand-secondary: light-dark(#0066ff, #5cd6ff);
  --bg-main: light-dark(#ffffff, #121212);
}

/* Optional Third Theme: "Cyberpunk" (Overrides defaults) */
[data-theme="cyberpunk"] {
  /* Manually set variables, ignoring light-dark(): */
  --brand-primary: #ff00ff; /* Neon Pink */
  --bg-main: #000033;      /* Deep Midnight Blue */

  /* Optional: Force browser UI to stay dark for this theme: */
  color-scheme: dark;
}

body {
  /* Works for ALL 3 themes! */
  background-color: var(--bg-main);
  color: var(--brand-primary);
}
```

**DRY and performant:**
- Automatic system-level light/dark switch with zero JavaScript.
- When clicking the `cyberpunk` button, you run `document.documentElement.setAttribute('data-theme', 'cyberpunk')`.
- CSS classes don't change at all, they just keep looking at the CSS vars. Whether the vars are being controlled by `light-dark()` or the `cyberpunk` override is irrelevant.


