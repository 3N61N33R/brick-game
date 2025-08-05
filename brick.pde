// Brick

class Brick {
  float x, y;
  float width, height;
  boolean isDestroyed; // To keep track if the brick is hit
  color brickColor;

  Brick(float startX, float startY, float w, float h, color c) {
    x = startX;
    y = startY;
    width = w;
    height = h;
    isDestroyed = false;
    brickColor = c;
  }

  void display() {
    if (!isDestroyed) {
      pushMatrix();
      translate(x + width / 2, y + height / 2); // center of brick
      rotate(radians(frameCount % 360) * 0.001); // slow rotation
      rectMode(CENTER);
      fill(brickColor);
      noStroke();
      rect(0, 0, width, height);
      popMatrix();
    }
  }

  // Method to check for collision with a ball
  boolean checkCollision(Ball b) {
    float radius = b.diameter/2;
    if (!isDestroyed &&
        b.x + radius > x &&
        b.x - radius < x + width &&
        b.y + radius > y &&
        b.y - radius < y + height) {
      isDestroyed = true;
      return true;
    }
    return false;
  }
}
