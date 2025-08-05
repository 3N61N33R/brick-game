// Paddle

class Paddle{
  float x, y;
  float w, h;
  float speed;
  color paddleColor;
  
  // constructor
  
  Paddle(float startX, float startY, float pw, float ph, float s, color c){
    x = startX;
    y = startY;
    w = pw;
    h = ph;
    speed = s;
    paddleColor = c;
  
  }
  
  void display(){
    fill(paddleColor);
    rect(x, y, w, h);
  }
  
  void update() {
    if (keyPressed) {
      if (keyCode == LEFT) x -= speed;
      if (keyCode == RIGHT) x += speed;
    }
    // Keep the paddle inside the window
    x = constrain(x, 0, width - this.w);
  }
  
  
}
