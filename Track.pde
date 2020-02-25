public class Track extends Element
{
  private Integer _length, _lengthInSwitchTracks = 1;
  private Boolean _diagonal = false;
  private String _name = "";
  private Integer _alignName = LEFT;

  public Track(Integer id) {
    super(id);

    calculateLength();
  }

  public Boolean Diagonal() {
    return _diagonal;
  }

  public void Diagonal(Boolean diagonal) {
    _diagonal = diagonal;
  }

  public String Name() {
    return _name;
  }

  public void Name(String name) {
    _name = name;
  }

  public void AlignName(Integer alignName) {
    _alignName = alignName;
  }

  public Integer LengthInSwitchTracks() {
    return _lengthInSwitchTracks;
  }

  public void LengthInSwitchTracks(Integer lengthInSwitchTracks) {
    _lengthInSwitchTracks = lengthInSwitchTracks;

    calculateLength();
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

      TextUtils text = new TextUtils().Size(20).Colour(#ffffff).OutlineColour(#000000).Align(CENTER, CENTER);
      text.Text(_id.toString(), letterX, letterY);
    }


    TextUtils text = new TextUtils().Size(15).Colour(#ffffff).OutlineColour(#000000);
    if (_alignName == RIGHT) {
      text.Align(RIGHT, BOTTOM).Text(_name.toString(), x2, y1);
    } else {
      text.Align(LEFT, BOTTOM).Text(_name.toString(), x1, y1);
    }
    
  }

  private void calculateLength() {
    _length = _lengthInSwitchTracks * Constants.switchTrackWidth + (_lengthInSwitchTracks - 1) * circleDiameter();
  }

  private Integer circleDiameter() {
    Integer circleDiameter = Constants.circleDiameter;

    if (!Constants.useNodeCircle) {
      circleDiameter = 0;
    }

    return circleDiameter;
  }
}
