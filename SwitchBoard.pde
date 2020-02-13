import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

ArrayList<Node> drawStack = new ArrayList<Node>();
Board board = new Board();

void setup() {
  size(600, 400);
  noSmooth();
  noLoop();

  //Map map = new HashMap<String, String>();
  //map.put("A","1");

  board.addSwitchTrack(1, 0, 3, 2);
  board.addSwitchTrack(2, 0, 0, 1);
  board.addSwitchTrack(3, 1, 0, 0);


  println(board._elements);

  for (Map<String, Node> value : board._elements.values()) {
    value.get("self");
  }

}

void draw() {
  for (Map<String, Node> value : board._elements.values()) {
    value.get("self").display();
  }
}
