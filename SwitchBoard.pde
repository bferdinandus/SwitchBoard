import java.util.TreeMap;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Board board = new Board();

void setup() {
  size(600, 400);
  noLoop();

  //Configuration.loadSingleSwitch(board);
  Configuration.loadSchaduwStation(board);
  //println(board.GetNodes());
}

void draw() {
  Map<Integer, Map<String, Element>> nodes = board.GetNodes();
  for (Map<String, Element> node : nodes.values()) {
    Element element = node.get("self"); 
    if (element.IsPositioned()) {
      element.Display();
    } else {
      println("Draw => Element id: " + element.Id() + " not positioned: skip drawing");
    }
  }
}
