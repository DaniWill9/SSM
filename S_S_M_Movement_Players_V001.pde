/* ------------------------------------------------------------
   SIMPLE 2‑PLAYER PLATFORMER (Red vs Blue)
   Ground only — no side walls, no wall jumping
   Simple movement + jumping
   ------------------------------------------------------------ */

boolean[] keyDown = new boolean[512];

Player redPlayer;
Player bluePlayer;

Platform floor;


// ------------------------------------------------------------
// SETUP
// ------------------------------------------------------------
void setup() {
  size(820, 520);
  background(255);

  redPlayer = new Player(300, 120, color(255, 0, 0));
  bluePlayer = new Player(360, 120, color(0, 120, 255));

  floor = new Platform(0, 450, width, 70);
}


// ------------------------------------------------------------
// MAIN LOOP
// ------------------------------------------------------------
void draw() {
  background(255);

  floor.drawPlatform();

  redPlayer.update();
  bluePlayer.update();

  redPlayer.drawPlayer();
  bluePlayer.drawPlayer();
}


// ------------------------------------------------------------
// KEY INPUT
// ------------------------------------------------------------
void keyPressed() {
  if (keyCode < 512) keyDown[keyCode] = true;
  if (key < 512)     keyDown[key] = true;
}

void keyReleased() {
  if (keyCode < 512) keyDown[keyCode] = false;
  if (key < 512)     keyDown[key] = false;
}



// ------------------------------------------------------------
// PLAYER CLASS
// ------------------------------------------------------------
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


  // ------------------------------------------------------------
  // CONSTRUCTOR
  // ------------------------------------------------------------
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


  // ------------------------------------------------------------
  // UPDATE
  // ------------------------------------------------------------
  void update() {
    handleInput();
    applyPhysics();
    verticalCollide();
  }


  // ------------------------------------------------------------
  // INPUT
  // ------------------------------------------------------------
  void handleInput() {

    boolean leftPressed, rightPressed, jumpPressed;

    if (!arrowMode) {
      leftPressed  = keyDown[leftChar];
      rightPressed = keyDown[rightChar];
      jumpPressed  = keyDown[jumpChar];
    } else {
      leftPressed  = keyDown[leftCode];
      rightPressed = keyDown[rightCode];
      jumpPressed  = keyDown[jumpCode];
    }

    if (leftPressed)       vx = -moveSpeed;
    else if (rightPressed) vx = moveSpeed;
    else                   vx = 0;

    if (jumpPressed && onGround) {
      vy = jumpPower;
      onGround = false;
    }
  }


  // ------------------------------------------------------------
  // PHYSICS
  // ------------------------------------------------------------
  void applyPhysics() {
    vy += gravity;
    x += vx;
    y += vy;
  }


  // ------------------------------------------------------------
  // VERTICAL COLLISION (GROUND ONLY)
  // ------------------------------------------------------------
  void verticalCollide() {
    onGround = false;

    // Ground collision
    if (x + w > floor.x && x < floor.x + floor.w) {
      if (vy > 0 && y + h + vy >= floor.y && y + h <= floor.y + floor.h) {
        y = floor.y - h;
        vy = 0;
        onGround = true;
      }
    }

    // Bottom of screen safety
    if (y > height - h) {
      y = height - h;
      vy = 0;
      onGround = true;
    }
  }


  // ------------------------------------------------------------
  // DRAW PLAYER
  // ------------------------------------------------------------
  void drawPlayer() {
    fill(col);
    noStroke();
    rect(x, y, w, h);
  }
}



// ------------------------------------------------------------
// PLATFORM CLASS
// ------------------------------------------------------------
class Platform {
  float x, y, w, h;

  Platform(float px, float py, float pw, float ph) {
    x = px;
    y = py;
    w = pw;
    h = ph;
  }

  void drawPlatform() {
    fill(0);
    noStroke();
    rect(x, y, w, h);
  }
}
