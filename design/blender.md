# Blender
## Hotkeys
* `Shift + A`: Add new mesh/curve/etc.
* `F9` to modify its properties. Note you can only do this at the start, before it becomes a mesh! Once it becomes a mesh, it is a set of faces, vertices, and edges rather than a representation of parameters, so you can no longer adjust it. Even deselecting it will create the mesh, so to adjust it then you'll need to delete it and add it again!
* `N`: Transform properties.
* `S`: Scale the model (size will change in transform properties).
* `Alt + S`: Scale along NORMALS (loodrechte op het vlak); in other words it moves each vertex in the direction of its local normal, shrinking or fattening the mesh.
* `TAB`: Edit mode, for editing vertices in the model.
* `G`: Grab a vertex (after selecting it) to move it.
* `E`: Extrude (duplicate selected vertices to create more mesh)
* `H` and `Alt + H`: Temporarily hide and unhide an element.
* `CTRL + Alt + 0`: Change camera perspective to what is visible.
* `Z`: Switch between different previews: solid, rendered, wireframe or material preview (if shadows are not showing, make sure you're in rendered mode).
* `/`: Go into "Local View", which isolates the selected object by hiding other objects.
* `CTRL + P`: Parenting; attaches one object to another. Select both objects, with the base object last, then press `CTRL + P`.

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
* `CTRL + R` to remesh: increase the vertices and polygons.
* Use **masking (`SHIFT + 7`)** to control which part of the mesh is influenced by sculpting. `CTRL + I` to invert a mask.

### Texture Paint
> **Note that Texture Painting does not get saved automatically within the Blender file!!!**  
> You need to separately save it in an image file.

### Animation
* `I`: Insert keyframe.


#### Graph editor (left tab)
Hit `Home` to see everything.

## Geometry Nodes
> **To recover lost geometry nodes:**  
> Place mouse in node panel and press `HOME`.  
> (Also make sure the right object is selected!)

* `Ctrl + J`: Create a frame over the geometry node, e.g. for giving it a title/comment.