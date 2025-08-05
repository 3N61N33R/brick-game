//TEAM IGUANA
// PROJECT 1 - ARKANOID CLONE

Paddle paddle; //declare an object of the Paddle class
Ball ball; // declare a ball object
Brick[] []bricks; // Declare an array of Brick objects

int rows  = 5;
int cols = 10;
float brickWidth = 70;
float brickHeight = 20;
float xOffset = 20;
float yOffset = 50;


void setupBricks() {
  bricks = new Brick[rows][cols];
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      float x = xOffset + c * (brickWidth + 5);
      float y = yOffset + r * (brickHeight + 5);
      color c_ = color(random(100, 255), random(100, 255), random(100, 255));
      bricks[r][c] = new Brick(x, y, brickWidth, brickHeight, c_);
    }
  }
}



void setup(){
  size(800,600);
  paddle = new Paddle(width/2-50, height - 50, 100, 20, 5, color(0, 120, 255));
  ball = new Ball(width/2, height/2, 20, 3, -3, color(0, 255, 0));
  setupBricks();
}

void resetGame() {
    paddle = new Paddle(width / 2 - 50, height - 50, 100, 20, 5, color(0, 120, 255));
    ball = new Ball(width / 2, height / 2, 20, 3, -3, color(0, 255, 0));
    setupBricks();
  }

void draw(){
  background(0);
  
  // Update & draw paddle
  paddle.update();
  paddle.display();
  
  // update & draw ball
  ball.update();
  ball.checkPaddle(paddle);
  ball.display();
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Brick b = bricks[r][c];
      if (!b.isDestroyed && b.checkCollision(ball)) {
        ball.ySpeed *= -1;
      }
      b.display();
    }
  }

  // Reset ball if it falls below screen
  if (ball.y > height) {
    resetGame(); 
}
}
