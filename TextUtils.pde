public class TextUtils 
{
  private String _text;
  private Integer _x, _y, _colour, _outlineColour, _size, _hAlign = LEFT, _vAlign = BOTTOM;
  private Boolean _outline;

  TextUtils() {
    _size = 10;
    _colour = 0;
    _outline = false;
  }

  public void Text(String text, Integer x, Integer y) {
    _text = text;
    _x = x;
    _y = y;

    Display();
  };

  public TextUtils Size(Integer size) {
    _size = size;

    return this;
  }

  public TextUtils Colour(Integer colour) {
    _colour = colour;

    return this;
  }

  public TextUtils OutlineColour(Integer outlineColour) {
    _outlineColour = outlineColour;
    _outline = true;

    return this;
  }

  public TextUtils Align(Integer hAlign, Integer vAlign) {
    _hAlign = hAlign;
    _vAlign = vAlign;

    return this;
  }

  public Integer TextWidth(String text) {
    textSize(_size);

    return round(textWidth(text));
  }

  private void Display() {
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
