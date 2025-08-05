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
    if (x + diameter/2 > p.x && x - diameter/2 < p.x + p.w &&
        y + diameter/2 > p.y && y - diameter/2 < p.y + p.h) {   
          ySpeed *= -1;
          y = p.y - diameter/2; // bounce on top of paddle
    }
  }

}
