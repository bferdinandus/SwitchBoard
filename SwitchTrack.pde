public class SwitchTrack extends Element {
  PApplet _parent;
  private Constants.terminal _position;

  public SwitchTrack(Integer id) {
    super(id);

    _position = Constants.terminal.B;
  }

  public void Toggle() {
    if (_position == Constants.terminal.B) {
      _position = Constants.terminal.C;
    } else {
      _position = Constants.terminal.B;
    }
  }

  public void SwitchToTerminal(Constants.terminal terminal) {
    _position = terminal;
  }

  private Map<String, Integer> GetCorners() {
    Integer x1 = _x, x2 = _x + Constants.switchTrackWidth,
      y1 = _y, y2 = _y - Constants.switchTrackHeight;
    if (_flip) {
      y2 = _y + Constants.switchTrackHeight;
    }

    if (_reverse) {
      Integer t = x1;
      x1 = x2;
      x2 = t;
    }

    Map<String, Integer> corners = new HashMap<String, Integer>();
    corners.put("x1", x1);
    corners.put("x2", x2);
    corners.put("y1", y1);
    corners.put("y2", y2);

    return corners;
  }

  public Boolean MouseOverCheck(Integer x, Integer y) {
    Map<String, Integer> corners = GetCorners();
    Integer x1 = corners.get("x1");
    Integer x2 = corners.get("x2");
    Integer y1 = corners.get("y1");
    Integer y2 = corners.get("y2");

    _mouseOverSwitchTrack = (x >= min(x1, x2) && x <= max(x1, x2)
      && y >= min(y1, y2) && y <= max(y1, y2));

    return _mouseOverSwitchTrack;
  }

  public void Display() {
    Map<String, Integer> corners = GetCorners();
    Integer x1 = corners.get("x1");
    Integer x2 = corners.get("x2");
    Integer y1 = corners.get("y1");
    Integer y2 = corners.get("y2");

    if (_mouseOverSwitchTrack) {
      noStroke();
      fill(230);
      rect(min(x1, x2), min(y1, y2), abs(x1-x2), abs(y1-y2));
    }

    Integer highlightColor;
    if (_highlight) {
      highlightColor = #F5DB7E;
    } else {
      highlightColor = 0;
    }

    stroke(0);
    if (_position == Constants.terminal.B) {
      stroke(0);
      strokeWeight(1);
      line(x1, y1, x2, y2);
      stroke(highlightColor);
      strokeWeight(5);
      line(x1, y1, x2, y1);
    } else {
      stroke(0);
      strokeWeight(1);
      line(x1, y1, x2, y1);
      stroke(highlightColor);
      strokeWeight(5);
      line(x1, y1, x2, y2);
    }
      stroke(0);
      strokeWeight(1);

    if (Constants.useNodeCircle) {
      _circle.display(x1, y1, #3EF761, 'A');
      _circle.display(x2, y1, #F7923E, 'B');
      _circle.display(x2, y2, #FC2424, 'C');
    }

    if (Constants.debug) {
      int letterX;
      if (!_reverse) {
        letterX = x1 + abs((x1 - x2) / 2);
      } else {
        letterX = x1 - abs((x1 - x2) / 2);
      }
      int letterY;
      if (!_flip) {
        letterY = y1 - abs((y1 - y2) / 2);
      } else {
        letterY = y1 + abs((y1 - y2) / 2);
      }

      textSize(20);
      textAlign(CENTER, CENTER);
      fill(#000000);
      text(_id, letterX-1, letterY);
      text(_id, letterX+1, letterY);
      text(_id, letterX, letterY-1);
      text(_id, letterX, letterY+1);
      fill(#ffffff);
      text(_id, letterX, letterY);
    }
  }
}
