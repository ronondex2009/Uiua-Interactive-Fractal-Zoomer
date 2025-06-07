# Uiua Interactive Fractal Zoomer
Uiua program that uses Marcos-cat/Iris library to render an application window.

Features
  - Interactive window using Iris
  - Chunked threading
  - Lazy rendering when moving
  - Shifting view through Z plane
  - Text in top-left corner
  - Burning ship and mandelbrot sets

Thank you to jan Makoso for helping with this project!

![image](https://github.com/user-attachments/assets/70a02481-bdf9-4091-96c7-d1b9c16254d9) 

## Controls
**Left Mouse Drag** - Pan

**Right Mouse Drag** - Pan (Z Plane)

**Scroll Wheel** - Zoom

**R** - Reset location in the Z plane

**T** - Toggle Force-Lazy rendering

Lazy rendering decreases the quality of the rendering by four times panning or zooming until you're done and renders at full quality. This is done to make movement less annoying.
Force-Lazy rendering forces this on constantly if you want to move around and zoom a lot. You can then toggle it back off and let it render in full quality on what you want to see.
This program is very resource-intensive. It runs on the CPU, and uses threading to render faster at the cost of resource usage.
Sadly, there is a limit to how far you can zoom in before uiua's 64 bit floating point limit is reached. You will know when you get there!

You can toggle between normal and burning ship rendering in the program as a binding. Burning ship is the default just because I think it looks cool and forgot to turn it off.

When closed, the program will output in the console the real and imaginary coordinates (C plane) as well as the zoom factor you were at before closing the program.
You can use put that into another program to render in high definition that part of the fractal in different ways, if you'd like!

Have fun!
