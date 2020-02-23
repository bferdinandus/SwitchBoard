public class TrackSerializer extends ElementSerializer {
  protected Track _track;

  public TrackSerializer(Track track) {
    super(track);

    _track = track;
  }

  public JSONObject toJSONObject() {
    JSONObject json = super.toJSONObject();

    json.setInt("type", Constants.element.Track);

    json.setInt("lengthInSwitchTracks", _track.LengthInSwitchTracks());
    json.setInt("diagonal", _track.Diagonal());

    return json;
  }
}
