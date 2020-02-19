public class Planner { //<>// //<>// //<>//
  ArrayList<Integer> _route = new ArrayList<Integer>();
  ArrayList<Integer> _stack = new ArrayList<Integer>();
  ArrayList<Integer> _checked = new ArrayList<Integer>();
  Board _board;

  private class RouteElement {
    private Integer _id;
    private Constants.terminal _terminal;

    RouteElement(Integer id, Constants.terminal terminal) {
      _id = id;
      _terminal = terminal;
    }

    public Integer Id() { 
      return _id;
    }
    public Constants.terminal Terminal() { 
      return _terminal;
    }
  }

  Planner(Board board) {
    _board = board;
  }

  public Object CalculateRoute (Integer trackId1, Integer trackId2) {

    //RouteElement rt = new RouteElement(1, Constants.terminal.A);
    //int x = rt.Id();
    _stack.add(trackId1);

    SearchStack(trackId2);

    return new Object();
  }

  public void ExecuteRoute(Object obj) {
  }

  private void SearchStack(Integer targetId) {
    if (_stack.size() == 0) { 
      return;
    }

    Integer currentNodeId = _stack.remove(0);

    if (!_route.contains(currentNodeId)) {
      _route.add(currentNodeId);
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
    } else if (nextNodeId == targetId) {
      _route.add(nextNodeId);
      println("Doel gevonden");
      println("stack " + _stack);
      println("checked " + _checked);
      println("route " + _route);
      return ;
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
