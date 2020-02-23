public class Planner
{
  ArrayList<Integer> _route = new ArrayList<Integer>();
  ArrayList<Integer> _stack = new ArrayList<Integer>();
  ArrayList<Integer> _checked = new ArrayList<Integer>();
  Board _board;

  Planner(Board board) {
    _board = board;
  }

  public Boolean CalculateRoute (Integer trackId1, Integer trackId2) {
    println("Begin route berekenen...");
    _stack.add(trackId1);
    return SearchStack(trackId2);
  }

  public void ExecuteRoute() {
    for (Integer i = 0; i < _route.size(); i++) {
      Node currentNode = _board.GetNodeById(_route.get(i));
      Element currentElement = currentNode.get("self");
      currentElement.Highlight(true);

      // size - 1 omdat de laatste in een route altijd een track zal zijn.
      // die heeft geen acties
      if (i < _route.size() - 1) {
        Node nextNode = _board.GetNodeById(_route.get(i + 1));
        Element nextElement = nextNode.get("self");

        if (currentElement instanceof SwitchTrack) {
          // huidige wissel goed zetten
          Element currentElementForTerminalB = currentNode.get(Constants.terminal.B.toString());
          Element currentElementForTerminalC = currentNode.get(Constants.terminal.C.toString());

          if (currentElementForTerminalB != null) {
            if (currentElementForTerminalB.Id() == nextElement.Id()) {
              ((SwitchTrack) currentElement).SwitchToTerminal(Constants.terminal.B);
            }
          }

          if (currentElementForTerminalC != null) {
            if (currentElementForTerminalC.Id() == nextElement.Id()) {
              ((SwitchTrack) currentElement).SwitchToTerminal(Constants.terminal.C);
            }
          }
        }

        if (nextElement instanceof SwitchTrack) {
          // volgende wissel goed zetten
          Element nextElementForTerminalB = nextNode.get(Constants.terminal.B.toString());
          Element nextElementForTerminalC = nextNode.get(Constants.terminal.C.toString());

          if (nextElementForTerminalB != null) {
            if (currentElement.Id() == nextElementForTerminalB.Id()) {
              ((SwitchTrack) nextElement).SwitchToTerminal(Constants.terminal.B);
            }
          }

          if (nextElementForTerminalC != null) {
            if (currentElement.Id() == nextElementForTerminalC.Id()) {
              ((SwitchTrack) nextElement).SwitchToTerminal(Constants.terminal.C);
            }
          }
        }
      }
    }
  }

  private boolean SearchStack(Integer targetId) {
    println("===================");
    println("stack " + _stack);
    println("checked " + _checked);
    println("route " + _route);
    if (_stack.size() == 0) {
      return false;
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
      return true;
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
        return false;
      }
    } else {
      _stack.add(nextNodeId);
    }

    if (!_checked.contains(currentNodeId)) {
      _checked.add(currentNodeId);
    }

    return SearchStack(targetId);
  }

  private Integer GetValidUncheckedElementId(Integer id) {
    Node node = _board.GetNodeById(id);
    Boolean isValidTerminalA = true, isValidTerminalB = true, isValidTerminalC = true;
    if (node.get("self") instanceof SwitchTrack) {
      // als de huidige node een wissel is dan moet je weten aan welke terminal de vorige node zit
      // route.size() -1 is het laatste item, size - 2 is het voorlaatste item
      Constants.terminal lastRouteNodeOnTerminal = GetTerminalById(node, _route.get(_route.size() - 2));
      // als de laatse node van de route op terminal a zit, dan alleen b of c checken
      if (lastRouteNodeOnTerminal == Constants.terminal.A) {
        isValidTerminalA = false;
      } else if (lastRouteNodeOnTerminal == Constants.terminal.B || lastRouteNodeOnTerminal == Constants.terminal.C) {
        isValidTerminalB = false;
        isValidTerminalC = false;
      }
      // als de laatse node van de route op terminal b of c zit, dan alleen a checken
    }
    Element el;

    el = node.get(Constants.terminal.A.toString());
    if (isValidTerminalA && el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };
    el = node.get(Constants.terminal.B.toString());
    if (isValidTerminalB && el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };

    el = node.get(Constants.terminal.C.toString());
    if (isValidTerminalC && el != null && !_checked.contains(el.Id())) {
      return el.Id();
    };

    return null;
  }

  private Constants.terminal GetTerminalById(Node node, Integer id) {
    // op de gegeven node zoeken of er een terminal is bezet door een element met het gegeven id
    Element el = node.get(Constants.terminal.A.toString());
    if (el != null && el.Id() == id) {
      return Constants.terminal.A;
    };
    el = node.get(Constants.terminal.B.toString());
    if (el != null && el.Id() == id) {
      return Constants.terminal.B;
    };
    el = node.get(Constants.terminal.C.toString());
    if (el != null && el.Id() == id) {
      return Constants.terminal.C;
    };

    return null;
  }
}
