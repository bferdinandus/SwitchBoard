 //<>//
public class SwitchTrack extends Node {
  private Integer _x, _y;
  private Boolean _flip = false, _reverse = false, _isPositioned = false;

  private NodeCircle circle = new NodeCircle();

  // constructors
  public SwitchTrack(Boolean flip, Boolean reverse, Integer id) {
    // first call contructor of the parent
    super(id);

    _x = 50;
    _y = height / 2;

    _flip = flip;
    _reverse = reverse;
  }

  // functions
  public void setXY(Integer x, Integer y) {
    // set the start position for this switchTrack
    _x = x;
    _y = y;
    _isPositioned = true;
  }
  
  @Override
  public Map<String, Integer> getXY() 
  {
    Map<String, Integer> xy = new HashMap<String, Integer>();
    xy.put("x", _x);
    xy.put("y", _y);
    
    return xy;
  }

  public Boolean IsPositioned()
  {
    return _isPositioned;
  }

  public void setFlip(Boolean flip) 
  {
    _flip = flip;
  }

  public void setReverse(Boolean reverse)
  {
    _reverse = reverse;
  }

  public void display() {
    Integer x1 = _x, x2 = _x + 50, y1 = _y, y2 = _y - 25;
    if (_flip && !_reverse) {
      y2 = _y + 25;
    }

    if (_flip && _reverse) {
      Integer t = y1;
      y1 = y2;
      y2 = t;
    }

    if (_reverse) {
      Integer t = x1;
      x1 = x2;
      x2 = t;
    }

    line(x1, y1, x2, y1);
    line(x1, y1, x2, y2);

    circle.display(x1, y1, #3EF761, 'A');
    circle.display(x2, y1, #F7923E, 'B');
    circle.display(x2, y2, #FC2424, 'C');
  }
}
