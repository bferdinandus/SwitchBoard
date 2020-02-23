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
public class Board
{
  private Map<Integer, Node> _nodes = new TreeMap<Integer, Node>();
  private ArrayList<Button> _buttons = new ArrayList();

  private Track _fromTrack, _toTrack;
  private Boolean _displayRouteError = false;

  private String _name = "";

  public Board() {
    _buttons.add(new Button(Constants.buttons.Reset, "Reset", 300, 5));
    _buttons.add(new Button(Constants.buttons.PlanRoute, "Bereken!", 300, 30));
  }

  public String Name() {
    return _name;
  }

  public void Name(String name) {
    _name = name;
  }

  public Track FromTrack() {
    return _fromTrack;
  }

  public Track ToTrack() {
    return _toTrack;
  }

  public void FromTrack(Track track) {
    _fromTrack = track;
  }

  public void ToTrack(Track track) {
    _toTrack = track;
  }

  private void ResetTracks() {
    _fromTrack = null;
    _toTrack = null;
  }

  private void PlanRoute() {
    ResetHighlights();
    _displayRouteError = false;
    Planner p = new Planner(this);
    Boolean calculateSuccess = p.CalculateRoute(_fromTrack.Id(), _toTrack.Id());
    if (calculateSuccess) {
      p.ExecuteRoute();
    } else {
      _displayRouteError = true;
    }
  }

  private void ResetHighlights() {
    for (Node node : _nodes.values()) {
      node.get("self").Highlight(false);
    }
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

    Element element = CreateElement(type, id, options);

    if (element == null) {
      println("Board$AddElement => Invalid type: " + type.toString() + " No element added.");
      return;
    }

    if (_nodes.size() == 0) {
      // alleen voor het eerste id element de positie "hard" instellen. De rest gaat relatief ten opzichte van dit element
      Map<String, Integer> xy = new HashMap<String, Integer>();
      xy.put("x", 50);
      xy.put("y", height / 2);
      element.XY(xy);
    }

    Node node = new Node();
    node.put("self", element);

    _nodes.put(id, node);
  }

  private Element CreateElement(Constants.element type, Integer id, Map<String, Object> options) {
    Element element = null;

    switch (type) {
    case SwitchTrack:
      element = new SwitchTrackBuilder().setId(id).buildWithOptions(options);
      break;
    case Track:
      element = new TrackBuilder().setId(id).buildWithOptions(options);
      break;
    default:
      // niks doen
    }

    return element;
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

    // x positie voor het 2e element bepalen
    if (element1 instanceof Track) {
      if (terminal1 == Constants.terminal.A) {
        xy2.put("x", xy1.get("x") - ((Track) element1).Length() - circleDiameter);
      }
      if (terminal1 == Constants.terminal.B) {
        xy2.put("x", xy1.get("x") + ((Track) element1).Length() + circleDiameter);
      }
    } else if (element1 instanceof SwitchTrack) {
      if (element1.Reverse()
        && (terminal1 == Constants.terminal.B || terminal1 == Constants.terminal.C)) {
        if (element2 instanceof SwitchTrack) {
          xy2.put("x", xy1.get("x") - Constants.switchTrackWidth - circleDiameter);
        } else if (element2 instanceof Track) {
          xy2.put("x", xy1.get("x") - ((Track) element2).Length() - circleDiameter);
        }
      } else {
        xy2.put("x", xy1.get("x") + Constants.switchTrackWidth + circleDiameter);
      }
    }

    // y positie voor het 2e element bepalen
    if (terminal1 == Constants.terminal.C) {
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
        if (element1 instanceof Track && ((Track) element1).Diagonal()) {
          if (element1.Flip()) {
            xy2.put("y", xy1.get("y") + Constants.switchTrackHeight + Constants.switchTrackHeight);
          } else {
            xy2.put("y", xy1.get("y"));
          }
        } else {
          xy2.put("y", xy1.get("y") + Constants.switchTrackHeight);
        }
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

  public Map<Integer, Node> GetNodes()
  {
    return _nodes;
  }

  private Node GetNodeById(Integer id)
  {
    return _nodes.get(id);
  }

  private boolean NodeExists(Integer id) {
    return _nodes.containsKey(id);
  }

  public void Display() {
    DisplayText();
    DisplayTracks();
    DisplayButtons();
  }

  private void DisplayButtons()
  {
    for (Button button : _buttons) {
      button.Display();
    }
  }

  private void DisplayText() {
    String fromTrackId = "", toTrackId = "";
    if (_fromTrack != null) {
      fromTrackId = _fromTrack.Id().toString();
    }

    if (_toTrack != null) {
      toTrackId = _toTrack.Id().toString();
    }

    fill(#000000);
    textAlign(LEFT, TOP);
    textSize(15);
    text("Automatisch route berekenen.\nStartspoor: " + fromTrackId + "\nEindspoor: " + toTrackId, 50, 5 );

    if (_displayRouteError) {
      fill(#FF0000);
      textAlign(LEFT, TOP);
      textSize(15);
      text("Route niet mogelijk", 250, 70);
    }
  }

  private void DisplayTracks() {
    for (Node node : _nodes.values()) {
      Element element = node.get("self");
      if (element.IsPositioned()) {
        element.Display();
      } else {
        //println("Draw => Element id: " + element.Id() + " not positioned: skip drawing");
      }
    }
  }

  public void MouseOverCheck(Integer x, Integer y) {
    // check buttons
    for (Button button : _buttons) {
      button.MouseOverCheck(x, y);
    }

    // check board elements
    for (Node node : _nodes.values()) {
      Element element = node.get("self");
      element.MouseOverCheck(x, y);
    }
  }

  public void MouseClicked(Integer x, Integer y, Integer mButton) {
    // check buttons
    for (Button button : _buttons) {
      if (button.MouseOverCheck(x, y) && mButton == LEFT && button.Id() == Constants.buttons.Reset) {
        ResetTracks();
        ResetHighlights();
        _displayRouteError = false;
      };

      if (button.MouseOverCheck(x, y) && mButton == LEFT && button.Id() == Constants.buttons.PlanRoute) {
        PlanRoute();
      };
    }

    // check elements
    for (Node node : _nodes.values()) {
      Element element = node.get("self");
      if (element.MouseOverCheck(mouseX, mouseY)) {
        ResetHighlights();
        _displayRouteError = false;
        if (element instanceof SwitchTrack) {
          ((SwitchTrack) element).Toggle();
        };
        if (element instanceof Track) {
          if (mouseButton == LEFT) {
            _board.FromTrack((Track) element);
          } else if (mouseButton == RIGHT) {
            _board.ToTrack((Track) element);
          }
        }
      }
    }
  }

  public void MousePressed(Integer x, Integer y) {
    // check buttons
    for (Button button : _buttons) {
      if (button.MouseOverCheck(x, y)) {
        button.MousePressed();
      };
    }
  }

  public void MouseReleased(Integer x, Integer y) {
    // check buttons
    for (Button button : _buttons) {
      button.MouseOverCheck(x, y);
      button.MouseReleased();
    }
  }
}
