public class Track extends Element 
{
  private Integer _length, _lengthInSwitchTracks = 1;
  private Boolean _diagonal=false;

  // constructors
  public Track(Integer id) {
    // first call contructor of the parent
    super(id);
    _flip = false;
    _reverse = false;
  }

  public Boolean Diagonal() {
    return _diagonal;
  }

  public void Diagonal(Boolean diagonal) {
    _diagonal = diagonal;
  }

  public Integer LengthInSwitchTracks() {
    return _lengthInSwitchTracks;
  }

  public void LengthInSwitchTracks(Integer lengthInSwitchTracks) {
    _lengthInSwitchTracks = lengthInSwitchTracks;

    Integer circleDiameter = Constants.circleDiameter;
    if (!Constants.useNodeCircle) {
      circleDiameter = 0;
    }

    _length = (LengthInSwitchTracks() * Constants.switchTrackWidth) + ((LengthInSwitchTracks() - 1) * circleDiameter);
  }

  public Integer Length() {
    return _length;
  }

  public Boolean MouseOverCheck(Integer x, Integer y) {
    Integer x1 = _x, x2 = _x + _length, 
      y1 = _y, y2 = _y;

    if (_diagonal) {
      if (_flip) {
        y2 = _y + Constants.switchTrackHeight;
      } else {
        y2 = _y - Constants.switchTrackHeight;
      }
    }
    
    y1 -= (Constants.trackBoxHeight / 2);
    y2 += (Constants.trackBoxHeight / 2) + 1;
    
    _mouseOverSwitchTrack = (x >= x1 && x <= x2
      && y >= y1 && y <= y2);

    return _mouseOverSwitchTrack;
  }

  public void Display() {
    Integer x1 = _x, x2 = _x + _length, 
      y1 = _y, y2 = _y;

    if (_diagonal) {
      if (_flip) {
        y2 = _y + Constants.switchTrackHeight;
      } else {
        y2 = _y - Constants.switchTrackHeight;
      }
    }

    if (_mouseOverSwitchTrack) {
      noStroke();
      fill(230);
      rect(x1, y1 - (Constants.trackBoxHeight / 2), _length, Constants.trackBoxHeight + abs(y1 - y2) + 1);
    } 

    stroke(0);
    strokeWeight(5);
    if (_highlight) {
      stroke(#F5DB7E);
    } else {
      stroke(0);
    }
    line(x1, y1, x2, y2);

    if (Constants.useNodeCircle) {
      _circle.display(x1, y1, #3EF761, 'A');
      _circle.display(x2, y2, #F7923E, 'B');
    }

    if (Constants.debug) {
      Integer letterX = x1 + abs((x1 - x2) / 2);
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
