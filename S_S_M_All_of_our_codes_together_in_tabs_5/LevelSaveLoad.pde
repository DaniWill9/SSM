// SAVE & LOAD SYSTEM

void saveLevel() {

  if (onScreenBlocks.size() == 0 && spikeBlocks.size() == 0) {
    println("No blocks to save.");
    return;
  }

  String[] data = new String[onScreenBlocks.size() + spikeBlocks.size() + powerUps.size()];

  int index = 0; 

  for (Block b : onScreenBlocks) {
    data[index] = "B," + b.x + "," + b.y;
    index++;
  }

  for (SpikeBlock s : spikeBlocks) {
    data[index] = "S," + s.x + "," + s.y;
    index++;
  }

  for (PowerUp p : powerUps) {
    data [index] = "P," + p.x + "," + p.y;
    index++;
  }

  String fullPath = dataPath("savedState.txt");

  saveStrings(fullPath, data);

  println("Saved " + data.length + " items");
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
  spikeBlocks.clear();
  powerUps.clear();

  for (String line : data) {

    if (line != null && line.length() > 0) {

      String[] parts = split(line, ",");

      if (parts[0].equals("B")) {
        float x = float(parts[1]);
        float y = float(parts[2]);
        onScreenBlocks.add(new Block(x, y, 100, 200, 100));
      }

      if (parts[0].equals("S")) {
        float x = float(parts[1]);
        float y = float(parts[2]);
        spikeBlocks.add(new SpikeBlock(x, y));
      }
      if (parts[0].equals("P")) {
        float x = float (parts[1]);
        float y = float(parts[2]);
        powerUps.add(new PowerUp(x,y));
        powerUps.add(new SpeedPowerUp(x,y));
        powerUps.add(new BombPowerUp(x,y));
      }
    }
  }

  println("Loaded " + data.length + " items");
  println("Loaded from: " + fullPath);
}
