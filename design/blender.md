# Blender
## Hotkeys
* `Shift + A`: Add new mesh/curve/etc.
* `F9` to modify its properties.
* `N`: Transform properties.
* `S`: Scale the model (size will change in transform properties).
* `Alt + S`: Scale along NORMALS (loodrechte op het vlak); in other words it moves each vertex in the direction of its local normal, shrinking or fattening the mesh.
* `TAB`: Edit mode, for editing vertices in the model.
* `G`: Grab a vertex (after selecting it) to move it.
* `E`: Extrude (duplicate selected vertices to create more mesh)
* `H` and `Alt + H`: Temporarily hide and unhide an element.

## Actions
* Add more vertices to the mesh:  
  - `Add Modifier > Subdivision Surface`
  - Hit the down arrow to the right of the Subdiv modifier, and click `Apply`. Note that you can't do this in Edit Mode; you need to be in Object Mode!


## Modes
### Sculpt Mode
This mode allows adjusting the mesh with specialized tools:
* Draw Tool (X hotkey): pulls the surface over which we draw out towards us, or digs into it when we hold `CTRL`.
* Grab Tool (G hotkey): Grab a part to pull it out.
  - You can adjust the Radius with the `F` hotkey.
  - You can adjust the Strength with the `Shift + F` hotkey.
* Smooth Tool (Shift+S hotkey): Smoothes over the mesh.
* Inflate Tool (I hotkey): Inflates the mesh, for instance to create droplet like forms (especially with the Airbrush `Stroke Method`).