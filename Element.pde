public class Element {
  protected Integer _id, _x, _y;
  protected Boolean _isPositioned = false;

  public Element (Integer id) {
    _id = id;
  }

  public void display() {
    // override this function in the sub classes
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

  public Boolean IsPositioned()
  {
    return _isPositioned;
  }
}
