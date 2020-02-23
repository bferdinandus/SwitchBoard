public class TextUtils 
{
  private String _text;
  private Integer _x, _y, _colour, _outlineColour, _size;
  private Boolean _outline;

  TextUtils(String text, Integer size, Integer x, Integer y, Integer colour, Boolean outline, Integer outlineColour) {
    _text = text;
    _x = x;
    _y = y;
    _size = size;
    _colour = colour;
    _outline = outline;
    _outlineColour = outlineColour;
  }

  TextUtils(String text, Integer x, Integer y, Integer size) {
    _text = text;
    _x = x;
    _y = y;
    _size = size;
    _colour = 0;
    _outline = false;
  }

  public void Display() {
    textSize(_size);
    textAlign(LEFT, BOTTOM);
    if (_outline) {
      fill(_outlineColour);
      text(_text, _x - 1, _y);
      text(_text, _x + 1, _y);
      text(_text, _x, _y - 1);
      text(_text, _x, _y + 1);
    }
    fill(_colour);
    text(_text, _x, _y);
  }
}
