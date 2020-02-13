public class Node {
  protected Integer _id;

  public Node (Integer id) {
    _id = id;
  }

  public void display() {
    // override this function in the sub classes
  };

  public void setXY(Integer x, Integer y) {
    // override this function in the sub classes
  }

  public void setFlip(Boolean flip) 
  {
    // override in SwitchTrack
  }

  public void setReverse(Boolean reverse)
  {
    // override in SwitchTrack
  }
  
  public Map<String, Integer> getXY()
  {
      // override in SwitchTrack
      return new HashMap<String, Integer>();
  }
  
  public Boolean IsPositioned()
  {
    // override in SwitchTrack
    return false;
  }

}
