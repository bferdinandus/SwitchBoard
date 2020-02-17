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
  private Map<Integer, Map<String, Element>> _nodes = new TreeMap<Integer, Map<String, Element>>();

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
      println("Board$AddElement => node id: " + id + " already exists.");
      return;
    }

    Element element;
    Map<String, Element> node = new HashMap<String, Element>();
    switch (type) {
    case SwitchTrack:
      element = new SwitchTrack(id);
      if (options.containsKey("flip")) {
        ((SwitchTrack) element).Flip((Boolean)options.get("flip"));
      }
      if (options.containsKey("reverse")) {
        ((SwitchTrack) element).Reverse((Boolean)options.get("reverse"));
      }

      break;
    case Track:
      element = new Track(id);
      if (options.containsKey("lengthInSwitchTracks")) {
        ((Track) element).LengthInSwitchTracks((Integer)options.get("lengthInSwitchTracks"));
      }

      break;
    default:
      // niks doen
      println("Board$AddElement => Invalid type: " + type.toString() + " No element added.");
      return;
    }

    if (_nodes.size() == 0) {
      // alleen voor het eerste id element de positie "hard" instellen. De rest gaat relatief ten opzichte van dit element
      Map<String, Integer> xy = new HashMap<String, Integer>();
      xy.put("x", 50);
      xy.put("y", height / 2);
      element.XY(xy);
      if (type == Constants.element.SwitchTrack) {
        if (((SwitchTrack)element).Flip() == null) {
          ((SwitchTrack)element).Flip(false);
        }
        if (((SwitchTrack)element).Reverse() == null) {
          ((SwitchTrack)element).Reverse(false);
        }
      }
    }

    node.put("self", element);
    _nodes.put(id, node);
  }

  public void ConnectTerminals(Integer id1, Constants.terminal terminal1, Integer id2, Constants.terminal terminal2) 
  {
    if (!NodeExists(id1)) {
      println("Board$ConnectTerminals => Node id: " + id1 + " does not exist.");
      return;
    }
    if (!NodeExists(id2)) {
      println("Board$ConnectTerminals => Node id: " + id2 + " does not exist.");
      return;
    }
    if (GetNodeById(id1).containsKey(terminal1.toString())) {
      println("Board$ConnectTerminals => Terminal: " + terminal1.toString() + " on node id: " + id1 + " already taken.");
      return;
    }
    if (GetNodeById(id2).containsKey(terminal2.toString())) {
      println("Board$ConnectTerminals => Connecting node id: " + id1 + " and node id: " + id2 + ". Terminal: " + terminal2.toString() + " on node id: " + id2 + " already taken.");
      return;
    }
    // TODO: een type terminal check bouwen. Een recht stuk "Track" heeft bijvoorbeeld geen terminal C. Die zit alleen op een "SwitchTrack"
    // TODO: juiste type voor element 1 en 2 bepalen
    Element element1 = GetElementById(id1);
    if (!element1.IsPositioned()) {
      println("Board$ConnectTerminals => Element id: " + id1 + " not positioned. Unable to connect terminals.");
      return;
    }
    Element element2 = GetElementById(id2);
    GetNodeById(id1).put(terminal1.toString(), element2);
    GetNodeById(id2).put(terminal2.toString(), element1);

    Integer circleDiameter = Constants.circleDiameter;
    if (!Constants.useNodeCircle) {
      circleDiameter = 0;
    }

    // element 2 ten opzichte van element 1 positioneren.
    Map<String, Integer> xy1 = element1.XY();
    Map<String, Integer> xy2 = new HashMap<String, Integer>();

    // controleren of flip en reverse niet null zijn en anders op "false" zetten
    // hier alvast flip and reverse zetten als die null zijn, de onderstaande code heeft het nodig
    if (element2.Flip() == null) {
      element2.Flip(false);
    }
    if (element2.Reverse() == null) {
      element2.Reverse(false);
    }

    // bepalen of het 2e element in "reverse" moet op basis van de te verbinden terminals en de "reverse" van het 1e element
    if (terminal1 == Constants.terminal.A && terminal2 == Constants.terminal.A && element1.Reverse() == element2.Reverse()) {
      element2.Reverse(!element1.Reverse());
    }

    if (terminal1 == Constants.terminal.A
      && (terminal2 == Constants.terminal.B || terminal2 == Constants.terminal.B)
      && element1.Reverse() == !element2.Reverse()) {
      element2.Reverse(element1.Reverse());
    }

    if ((terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.B)
      && terminal2 == Constants.terminal.A
      && element1.Reverse() == !element2.Reverse()) {
      element2.Reverse(element1.Reverse());
    }

    if ((terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.C) 
      && (terminal2 == Constants.terminal.B || terminal2 == Constants.terminal.C) 
      && element1.Reverse() == element2.Reverse()) {
      element2.Reverse(!element1.Reverse());
    }

    // indien het element een track is, de lengte uitrekenen
    if (element1 instanceof Track && ((Track) element1).Length() == null) {
      Integer l = (((Track) element1).LengthInSwitchTracks() * Constants.switchTrackWidth) + ((((Track) element1).LengthInSwitchTracks() - 1) * circleDiameter);
      ((Track) element1).Length(l);
    }

    if (element2 instanceof Track && ((Track) element2).Length() == null) {
      Integer l = (((Track) element2).LengthInSwitchTracks() * Constants.switchTrackWidth) + ((((Track) element2).LengthInSwitchTracks() - 1) * circleDiameter);
      ((Track) element2).Length(l);
    }

    // x positie voor het 2e element bepalen
    if (element1.Reverse()
      && (terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.C)) {
      if (element2 instanceof SwitchTrack) {
        xy2.put("x", xy1.get("x") - Constants.switchTrackWidth - circleDiameter);
      } else if (element2 instanceof Track) {
        xy2.put("x", xy1.get("x") - ((Track) element2).Length() - circleDiameter);
      }
    } else if (element1 instanceof Track && element2.Reverse()) {
      xy2.put("x", xy1.get("x") - Constants.switchTrackWidth - circleDiameter);
    } else {
      xy2.put("x", xy1.get("x") + Constants.switchTrackWidth + circleDiameter);
    }

    if (terminal1 == Constants.terminal.C) {
      // y positie voor het 2e element bepalen
      if (element2 instanceof SwitchTrack) {
        if (element1.Flip()) { 
          xy2.put("y", xy1.get("y") + Constants.switchTrackHeight);
        } else {
          xy2.put("y", xy1.get("y") - Constants.switchTrackHeight);
        }
      } else if (element2 instanceof Track) {
        if (element1.Flip()) { 
          xy2.put("y", xy1.get("y"));
        } else {
          xy2.put("y", xy1.get("y") - Constants.switchTrackHeight);
        }
      }

      if (!element1.Flip() && element2.Flip()) { 
        // extra omhoog om rekening te houden met de flip
        xy2.put("y", xy2.get("y") - Constants.switchTrackHeight);
      }

      if (element1.Flip() && !element2.Flip()) { 
        // extra omhoog om rekening te houden met de flip
        xy2.put("y", xy2.get("y") + Constants.switchTrackHeight);
      }
    } else if (terminal2 == Constants.terminal.C) {
      if (element2.Flip()) { 
        xy2.put("y", xy1.get("y") - Constants.switchTrackHeight);
      } else {
        xy2.put("y", xy1.get("y") + Constants.switchTrackHeight);
      }
    } else {
      xy2.put("y", xy1.get("y"));
    }

    // positie opslaan in 2e element
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
