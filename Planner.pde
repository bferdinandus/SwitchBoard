public class Planner { //<>//
  ArrayList<Integer> _route = new ArrayList<Integer>();
  ArrayList<Integer> _stack = new ArrayList<Integer>();
  ArrayList<Integer> _checked = new ArrayList<Integer>();
  Board _board;

  Planner(Board board) {
    _board = board;
  }

  public void CalculateRoute (Integer trackId1, Integer trackId2) {

    //RouteElement rt = new RouteElement(1, Constants.terminal.A);
    //int x = rt.Id();
    println("Begin route berekenen...");
    _stack.add(trackId1);
    SearchStack(trackId2);
  }

  public void ExecuteRoute() {
    for (Integer i = 0; i < _route.size(); i++) { 
      // size - 1 omdat de laatste in een route altijd een track zal zijn.
      // die heeft geen acties
      Map<String, Element> currentNode = _board.GetNodeById(_route.get(i));
      Element currentElement = currentNode.get("self");
      currentElement.Highlight(true);
      if (i < _route.size() - 1) {
        Map<String, Element> nextNode = _board.GetNodeById(_route.get(i + 1));
        Element nextElement = nextNode.get("self");

        if (currentElement instanceof SwitchTrack) {
          // huidige wissel goed zetten
          if (currentNode.get(Constants.terminal.B.toString()).Id() == nextElement.Id()) {
            ((SwitchTrack) currentElement).SwitchToTerminal(Constants.terminal.B);
          }
          if (currentNode.get(Constants.terminal.C.toString()).Id() == nextElement.Id()) {
            ((SwitchTrack) currentElement).SwitchToTerminal(Constants.terminal.C);
          }
        }
        
        if (nextElement instanceof SwitchTrack) {
          // volgende wissel goed zetten
          if (currentElement.Id() == nextNode.get(Constants.terminal.B.toString()).Id()) {
            ((SwitchTrack) nextElement).SwitchToTerminal(Constants.terminal.B);
          }
          if (currentElement.Id() == nextNode.get(Constants.terminal.C.toString()).Id()) {
            ((SwitchTrack) nextElement).SwitchToTerminal(Constants.terminal.C);
          }
        }
      }
    }
  }

  private void SearchStack(Integer targetId) {
    if (_stack.size() == 0) { 
      return;
    }

    Integer currentNodeId = _stack.remove(0);

    if (!_route.contains(currentNodeId)) {
      _route.add(currentNodeId);
    }

    if (currentNodeId == targetId) {
      println("Doel gevonden");
      println("stack " + _stack);
      println("checked " + _checked);
      println("route " + _route);
      return ;
    }

    Integer nextNodeId = GetValidUncheckedElementId(currentNodeId);
    if (nextNodeId == null) {
      // laatste item van route verwijderen en 1 stap terug checken
      if (_route.size() > 0) {
        _route.remove(_route.size() - 1);
      }
      if (_route.size() > 0) {
        _stack.add(_route.get(_route.size() - 1));
      } else {
        println("geen route meer over");        
        println("stack " + _stack);
        println("checked " + _checked);
        println("route " + _route);
        return;
      }
    } else {
      _stack.add(nextNodeId);
    }

    if (!_checked.contains(currentNodeId)) {
      _checked.add(currentNodeId);
    }

    println("stack " + _stack);
    println("checked " + _checked);
    println("route " + _route);
    SearchStack(targetId);
  }

  private Integer GetValidUncheckedElementId(Integer id) {
    Map<String, Element> node = _board.GetNodeById(id);

    Element el = node.get(Constants.terminal.A.toString());
    if (el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };

    el = node.get(Constants.terminal.B.toString());
    if (el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };

    el = node.get(Constants.terminal.C.toString());
    if (el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };

    return null;
  }
}
