public class TrackSerializer extends ElementSerializer {
  protected Track _track;

  public TrackSerializer(Track track) {
    super(track);

    _track = track;
  }

  public JSONObject toJSONObject() {
    JSONObject json = super.toJSONObject();

    json.setInt("lengthInSwitchTracks", _track.LengthInSwitchTracks());

    return json;
  }
}
