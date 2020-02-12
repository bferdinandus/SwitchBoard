PFont f;
SwitchTrack st1, st2;

void setup() {
  size(600, 400);
  noSmooth();
  noLoop();
  st1 = new SwitchTrack(50, height / 2);
  st2 = new SwitchTrack(120, (height / 2) - 25);
}

void draw() {
  st1.display();
  st2.display();

}
