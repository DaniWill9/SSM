class Player {

  float x, y;
  float w = 28, h = 42;
  float vx = 0;
  float vy = 0;

  float moveSpeed = 4;
  float jumpPower = -10;
  float gravity = 0.5;

  boolean onGround = false;

  int col;
  boolean arrowMode = false;
  char leftChar, rightChar, jumpChar;
  int leftCode, rightCode, jumpCode;

  Player(float startX, float startY, int c) {
    x = startX;
    y = startY;
    col = c;

    if (c == color(255, 0, 0)) {
      leftChar = 'a';
      rightChar = 'd';
      jumpChar = 'w';
    } else {
      arrowMode = true;
      leftCode = LEFT;
      rightCode = RIGHT;
      jumpCode = UP;
    }
  }

  void update() {
    handleInput();
    applyPhysics();
    verticalCollide();
  }

  void handleInput() {

    boolean leftPressed, rightPressed, jumpPressed;

    if (!arrowMode) {
      leftPressed = keyDown[leftChar];
      rightPressed = keyDown[rightChar];
      jumpPressed = keyDown[jumpChar];
    } else {
      leftPressed = keyDown[leftCode];
      rightPressed = keyDown[rightCode];
      jumpPressed = keyDown[jumpCode];
    }

    if (leftPressed) vx = -moveSpeed;
    else if (rightPressed) vx = moveSpeed;
    else vx = 0;

    if (jumpPressed && onGround) {
      vy = jumpPower;
      onGround = false;
    }
  }

  void applyPhysics() {
    vy += gravity;
    x += vx;
    y += vy;
  }

  void verticalCollide() {

    onGround = false;

    if (x + w > floor.x && x < floor.x + floor.w) {
      if (vy > 0 && y + h >= floor.y && y + h <= floor.y + floor.h) {
        y = floor.y - h;
        vy = 0;
        onGround = true;
      }
    }

    for (Block b : onScreenBlocks) {
      if (x + w > b.x && x < b.x + b.w) {
        if (vy > 0 && y + h >= b.y && y + h <= b.y + b.h) {
          y = b.y - h;
          vy = 0;
          onGround = true;
        }
      }
    }

    if (y > laptopScreenHeight - h) {
      y = laptopScreenHeight - h;
      vy = 0;
      onGround = true;
    }
  }

  void drawPlayer() {
    fill(col);
    rect(x, y, w, h);
  }
}
