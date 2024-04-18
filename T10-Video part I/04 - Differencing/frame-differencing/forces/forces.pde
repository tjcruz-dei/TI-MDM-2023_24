/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Frame Differencing with force
 *
 * @authors: Sérgio M. Rebelo, Daniel Lopes, and Tiago Martins.
 * @since:   04–05–2023
 * @based:   Feednplay FeedNplay Motion Grid sketch
 */
 
import processing.video.*;

public Capture cam;
public PImage previous;
public int columns = 20;
public int rows = 20;
public Grid grid;

public void setup() {
  String[] devices = Capture.list();
  printArray(devices);

  cam = new Capture(this, devices[0]);
  cam.start();

  previous = cam.copy();
  surface.setSize(cam.width, cam.height);
  
  grid = new Grid (columns, rows, cam.width, cam.height);
}

void draw() {
  if (cam.available()) {
    background(0);
    cam.read();
    PImage dif = frameDifference(previous, cam);
    previous = cam.copy();

    grid.update(dif);
    
    // get active positions
    ArrayList <PVector> activePos = grid.getActivePos();
    for (PVector vec : activePos) {
      // Force of the movement saved in the z position of the vector
      fill(255,255,0, map(vec.z, 0, 100, 0, 255));
      // middle position of the cell
      ellipse(vec.x, vec.y, 10, 10);
    }

    image(dif, 0, 0);
  }
  
  // draw grid
  grid.draw();
}
