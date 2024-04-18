public class Grid {
  protected int columns = 1, rows = 1;
  protected int width = 1, height = 1;
  private boolean drawGrid = true;
  protected Cell [][] cells;

  protected int maxForce = 100;
  protected float forceInc = 8;
  protected float forceIncNeg = 2;

  protected int threshold = 10;
  private float [][] motion;

  private ArrayList <PVector> activeCells = new ArrayList <PVector>();

  public Grid (int columns, int rows, int width, int height) {
    this.columns = columns;
    this.rows = rows;
    this.width = width;
    this.height = height;

    this.cells = new Cell [columns][rows];
    for (int x=0; x<this.columns; x++) {
      for (int y=0; y<this.rows; y++) {
        this.cells[x][y] = new Cell(this, this.width/columns, this.height/rows);
      }
    }
  }

  public void update(PImage dif) {
    activeCells.clear();
    motion = detectMovement(dif, this.rows, this.columns, this.threshold);

    // debug
    // plot data
    // for (int x=0; x<this.columns; x++) {
    //   for (int y=0; y<this.rows; y++) {
    //    if (motion[x][y] > 0) println(x, y, motion[x][y]);
    //  }
    // }

    for (int x=0; x<this.columns; x++) {
      for (int y=0; y<this.rows; y++) {
        this.cells[x][y].active = motion[x][y]>0;
        if (this.cells[x][y].isActive()) {
          this.cells[x][y].updateForce(this.forceInc);
        } else {
          this.cells[x][y].updateForce(-this.forceIncNeg);
        }

        float currentForce = this.cells[x][y].getForce();
        if (currentForce>0) {
          this.activeCells.add(
            new PVector (
            x * this.cells[x][y].width + this.cells[x][y].width/2,
            y * this.cells[x][y].height + this.cells[x][y].height/2,
            currentForce));
        }
      }
    }

    // printArray(activeCells);
  }

  public void draw () {
    for (int x=0; x<this.columns; x++) {
      for (int y=0; y<this.rows; y++) {
        if (this.drawGrid) {
          this.cells[x][y].draw(x, y);
        }
      }
    }
  }
  
  public ArrayList <PVector> getActivePos() {
    return this.activeCells;
  }

  public String toString () {
    return "grid {columns="+this.columns+", rows="+this.rows+", width="+this.width+", height="+this.height;
  }
}

public class Cell {
  protected int width = 1, height = 1;
  protected float force = 0;
  private Grid parent;
  protected boolean active;

  public Cell (Grid g, int width, int height) {
    this.parent = g;
    this.width = width;
    this.height = height;
  }

  public void draw (int x, int y) {
    push();
    int posX = x*this.width;
    int posY = y*this.height;

    stroke(255, 0, 0);

    if (this.force > 0) {
      fill(255, 0, 0);
      float h =  map(this.force, 0, parent.maxForce, 0, this.height);
      rect(posX, posY, this.width, h);
    }

    // debug
    // if (this.active) {
    //   fill(255, 0, 0);
    // } else {
    //   noFill();
    // }

    noFill();
    rect(posX, posY, this.width, this.height);
    // fill(255, 0, 0);
    // text(force, posX+this.height/2-textWidth(""+force)/2, posY+this.height/2);
    // text(current, posX+this.height/2-textWidth(""+current)/2, posY+this.height/2+20);
    pop();
  }

  protected void updateForce (float inc) {
    this.force = this.force + inc;
    this.force = constrain(this.force, 0, parent.maxForce);
  }

  public boolean isActive () {
    return this.active;
  }

  public float getForce() {
    return this.force;
  }
}
