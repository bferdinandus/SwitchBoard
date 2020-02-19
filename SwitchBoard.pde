import java.util.TreeMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Board _board = new Board();

int _lastMillis = millis();

void setup() {
  size(600, 400);
  frameRate(60);
  //Configuration.loadSingleSwitch(_board);
  // Configuration.loadSchaduwStation(_board);
  Configuration.loadSmallBoard(_board);

  //println(_board.GetNodes());
}

void draw() {
  background(204);

  fill(#000000);
  textAlign(LEFT, TOP);
  textSize(10);
  text("fps: " + round(frameRate), 5, 5);

  _board.Display();
}

void mouseMoved() {
  _board.MouseOverCheck(mouseX, mouseY);
}

void mouseDragged() {
  // _board.MouseOverCheck(mouseX, mouseY);
}

void mousePressed() {
  _board.MousePressed(mouseX, mouseY);
}

void mouseReleased() {
  _board.MouseReleased(mouseX, mouseY);
}

void mouseClicked() {
  _board.MouseClicked(mouseX, mouseY, mouseButton);
}
