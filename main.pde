//TEAM IGUANA
// PROJECT 1 - ARKANOID CLONE

Paddle paddle; //declare an object of the Paddle class
Ball ball; // declare a ball object
Brick[][] bricks; // Declare an array of Brick objects

int rows  = 5;
int cols = 10;
float brickWidth = 70;
float brickHeight = 20;
float xOffset = 20;
float yOffset = 50;

int score = 0; // Initialize score

// Game States
final int START = 0;
final int PLAYING = 1;
final int GAME_OVER = 2;
int gameState = START;

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
  resetGame(); // Call resetGame to initialize elements and set initial state
}

void resetGame() {
    paddle = new Paddle(width / 2 - 50, height - 50, 100, 20, 5, color(0, 120, 255));
    ball = new Ball(width / 2, height / 2, 20, 3, -3, color(0, 255, 0));
    setupBricks();
    score = 0; // Reset score on game reset
    // gameState = START; // This line was causing the issue, removed to allow state transition
  }

void draw(){
  background(0);
  
  if (gameState == START) {
    drawStartScreen();
  } else if (gameState == PLAYING) {
    updateGame();
    drawGame();
  } else if (gameState == GAME_OVER) {
    drawGameOverScreen();
  }
}

void updateGame() {
  // Update & draw paddle
  paddle.update();
  
  // update & draw ball
  ball.update();
  ball.checkPaddle(paddle);
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Brick b = bricks[r][c];
      if (!b.isDestroyed && b.checkCollision(ball)) {
        score += 10; // Increment score when a brick is destroyed
      }
    }
  }

  // Check for game over (ball falls below screen)
  if (ball.y > height) {
    gameState = GAME_OVER; 
  }
  
  // Check for win condition (all bricks destroyed)
  boolean allBricksDestroyed = true;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (!bricks[r][c].isDestroyed) {
        allBricksDestroyed = false;
        break;
      }
    }
    if (!allBricksDestroyed) break;
  }
  if (allBricksDestroyed) {
    gameState = GAME_OVER;
  }
}

void drawGame() {
  paddle.display();
  ball.display();
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      bricks[r][c].display();
    }
  }

  // Display score
  fill(255);
  textSize(24);
  text("Score: " + score, 10, 25);

  // Display instructions during gameplay
  fill(255, 150); // Semi-transparent white
  textSize(16);
  textAlign(RIGHT, TOP);
  text("Move: Left/Right Arrow Keys", width - 10, 10);
  text("Speed increases on paddle hit!", width - 10, 30);
}

void drawStartScreen() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("ARKANOID CLONE", width/2, height/2 - 100);
  textSize(24);
  text("Press any key to start", width/2, height/2);
  
  textSize(20);
  text("Controls:", width/2, height/2 + 80);
  text("Left/Right Arrow Keys to Move Paddle", width/2, height/2 + 110);
  text("Ball speed increases on paddle hit!", width/2, height/2 + 140);
}

void drawGameOverScreen() {
  background(0);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(48);
  
  boolean allBricksDestroyed = true;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (!bricks[r][c].isDestroyed) {
        allBricksDestroyed = false;
        break;
      }
    }
    if (!allBricksDestroyed) break;
  }

  if (allBricksDestroyed) {
    text("YOU WIN!", width/2, height/2 - 50);
  } else {
    text("GAME OVER", width/2, height/2 - 50);
  }
  
  fill(255);
  textSize(24);
  text("Final Score: " + score, width/2, height/2 + 20);
  text("Press any key to play again", width/2, height/2 + 60);
}

void keyPressed() {
  if (gameState == START || gameState == GAME_OVER) {
    gameState = PLAYING;
    resetGame();
  }
}

void mousePressed() {
  // No mouse interaction for starting the game, using keyPressed instead
}
