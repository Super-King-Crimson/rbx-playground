# playground (template)
- Powered by Rojo

# Getting Started
## brojo.sh
- I've included a helpful bash script called `brojo.sh` in the root of the project.
- To build, serve, and start the lsp all at once, `cd` into the root of this project and run:
```bash
./brojo.sh
```
- It's not a very long script, and all it does is bundle `rojo build`, `rojo serve`, and `rojo sourcemap` into one to make it easier to start working.

## LSP
### Type definitions
- Make sure your LSP is started with the following command:
```bash
luau-lsp lsp --definitions:@roblox=/path/to/globalTypes.d.luau --docs=/path/to/api-docs/en-us.json
```
- You can download globalTypes.d.luau [here](https://luau-lsp.pages.dev/type-definitions/globalTypes.None.d.luau) and the cooresponding documentation [here](https://luau-lsp.pages.dev/api-docs/en-us.json)
- It is recommended to save these files to a place outside of this place file where you won't accidentally delete it (for example, `~/docs/roblox`)
