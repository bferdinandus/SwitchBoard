public class SwitchTrackSerializer extends ElementSerializer {
  protected SwitchTrack _switchTrack;

  public SwitchTrackSerializer(SwitchTrack switchTrack) {
    super(switchTrack);

    _switchTrack = switchTrack;
  }

  public JSONObject toJSONObject() {
    JSONObject json = super.toJSONObject();

    json.setString("type", "SwitchTrack");

    return json;
  }
}
