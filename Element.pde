public class Element {
  protected Integer _id, _x, _y;
  protected Boolean _flip, _reverse, _isPositioned = false;
  protected NodeCircle _circle = new NodeCircle();
  protected Boolean _mouseOverSwitchTrack = false, _highlight = false;
  
  public Element (Integer id) {
    _id = id;
  }

  public void Display() {
    // override this function in the sub classes
    println("Element$display => function not overridden for element id: " + _id);
  };

  // functions
  public Integer Id()
  {
    return _id;
  }

  public void XY(Map<String, Integer> xy) {
    // set the start position for this element
    _x = xy.get("x");
    _y = xy.get("y");
    _isPositioned = true;
  }

  public Map<String, Integer> XY() 
  {
    Map<String, Integer> xy = new HashMap<String, Integer>();
    xy.put("x", _x);
    xy.put("y", _y);

    return xy;
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

  public void Highlight(Boolean highlight)
  {
    _highlight = highlight;
  }

  public Boolean IsPositioned()
  {
    return _isPositioned;
  }
  
  public Boolean MouseOverCheck(Integer x, Integer y) {
    // override this function in the subclasses
    return false;
  }
}
