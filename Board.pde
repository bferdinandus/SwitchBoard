  /*    
    Een wissel ziet er als volgt uit.
    Terminal a: waar de splitsing begint
    Terminal b: het stuk dat rechtdoor loopt
    Terminal c: het stuk dat afbuigt
    
           C
          / 
         /
        A--B
  */

public class Board {
  Map<Integer, Map<String, Node>> _elements = new HashMap<Integer, Map<String, Node>>();

  public Board() {
  }

  public void addSwitchTrack(int id, int termA, int termB, int termC)
  {
    Map<String, Node> node;
    if (!elementExists(id)) {
      node = new HashMap<String, Node>();
      node.put("self", new SwitchTrack(false, false, id));
    } else {
      node = getNodeById(id);
    }
    if (termA > 0) {
      if (!elementExists(termA)) {
        addSwitchTrack(termA, 0, 0, 0);
      } 
      node.put("A", getElementById(termA));
    }
    if (termB > 0) {
      if (!elementExists(termB)) {
        addSwitchTrack(termB, 0, 0, 0);
      } 
      node.put("B", getElementById(termB));
    }
    if (termC > 0) {
      if (!elementExists(termC)) {
        addSwitchTrack(termC, 0, 0, 0);
      } 
      node.put("C", getElementById(termC));
    }

    _elements.put(id, node);
  }

  public Node getElementById(int id) 
  {
    return getNodeById(id).get("self");
  }

  public Map<String, Node> getNodeById(int id) 
  {
    return _elements.get(id);
  }

  private boolean elementExists(int id) {
    return _elements.containsKey(id);
  }
}
