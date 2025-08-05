//Ball

class Ball {
  float x, y;
  float diameter;
  float xSpeed, ySpeed; // how much the ball moves per frame in each direction
  color ballColor;
  
  // constructor

  Ball(float startX, float startY, float d, float xs, float ys, color c) {
    x = startX;
    y = startY;
    diameter = d;
    xSpeed = xs;
    ySpeed = ys;
    ballColor = c;
  }

  void display() {
    fill(ballColor);
    ellipse(x, y, diameter, diameter);
    
  }

  void update() {
    x += xSpeed;
    y += ySpeed;

  
    if (x < 0 || x > width) xSpeed *= -1;
    if (y < 0) ySpeed *= -1;
  }
  
  void checkPaddle(Paddle p) {
    // Calculate next position of the ball
    float nextX = x + xSpeed;
    float nextY = y + ySpeed;

    // Check for collision with paddle at next position
    if (nextX + diameter/2 > p.x && nextX - diameter/2 < p.x + p.w &&
        nextY + diameter/2 > p.y && nextY - diameter/2 < p.y + p.h) {   
          // If collision is detected, move ball back to just before collision
          // and then reverse ySpeed
          y = p.y - diameter/2; // Snap to top of paddle
          ySpeed *= -1;
          
          // Add some angle based on where the ball hit the paddle
          float hitPos = (x + diameter/2 - p.x) / p.w; // 0 to 1 across paddle
          float angle = map(hitPos, 0, 1, PI + QUARTER_PI, TWO_PI - QUARTER_PI); // Angle from 135 to 45 degrees
          xSpeed = 5 * cos(angle);
          ySpeed = 5 * sin(angle);

          // Increase ball speed
          if (abs(xSpeed) < 10) xSpeed *= 1.05;
          if (abs(ySpeed) < 10) ySpeed *= 1.05;
    }
  }

}
