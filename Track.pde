public class Track extends Element {
  private Integer _length, _lengthInSwitchTracks = 1;

  // constructors
  public Track(Integer id) {
    // first call contructor of the parent
    super(id);
    _flip = false;
    _reverse = false;
  }

  public Integer LengthInSwitchTracks() {
    return _lengthInSwitchTracks;
  }

  public void LengthInSwitchTracks(Integer lengthInSwitchTracks) {
    _lengthInSwitchTracks = lengthInSwitchTracks;
  }

  public Integer Length() {
    return _length;
  }

  public void Length(Integer l) {
    _length = l;
  }

  public Boolean MouseOverCheck(Integer x, Integer y) {
    Integer x1 = _x, x2 = _x + _length; 
    Integer y1 = _y - 5, y2 = _y + 5;

    _mouseOverSwitchTrack = (x >= x1 && x <= x2
      && y >= y1 && y <= y2);

    return _mouseOverSwitchTrack;
  }

  public void Display() {
    Integer x1 = _x, x2 = _x + _length, 
      y1 = _y;

    if (_mouseOverSwitchTrack) {
      noStroke();
      fill(255);
      rect(x1, y1 - 5, _length, 11);
    } 

    stroke(0);
    strokeWeight(5);
    line(x1, y1, x2, y1);

    if (Constants.useNodeCircle) {
      _circle.display(x1, y1, #3EF761, 'A');
      _circle.display(x2, y1, #F7923E, 'B');
    }

    if (Constants.debug) {
      Integer letterX = x1 + abs((x1 - x2) / 2);
      Integer letterY = y1;
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
