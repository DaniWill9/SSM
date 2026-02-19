//variables for screen size stuff
int laptopScreenWidth = 800;
int sidePanelWidth = 200;
int laptopScreenHeight = 600;

//block array
ArrayList<Block> onScreenBlocks = new ArrayList<Block>();
Block clickedBlock = null;

void settings() {
  
  size (laptopScreenWidth + sidePanelWidth, laptopScreenHeight);
  
}

void setup() {
  
}


void draw() {
  
  background(220);

//scene size for game
  fill(180);
  rect(0, 0, laptopScreenWidth, laptopScreenHeight);

//side bar size for blocks
  fill(140);
  rect(laptopScreenWidth, 0, sidePanelWidth, laptopScreenHeight);

  drawInventory();
  drawBlocks();
  
}

void drawInventory() {
  
  //drawing of side bar with blocks
  fill(100, 200, 100);
  rect(laptopScreenWidth + 50, 100, 100, 50);
  
}

void mousePressed() {

  //if mouse is clicked on game scene after block is clicked, block is created on scene
  if (mouseX > laptopScreenWidth + 50 && mouseX < laptopScreenWidth + 150 && mouseY > 100 && mouseY < 150) {

    clickedBlock = new Block(0, 0, 100, 200, 100);
    
  }

  else if (mouseX < laptopScreenWidth && clickedBlock != null) {

    onScreenBlocks.add(new Block(mouseX, mouseY, 100, 200, 100));
    
  }
  
}

void drawBlocks() {
  
  for (Block b : onScreenBlocks) {
    
    b.display();
    
  }
  
}

class Block {
  
  //basic block creation
  float x, y;
  float w = 50;
  float h = 50;
  int r, g, b;

  Block(float x, float y, int r, int g, int b) {
    
    //collision, must test out with player eventually
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

//refs i used:
// https://processing.org/reference/mousePressed_.html
// https://processing.org/reference/ArrayList.html
// https://processing.org/reference/this.html
