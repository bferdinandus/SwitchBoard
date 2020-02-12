ArrayList<Node> drawStack = new ArrayList<Node>();
SwitchTrack st1, st2;

void setup() {
  size(600, 400);
  noSmooth();
  noLoop();

  st1 = new SwitchTrack(false, false);
  st2 = new SwitchTrack(false, true);
  st1.setTeminalC(st2);
}

void draw() {
  st1.display();
}
