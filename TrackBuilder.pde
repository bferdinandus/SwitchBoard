public class TrackBuilder {
  private Integer _id;

  public TrackBuilder() {
  }

  public TrackBuilder setId(Integer id) {
    _id = id;

    return this;
  }

  public Track build() {
    return new Track(_id);
  }

  public Track buildWithOptions(Map<String, Object> options) {
    Track track = build();

    if (options.containsKey("lengthInSwitchTracks")) {
      track.LengthInSwitchTracks((Integer)options.get("lengthInSwitchTracks"));
    }

    return track;
  }
}
