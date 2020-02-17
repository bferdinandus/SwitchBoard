import java.util.TreeMap;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Board board = new Board();

int _lastMillis = millis();

void setup() {
  size(600, 400);

  //Configuration.loadSingleSwitch(board);
  Configuration.loadSchaduwStation(board);

  //println(board.GetNodes());
}

void draw() {
  background(204);

  fill(#000000);
  textAlign(LEFT, TOP);
  textSize(10);
  text("fps: " + round(frameRate), 5, 5);
  
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

void mouseMoved() {
  Map<Integer, Map<String, Element>> nodes = board.GetNodes();
  for (Map<String, Element> node : nodes.values()) {
    Element element = node.get("self"); 
    if (element instanceof SwitchTrack) {
      ((SwitchTrack) element).MouseOverCheck(mouseX, mouseY);
    }
  }
}

void mouseClicked() {
  Map<Integer, Map<String, Element>> nodes = board.GetNodes();
  for (Map<String, Element> node : nodes.values()) {
    Element element = node.get("self"); 
    if (element instanceof SwitchTrack) {
      if (((SwitchTrack) element).MouseOverCheck(mouseX, mouseY)) {
        ((SwitchTrack) element).Toggle();
      };
    }
  }
}
