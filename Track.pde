public class Track extends Element {
  //private Boolean _reverse;
  private Integer _length;

  // constructors
  public Track(Integer id) {
    // first call contructor of the parent
    super(id);
    _flip = false;
    _reverse = false;
  }

  public Integer Length() {
    return _length;
  }

  public void Length(Integer l) {
    _length = l;
  }

  public void Display() {
    Integer x1 = _x, x2 = _x + _length, 
      y1 = _y;

    line(x1, y1, x2, y1);

    if (Constants.debug) {
      _circle.display(x1, y1, #3EF761, 'A');
      _circle.display(x2, y1, #F7923E, 'B');

      Integer letterX = x1 + abs((x1 - x2) / 2);

      fill(#000000);
      textSize(20);
      textAlign(CENTER, CENTER);

      text(_id, letterX, _y);
    }
  }
}
