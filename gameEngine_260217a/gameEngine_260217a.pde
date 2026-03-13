//Platformer Game Engine

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
