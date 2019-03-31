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
