class SwitchTrack {
  private int _x;
  private int _y;

  // constructor
  SwitchTrack(int x, int y) {
    _x = x; 
    _y = y;
  }

  void display() {
    int circleDiameter=20;

    line(_x, _y, _x + 50, _y);
    line(_x, _y, _x + 50, _y - 25);

    fill(0, 255, 0);
    circle(_x, _y, circleDiameter);
    fill(255, 150, 0);
    circle(_x + 50, _y, circleDiameter);
    fill(255, 0, 0);
    circle(_x + 50, _y - 25, circleDiameter);

    textSize(15);
    fill(0);
    textAlign(CENTER, CENTER);
    text("A", _x, _y);
    text("B", _x + 50, _y);
    text("C", _x + 50, _y - 25);
  }
}
