public class Node {
  private Map<String, Element> _node = new HashMap<String, Element>();
  
  Node() {
  }
  
  public Element get(String item) {
    return _node.get(item);
  }
  
  public void put(String item, Element element) {
    _node.put(item, element);
  }
  
  public boolean containsKey(String item) {
    return _node.containsKey(item);
  }
  
}
