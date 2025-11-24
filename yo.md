# Yeoman
Command-line utility for scaffolding new projects.  
It acts as the runtime environment for specialized plugins called Generators.
```bash
# Install Yeoman if you haven’t already:
npm install -g yo
```

## VsCode Extension
* Install the VsCode-specific extension development tooling:
  ```bash
  npm install -g vsce generator-code
  ```
  This installs:
  * `vsce`: the Visual Studio Code Extension Manager;
    this is the official CLI tool for packaging, publishing,
    and managing VS Code extensions.
  * `generator-code`: this is a Yeoman-specific generator
    for VS Code extensions.

* Scaffold a TypeScript extension:
  ```bash
  yo code
  ```

* And choose:
  * "New Extension (TypeScript)"
  * Name: my-extension-name
  * Identifier: my-extension-name
  * Description: My extension description ...
  * Initialize git repository: Yes
  * Bundler: esbuild
  * package manager: npm

* Resulting project:
  ```
  ├───.vscode
    └─> extensions.json
    └─> launch.json
    └─> settings.json
    └─> tasks.json
  ├───node_modules
  └───src
    └───test
      └─> extensions.test.ts
    └─> extensions.ts
  └─> .gitignore
  └─> .vscode-test.mjs
  └─> .vscodeignore
  └─> CHANGELOG.md
  └─> esbuild.js
  └─> eslint.config.mjs
  └─> package-lock.json
  └─> package.json
  └─> README.md
  └─> tsconfig.json
  └─> vsc-extension-quickstart.md
  ```
