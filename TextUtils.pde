public class TextUtils 
{
  private String _text;
  private Integer _x, _y, _colour, _outlineColour, _size, _hAlign = LEFT, _vAlign = BOTTOM;
  private Boolean _outline;

  TextUtils(String text, Integer size, Integer x, Integer y, Integer colour, Integer outlineColour) {
    _text = text;
    _x = x;
    _y = y;
    _size = size;
    _colour = colour;
    _outline = true;
    _outlineColour = outlineColour;
  }

  TextUtils(String text, Integer size, Integer x, Integer y) {
    _text = text;
    _x = x;
    _y = y;
    _size = size;
    _colour = 0;
    _outline = false;
  }
  
  public void Align(Integer hAlign, Integer vAlign) {
    _hAlign = hAlign;
    _vAlign = vAlign;
  }

  public void Display() {
    textSize(_size);
    textAlign(_hAlign, _vAlign);
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
