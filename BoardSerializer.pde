public class BoardSerializer {
  protected Board _board;

  public BoardSerializer(Board board) {
    _board = board;
  }

  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();

    json.setJSONArray("elements", elementsToJSON());

    return json;
  }

  private JSONArray elementsToJSON() {
    JSONArray json = new JSONArray();

    for (Node node : _board.GetNodes().values()) {
      Element element = node.get("self");

      JSONObject serializedElement = null;

      if (element instanceof SwitchTrack) {
        serializedElement = new SwitchTrackSerializer((SwitchTrack) element).toJSONObject();
      } else if (element instanceof Track) {
        serializedElement = new TrackSerializer((Track) element).toJSONObject();
      } else {
        // not implemented
      }

      if (serializedElement != null) {
        json.append(serializedElement);
      }
    }

    return json;
  }
}
