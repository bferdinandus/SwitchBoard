import java.util.TreeMap;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Board board = new Board();

void setup() {
  size(600, 400);
  noSmooth();
  noLoop();

  // addSwitchTrack(int id, Boolean flip, Boolean reverse, int termA, int termB, int termC)
  board.AddSwitchTrack(1, false, false, 0, 3, 2);
  board.AddSwitchTrack(2, false, false, 1, 0, 4);
  board.AddSwitchTrack(3, true, false, 1, 0, 0);
  board.AddSwitchTrack(4, false, false, 2, 0, 0);

  println(board.GetElements());

  board.UpdatePositions();
}

void draw() {
  Map<Integer, Map<String, Node>> elements = board.GetElements();
  for (Map<String, Node> value : elements.values()) {
    value.get("self").display();
  }
}
