public class ElementSerializer {
  protected Element _element;

  public ElementSerializer(Element element) {
    _element = element;
  }

  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();

    json.setInt("id", _element.Id());
    json.setBoolean("flip", _element.Flip());
    json.setBoolean("reverse", _element.Reverse());

    return json;
  }
}
