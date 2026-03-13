boolean[] keyDown = new boolean[512];

Player redPlayer;
Player bluePlayer;
Platform floor;

int laptopScreenWidth = 800;
int sidePanelWidth = 200;
int laptopScreenHeight = 520;

ArrayList<Block> onScreenBlocks = new ArrayList<Block>();
boolean holdingBlock = false;

int gameState = 0; // 0 = Start, 1 = Build, 2 = Play

void settings() {
  size(laptopScreenWidth + sidePanelWidth, laptopScreenHeight);
}

void setup() {
  redPlayer = new Player(300, 120, color(255, 0, 0));
  bluePlayer = new Player(360, 120, color(0, 120, 255));
  floor = new Platform(0, 450, laptopScreenWidth, 70);
}

void draw() {

  if (gameState == 0) {
    background(30);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("START SCREEN\nClick to Build", width/2, height/2);
  }

  else if (gameState == 1) {
    drawBuildMode();
  }

  else if (gameState == 2) {
    drawPlayMode();
  }
}

void drawBuildMode() {
  background(220);

  fill(180);
  rect(0, 0, laptopScreenWidth, laptopScreenHeight);

  fill(140);
  rect(laptopScreenWidth, 0, sidePanelWidth, laptopScreenHeight);

  drawInventory();
  drawBlocks();
  floor.drawPlatform();

  fill(0);
  text("Press P to Play\nPress S to Save", laptopScreenWidth + 100, 300);
}

void drawPlayMode() {
  background(200);

  floor.drawPlatform();
  drawBlocks();

  redPlayer.update();
  bluePlayer.update();

  redPlayer.drawPlayer();
  bluePlayer.drawPlayer();

  fill(0);
  text("Press B to Build", 100, 20);
}

void drawInventory() {
  fill(100, 200, 100);
  rect(laptopScreenWidth + 50, 100, 100, 50);
}

void mousePressed() {

  if (gameState == 0) {
    gameState = 1;
    return;
  }

  if (gameState == 1) {

    if (mouseX > laptopScreenWidth + 50 && mouseX < laptopScreenWidth + 150 &&
        mouseY > 100 && mouseY < 150) {

      holdingBlock = true;
    }

    else if (mouseX < laptopScreenWidth && holdingBlock) {

      onScreenBlocks.add(new Block(mouseX, mouseY, 100, 200, 100));
      holdingBlock = false;
    }
  }
}

void keyPressed() {
  if (keyCode < 512) keyDown[keyCode] = true;
  if (key < 512) keyDown[key] = true;

  if (gameState == 1 && key == 'p') {
    gameState = 2;
  }

  if (gameState == 2 && key == 'b') {
    gameState = 1;
  }

  if (gameState == 1 && key == 's') {
    saveLevel();
  }

  if (gameState == 1 && key == 'l') {
    loadLevel();
  }
}

void keyReleased() {
  if (keyCode < 512) keyDown[keyCode] = false;
  if (key < 512) keyDown[key] = false;
}

void drawBlocks() {
  for (Block b : onScreenBlocks) {
    b.display();
  }
}

void saveLevel() {

  if (onScreenBlocks.size() == 0) {
    println("No blocks to save.");
    return;
  }

  String[] data = new String[onScreenBlocks.size()];
  
  for (int i = 0; i < onScreenBlocks.size(); i++) {
    Block b = onScreenBlocks.get(i);
    data[i] = b.x + "," + b.y;
  }

  String fullPath = dataPath("savedState.txt");
  saveStrings(fullPath, data);

  println("Saved " + data.length + " blocks");
  println("Saved to: " + fullPath);
}

void loadLevel() {

  String fullPath = dataPath("savedState.txt");
  String[] data = loadStrings(fullPath);

  if (data == null) {
    println("No save file found.");
    return;
  }

  onScreenBlocks.clear();

  for (String line : data) {
    if (line != null && line.length() > 0) {
      String[] parts = split(line, ",");
      float x = float(parts[0]);
      float y = float(parts[1]);
      onScreenBlocks.add(new Block(x, y, 100, 200, 100));
    }
  }

  println("Loaded " + onScreenBlocks.size() + " blocks");
  println("Loaded from: " + fullPath);
}

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
    rect(x, y, w, h);
  }
}

class Block {

  float x, y;
  float w = 50;
  float h = 50;
  int r, g, b;

  Block(float x, float y, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void display() {
    fill(r, g, b);
    rect(x, y, w, h);
  }
}
