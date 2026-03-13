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
