import java.util.TreeMap;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Board board = new Board();

void setup() {
  size(600, 400);
  noLoop();

  // arguments: element type:enum, element Id:Integer, options: Map (optioneel)
  Map<String, Object> options = new HashMap<String, Object>();
  options.put("flip", false);
  options.put("reverse", false);
  //options.put("iets_anders", "wat dan");
  board.AddElement(Constants.element.SWITCHTRACK, 1 /*, options*/);
  board.AddElement(Constants.element.SWITCHTRACK, 2);
  
  options = new HashMap<String, Object>();
  options.put("flip", true);
  board.AddElement(Constants.element.SWITCHTRACK, 3, options);
  
  // arguments: id1, terminal bij id1, id2, terminal bij id2
  board.ConnectTerminals(1, Constants.terminal.B, 2, Constants.terminal.C);
  board.ConnectTerminals(2, Constants.terminal.B, 3, Constants.terminal.B);

  //println(board.GetNodes());
}

void draw() {
  Map<Integer, Map<String, Element>> nodes = board.GetNodes();
  for (Map<String, Element> node : nodes.values()) {
    Element element = node.get("self"); 
    if (element.IsPositioned()) {
      element.display();
    } else {
      println("Draw => Element id: " + element.Id() + " not positioned: skip drawing");
    }
  }
}
