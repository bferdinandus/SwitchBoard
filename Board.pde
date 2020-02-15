/*    
 Een wissel ziet er als volgt uit.
 Terminal a: waar de splitsing begint
 Terminal b: het stuk dat rechtdoor loopt
 Terminal c: het stuk dat afbuigt
 
 C
 / 
 /
 A--B
 */

public class Board {
  Map<Integer, Map<String, Element>> _nodes = new TreeMap<Integer, Map<String, Element>>();

  public Board() {
  }

  public void AddElement(Constants.element type, Integer id)
  {
    AddElement(type, id, new HashMap<String, Object>());
  }

  // arguments: element type:enum, element Id:Integer, options: Map
  public void AddElement(Constants.element type, Integer id, Map<String, Object> options) 
  {
    if (NodeExists(id)) {
      println("AddElement => node id: " + id + " already exists.");
      return;
    }
    Map<String, Element> node;
    Element element;
    switch (type) {
    case SWITCHTRACK:
      element = new SwitchTrack(id);
      if (options.containsKey("flip")) {
        ((SwitchTrack) element).Flip((Boolean)options.get("flip"));
      }
      if (options.containsKey("reverse")) {
        ((SwitchTrack) element).Reverse((Boolean)options.get("reverse"));
      }
      node = new HashMap<String, Element>();

      break;
    default:
      // niks doen
      println("AddElement => Invalid type: " + type.toString() + " No element added.");
      return;
    }

    if (id == 1) {
      // alleen voor het eerste id element de positie "hard" instellen. De rest gaat relatief ten opzichte van dit element
      Map<String, Integer> xy = new HashMap<String, Integer>();
      xy.put("x", 50);
      xy.put("y", height / 2);
      element.XY(xy);
      if (type == Constants.element.SWITCHTRACK) {
        ((SwitchTrack) element).Flip(false);
        ((SwitchTrack) element).Reverse(false);
      }
    }

    node.put("self", element);
    _nodes.put(id, node);
  }

  public void ConnectTerminals(Integer id1, Constants.terminal terminal1, Integer id2, Constants.terminal terminal2) 
  {
    if (!NodeExists(id1)) {
      println("ConnectTerminals => Node id: " + id1 + " does not exist.");
      return;
    }
    if (!NodeExists(id2)) {
      println("ConnectTerminals => Node id: " + id2 + " does not exist.");
      return;
    }
    if (GetNodeById(id1).containsKey(terminal1.toString())) {
      println("ConnectTerminals => Terminal: " + terminal1.toString() + " on node id: " + id1 + " already taken.");
      return;
    }
    if (GetNodeById(id2).containsKey(terminal2.toString())) {
      println("ConnectTerminals => Connecting node id: " + id1 + " and node id: " + id2 + ". Terminal: " + terminal2.toString() + " on node id: " + id2 + " already taken.");
      return;
    }
    // TODO: een type terminal check bouwen. Een recht stuk "Track" heeft bijvoorbeeld geen terminal C. Die zit alleen op een "SwitchTrack"
    // TODO: juiste type voor element 1 en 2 bepalen
    SwitchTrack element1 = (SwitchTrack)GetElementById(id1);
    SwitchTrack element2 = (SwitchTrack)GetElementById(id2);
    GetNodeById(id1).put(terminal1.toString(), element2);
    GetNodeById(id2).put(terminal2.toString(), element1);

    // element 2 ten opzichte van element 1 positioneren.
    Map<String, Integer> xy1 = element1.XY();
    Map<String, Integer> xy2 = new HashMap<String, Integer>();

    // hier alvast reverse zetten als die null is, de onderstaande code heeft het nodig
    if (element2.Reverse() == null) {
      element2.Reverse(false);
    }

    if (terminal1 == Constants.terminal.A && terminal2 == Constants.terminal.A && element1.Reverse() == element2.Reverse()) {
      element2.Reverse(!element1.Reverse());
    }

    if (terminal1 == Constants.terminal.A
      && (terminal2 == Constants.terminal.B || terminal2 == Constants.terminal.B)
      && element1.Reverse() == !element2.Reverse()) {
      element2.Reverse(element1.Reverse());
    }

    if ((terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.C) 
      && (terminal2 == Constants.terminal.B || terminal2 == Constants.terminal.C) 
      && element1.Reverse() == element2.Reverse()) {
      element2.Reverse(!element1.Reverse());
    }

    // controleren of flip en reverse niet meer null zijn en anders op "false" zetten
    if (element2.Flip() == null) {
      element2.Flip(false);
    }

    // x positie voor het 2e element bepalen
    if (element1.Reverse()
      && (terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.C) 
      && (terminal2 == Constants.terminal.B || terminal2 == Constants.terminal.C)) {
      xy2.put("x", xy1.get("x") - Constants.switchTrackWidth - Constants.circleDiameter);
    } else {
      xy2.put("x", xy1.get("x") + Constants.switchTrackWidth + Constants.circleDiameter);
    }

    // y positie voor het 2e element bepalen
    if (terminal1 == Constants.terminal.C) {
      xy2.put("y", xy1.get("y") - Constants.switchTrackHeight);
      if (element2.Flip()) { 
        // extra omhoog om rekening te houden met de flip
        xy2.put("y", xy2.get("y") - Constants.switchTrackHeight);
      }
    } else if (terminal1 == Constants.terminal.B && terminal2 == Constants.terminal.C) {
      xy2.put("y", xy1.get("y") + Constants.switchTrackHeight);
    } else if (terminal2 == Constants.terminal.C) {
      if (element2.Flip()) { 
        xy2.put("y", xy1.get("y") - Constants.switchTrackHeight);
      } else {
        xy2.put("y", xy1.get("y") + Constants.switchTrackHeight);
      }
    } else {
      xy2.put("y", xy1.get("y"));
    }

    // positie vastzetten in 2e element
    element2.XY(xy2);
  }

  public Element GetElementById(Integer id) 
  {
    return GetNodeById(id).get("self");
  }

  public Map<Integer, Map<String, Element>> GetNodes() 
  {
    return _nodes;
  }

  private Map<String, Element> GetNodeById(Integer id) 
  {
    return _nodes.get(id);
  }

  private boolean NodeExists(Integer id) {
    return _nodes.containsKey(id);
  }
}
