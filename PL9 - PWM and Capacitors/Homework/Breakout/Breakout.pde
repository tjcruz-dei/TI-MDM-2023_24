/** A simple Breakout game */
import processing.sound.*;
import processing.serial.*;

 
SoundFile ding;


// the main game elements; all self-explanatory
Ball g_ball;
Paddle g_paddle;
Brick[] g_bricks;

final int NUM_ROWS = 10;
final int NUM_COLUMNS = 16;
final int NUM_BRICKS = NUM_ROWS * NUM_COLUMNS;

float BRICK_WIDTH  = 0;
float BRICK_HEIGHT = 0;

final float BRICK_LEFT = 10; // x-coordinate of first column of bricks
final float BRICK_TOP = 10;  // y-coordinate of first row of bricks

final float PADDLE_WIDTH = 80;
final float PADDLE_HEIGHT = 20;
float PADDLE_Y = 680;
final float PADDLE_SPEED = 8;

final float BALL_RADIUS = 10;
final float BALL_SPEED = 2;

void setup()
{
  //size(980, 600);
  fullScreen(P3D);
  background(255);
  PADDLE_Y = height-80;
  BRICK_WIDTH=(width/(NUM_COLUMNS+4));
  BRICK_HEIGHT=(height/3)/NUM_ROWS;
  ding = new SoundFile(this,"ding.mp3");
  
   
  init();
  delay(2000);
}

void init(){
   // ball starts "resting" on the paddle
   g_ball = new Ball(width / 2, PADDLE_Y - BALL_RADIUS);
   g_paddle = new Paddle();

   g_bricks = new Brick[NUM_BRICKS];
  
  int i = 0;
  
  float y = 10; // start y-coordinate at 10 and go down
  
  for(int row = 0; row < NUM_ROWS; row++)
  {
    float x = (width-(NUM_COLUMNS*BRICK_WIDTH))/2; // start x-coordinate at 10 and go across
    for(int column = 0; column < NUM_COLUMNS; column++)
    {
      g_bricks[i] = new Brick(x, y);
      i++;
      x += BRICK_WIDTH;
    }
    y += BRICK_HEIGHT;
  }
}

void draw()
{
  background(255);
  if(g_ball.getY()  >= PADDLE_Y)
  {
    delay(4000);
    init();
  }
  
  g_ball.draw();
  g_paddle.draw();
  
  g_ball.update();
  g_paddle.update();
  
  for(Brick b : g_bricks)
  {
    b.draw();
    b.collide();
  }
  
  // check for loss condition: ball off bottom of screen
  if(g_ball.getY()  >= PADDLE_Y)
  {
    textAlign(CENTER);
    textSize(60);
    stroke(0);
    text("You lose", (width / 2), height / 2);
  }
}

class Brick
{
  float g_x, g_y;
  color g_color;
  
  boolean g_hit; // false is "not hit yet"; true is "hit"
  
  // create a Brick at the given location
  Brick(float x, float y)
  {
    g_x = x;
    g_y = y;
    g_color = color(random(0, 256), random(0, 256), random(0, 256));
    g_hit = false;
  }
  
  void draw()
  {
    if(!g_hit) // only draw if the brick has not yet been hit
    {
      fill(g_color);
      stroke(0);
      rect(g_x, g_y, BRICK_WIDTH, BRICK_HEIGHT);
    }
  }
  
  void collide()
  {
    if(g_hit)
    {
      return; // no double hits
    }
    
    // test whether ball has hit the top
    if(g_ball.getX() > g_x - BALL_RADIUS &&
       g_ball.getX() < g_x + BRICK_WIDTH + BALL_RADIUS &&
       abs(g_ball.getY() - (g_y - BALL_RADIUS)) < 3)
    {
      g_hit = true;
      g_ball.bounceUp();
      ding.play();
    }
    
    // test whether ball has hit the bottom
    if(g_ball.getX() > g_x - BALL_RADIUS &&
       g_ball.getX() < g_x + BRICK_WIDTH + BALL_RADIUS &&
       abs(g_ball.getY() - (g_y + BRICK_HEIGHT + BALL_RADIUS)) < 3)
    {
      g_hit = true;
      g_ball.bounceDown();
      ding.play();
    }
    
    // test whether ball has hit the left
    if(g_ball.getY() > g_y - BALL_RADIUS &&
       g_ball.getY() < g_y + BRICK_HEIGHT + BALL_RADIUS &&
       abs(g_ball.getX() - (g_x - BALL_RADIUS)) < 3)
    {
      g_hit = true;
      g_ball.bounceLeft();
      ding.play();
    }
       
    // test whether ball has hit the right
    if(g_ball.getY() > g_y - BALL_RADIUS &&
       g_ball.getY() < g_y + BRICK_HEIGHT + BALL_RADIUS &&
       abs(g_ball.getX() - (g_x + BRICK_WIDTH + BALL_RADIUS)) < 3)
    {
      g_hit = true;
      g_ball.bounceRight();
      ding.play();
    }
  }
}

class Ball
{
  float g_x, g_y;       // location
  float g_velX, g_velY; // velocity
  
  // create ball at given location
  Ball(float x, float y)
  {
    g_x = x;
    g_y = y;
    
    g_velX = BALL_SPEED;
    g_velY = -BALL_SPEED;
  }
  
  void draw()
  {
    stroke(0);
    fill(255, 0, 0);
    ellipse(g_x, g_y, BALL_RADIUS * 2, BALL_RADIUS * 2);
  }
  
  void update()
  {
    g_x += g_velX;
    g_y += g_velY;
    
    // bounce off walls and ceiling -- but not floor
    if(g_x < BALL_RADIUS)
    {
      bounceRight();
    }
    if(g_x > width - BALL_RADIUS)
    {
      bounceLeft();
    }
    if(g_y < BALL_RADIUS)
    {
      bounceDown();
    }
    // bounce up only if the ball hits the paddle
    if(g_y > PADDLE_Y - BALL_RADIUS &&
       g_x > g_paddle.getX() - BALL_RADIUS &&
       g_x < g_paddle.getX() + PADDLE_WIDTH + BALL_RADIUS)
    {
      bounceUp();
    }
  }
  
  void bounceLeft()
  {
    g_velX = -abs(g_velX);
  }
  
  void bounceRight()
  {
    g_velX = abs(g_velX);
  }
  
  void bounceUp()
  {
    g_velY = -abs(g_velY);
  }
  
  void bounceDown()
  {
    g_velY = abs(g_velY);
  }
  
  // accessor function for g_x
  float getX()
  {
    return g_x;
  }
  
  // accessor function for g_y
  float getY()
  {
    return g_y;
  }
}

class Paddle
{
  float g_x; // just the x-coordinate needed, as the y-coordinate is constant
  
  Paddle() // no parameters: always create in the middle
  {
    g_x = width / 2 - PADDLE_WIDTH / 2;
  }
  
  void draw()
  {
    stroke(0);
    fill(0, 0, 255);
    rect(g_x, PADDLE_Y, PADDLE_WIDTH, PADDLE_HEIGHT);
  }
  
  void update()
  {
    // these if-statements look to see if any key is down (that's what keyPressed says)
    // and then, whether the key is the right (respectively, left) arrow. See the
    // reference.
    if(keyPressed && keyCode == RIGHT)
    {
      g_x += PADDLE_SPEED;
    }
    if(keyPressed && keyCode == LEFT)
    {
      g_x -= PADDLE_SPEED;
    }
    
    // the constrain() function clamps a value between two limits. Here, we don't want
    // to let the paddle wander off the screen.
    g_x = constrain(g_x, 0, width - PADDLE_WIDTH);
  }

  // an accessor for the paddle's location -- needed to implement ball bouncing  
  float getX()
  {
    return g_x;
  }
}
