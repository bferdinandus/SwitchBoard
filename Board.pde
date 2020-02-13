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
  Map<Integer, Map<String, Node>> _elements = new TreeMap<Integer, Map<String, Node>>();

  public Board() {
  }

  public void AddSwitchTrack(Integer id, Boolean flip, Boolean reverse, Integer termA, Integer termB, Integer termC)
  {
    Map<String, Node> node;
    if (!ElementExists(id)) {
      node = new HashMap<String, Node>();
      node.put("self", new SwitchTrack(flip, reverse, id));
    } else {
      node = GetNodeById(id);
      node.get("self").setFlip(flip);
      node.get("self").setReverse(reverse);
    }
    if (termA > 0) {
      if (!ElementExists(termA)) {
        AddSwitchTrack(termA, false, false, 0, 0, 0);
      } 
      node.put("A", GetElementById(termA));
    }
    if (termB > 0) {
      if (!ElementExists(termB)) {
        AddSwitchTrack(termB, false, false, 0, 0, 0);
      } 
      node.put("B", GetElementById(termB));
    }
    if (termC > 0) {
      if (!ElementExists(termC)) {
        AddSwitchTrack(termC, false, false, 0, 0, 0);
      } 
      node.put("C", GetElementById(termC));
    }

    _elements.put(id, node);
  }

  public Node GetElementById(Integer id) 
  {
    return GetNodeById(id).get("self");
  }

  public void UpdatePositions() 
  {
    for (Map<String, Node> element : board.GetElements().values()) {
      Node currentNode = element.get("self");
      if (currentNode._id == 1) {
        // alleen voor het eerste element de positie "hard" instellen. De rest gaat relatief ten opzichte van dit element
        currentNode.setXY(50, height / 2);
      }
      Map<String, Integer> currentNodeXY = currentNode.getXY();
      if (element.get("A") != null) {
        //element.get("A").setXY()
      };
      if (element.get("B") != null && !element.get("B").IsPositioned()) {
        // 50 breedte van de wissel, 20 node cirkel diameter
        element.get("B").setXY(currentNodeXY.get("x") + 50 + 20, currentNodeXY.get("y"));
      };
      if (element.get("C") != null && !element.get("C").IsPositioned()) {
        // 50 breedte van de wissel, 20 node cirkel diameter, 25 hoogte van de wissel
        element.get("C").setXY(currentNodeXY.get("x") + 50 + 20, currentNodeXY.get("y") - 25);
      };

    }
  }

  public Map<Integer, Map<String, Node>> GetElements() 
  {
    return _elements;
  }

  private Map<String, Node> GetNodeById(Integer id) 
  {
    return _elements.get(id);
  }

  private boolean ElementExists(Integer id) {
    return _elements.containsKey(id);
  }
}
