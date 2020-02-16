public class SwitchTrack extends Element { //<>//
  // constructors
  public SwitchTrack(Integer id) {
    // first call contructor of the parent
    super(id);
  }

  public void Display() {
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

    line(x1, y1, x2, y1);
    line(x1, y1, x2, y2);

    if (Constants.debug) {
      _circle.display(x1, y1, #3EF761, 'A');
      _circle.display(x2, y1, #F7923E, 'B');
      _circle.display(x2, y2, #FC2424, 'C');

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

      fill(#000000);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(_id, letterX, letterY);
    }
  }
}
