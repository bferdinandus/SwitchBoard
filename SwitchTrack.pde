public class SwitchTrack extends Element { //<>//
  private Boolean _flip, _reverse;

  private NodeCircle circle = new NodeCircle();

  // constructors
  public SwitchTrack(Integer id) {
    // first call contructor of the parent
    super(id);
  }

  public Boolean Flip() 
  {
    return _flip;
  }
  
  public void Flip(Boolean flip) 
  {
    _flip = flip;
  }

  public Boolean Reverse()
  {
    return _reverse;
  }

  public void Reverse(Boolean reverse)
  {
    _reverse = reverse;
  }

  public void display() {
    Integer x1 = _x, 
            x2 = _x + Constants.switchTrackWidth, 
            y1 = _y, y2 = _y - Constants.switchTrackHeight;
    if (_flip) {
      y2 = _y + Constants.switchTrackHeight;
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
