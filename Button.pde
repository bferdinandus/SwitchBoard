public class Button 
{
  private String _text;
  private Integer _x, _y, _margin = 2, _textSize = 15, _textWidth;
  private Boolean _mouseOver = false, _mousePressed = false;
  private Constants.buttons _id;

  Button() {
  }

  Button(Constants.buttons id, String text, Integer x, Integer y) {
    _id = id;
    _text = text;
    _x = x;
    _y = y;
  }

  public Boolean MouseOverCheck(Integer x, Integer y) {
    Integer x1 = _x - _margin, x2 = _x - _margin + _textWidth + (2 * _margin); 
    Integer y1 = _y, y2 = _y + _textSize + (2 * _margin);

    _mouseOver = (x >= x1 && x <= x2
      && y >= y1 && y <= y2);

    return _mouseOver;
  }
  
  public Constants.buttons Id() {
    return _id;
  }
  
  public void MousePressed() {
    _mousePressed = true;
  }

  public void MouseReleased() {
    _mousePressed = false;
  }
  
  public void Display() {
    textAlign(LEFT, TOP);
    textSize(_textSize);
    _textWidth = round(textWidth(_text));
    
    stroke(0);
    strokeWeight(1);
    fill(128);
    if (_mouseOver && !_mousePressed) {
      fill(255);
    } else if (_mouseOver && _mousePressed) {
      fill(64);
    }
    rect(_x - _margin, _y, _textWidth + (2 * _margin), _textSize + (2 * _margin));

    fill(0);
    text(_text, _x, _y );
  }
}
