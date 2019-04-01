# Creating icons, logos and favicons with Inkscape / GIMP
## Changing Inkscape Document Boundary
* To change the Document Boundary to a better size, and “Crop” our output,
first draw a rectangle over where you want to “crop” the document to.
For a square image, hold down the 'Control' key while using the rectangle tool.   

* Then, select the black box, and go to `File` > `Document Properties...` > `Resize Page to Content...`,
and choose `Resize Page to Drawing or Selection`. The Page boundary should resize to the size of the box.
You can delete the black box now.

* You can also do this on a blank canvas to permanently turn the small rectangular work area into a larger square one;
save the modified blank canvas as 'default.svg' in the Inkscape templates folder (`~/.config/inkscape/templates`).   
When starting up Inkscape, it should now open up in the template's square work area.

## Creating a favicon.ico with 4 png sizes
* Use Inkscape to create 4 sizes png: 16x16, 24x24, 32x32 and 64x64.  
`File` > `Export PNG Image...` > Choose the size and click `Export`.  
If your image is not square, change the document boundary as above.

* Open the smallest .png in GIMP, right-click on the image and select `File` > `Open as Layers...`,
and select the other 3 png images.

* This will create a single image with 4 layers containing each of the other png images.

* Export the image as a Microsoft Windows Icon (.ico) image:   
`File` > `Export As...`, and then type in the filename, e.g. favicon.ico.  
Typing .ico in the filename will automatically select the .ico format!  
Click `Export`; if everything is correct, you should be presented with the 4 png images we selected for the .ico.  
Check the boxes for `Compressed`, so the .ico doesn't get too large and click `Export` again.  
You should now have the favicon.ico available.

## Creating a new png image from selection
* Open the image in GIMP, and use the `Rectangle Select Tool` to select the part you want to keep.  
If you want a square selection, push and hold Shift after you started dragging.  
Use the `Ellipse Select Tool` for an ellipse/circle.

* Right-click the selection, and click `Edit` > `Copy`.

* Create a new file by clicking `File` > `New...` and specifying your dimensions.

* In the new file, right-click the canvas and click `Edit` > `Paste`.

* In the layer section, right-click the pasted layer and click `To New Layer`.

* With the layer selected, click `Layer` in the menu > `Scale Layer...`.
Enter the dimensions you wish to scale the layer to (most likely the same as the file's dimensions).

## Converting a png image to svg
* Open the png image with Inkscape. Choose `Link`, `From file` and `Smooth (optimizeQuality)` in the radio buttons.

* Select the image. In the menu, go to `Path` > `Trace Bitmap...` >  In the `Multiple scans` section,
select `Colors` and check `Remove background` if you want no background.

* Click ok, and close the window. Now drag your image down, and you will see there is another one right below it;  
the one you dragged away is the svg, and the bottom one is the png. Delete the png image.

* In the menu, go to `File` > `Save As...` > and select `Optimized SVG (*.svg)` in the filetype dropdown.   
This is important! Do not select any of the other svg types like 'Inkscape SVG'. Click `Save`.

* All done. The saved svg image is identical to the png image but without background.
