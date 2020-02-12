public class SwitchTrack extends Node { //<>// //<>//
  private int _x, _y;
  private Boolean _flip = false, _reverse = false;

  private NodeCircle circle = new NodeCircle();
  private Node _terminalA, _terminalB, _terminalC;

  // constructors  
  public SwitchTrack(Boolean flip, Boolean reverse) {
    setXY(50, height / 2);
    _flip = flip;
    _reverse = reverse;
  }

  // functions
  public void setXY(int x, int y) {
    _x = x;
    _y = y;
  }

  public void setTeminalA(Node node) {
    _terminalA = node;
  }

  public void setTeminalB(Node node) {
    _terminalB = node;
  }

  public void setTeminalC(Node node) {
    _terminalC = node;
  }

  public void display() {
    int x1 = _x, x2 = _x + 50, y1 = _y, y2 = _y - 25;
    if (_flip) {
      y2 = _y + 25;
    }

    if (_reverse) {
      int t = x1;
      x1 = x2;
      x2 = t;
    }

    line(x1, y1, x2, y1);
    line(x1, y1, x2, y2);

    circle.display(x1, y1, #3EF761, 'A');
    circle.display(x2, y1, #F7923E, 'B');
    circle.display(x2, y2, #FC2424, 'C');

    if (_terminalC != null) {
      _terminalC.setXY(x2 + 20, y2);
      _terminalC.display();
    }
  }
}
