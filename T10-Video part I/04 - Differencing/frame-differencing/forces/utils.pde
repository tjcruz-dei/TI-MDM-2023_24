// Calculate the difference between two frames
public PImage frameDifference (PImage previous, PImage current) {
  PImage dif = new PImage(current.width, current.height, ARGB);
  for (int i =0; i <current.pixels.length; i++) {
    color currentP = current.pixels[i];
    color previousP = previous.pixels[i];
    if (abs(previousP - currentP) > 3000000 ) {
      dif.pixels[i] = color(255);
    }
  }
  return dif;
}

// Calculate the amount of movement in each cell 
// (based on the pixel brightness)
public float [][] detectMovement (PImage frameDif, int rows, int columns, int threshold) {
  if (rows <= 0) rows = 1;
  if (columns <= 0) columns = 1;

  float motion [][] = new float [columns][rows];

  int wid = frameDif.width / columns;
  int hei = frameDif.height / rows;

  for (int x=0; x<columns; x++) {
    for (int y=0; y<rows; y++) {
      PImage sample = frameDif.copy().get(x*wid, y*hei, wid, hei);
      int sum = 0;      
      for (int i=0; i <sample.pixels.length; i++) {
        sum+= brightness(sample.pixels[i]);
      }
      float mean = sum/sample.pixels.length;
      motion[x][y] = mean > threshold ? mean : 0;
    }
  }
  
  // debug
  // image(sample, x*wid, y*hei);

  return motion;
}
