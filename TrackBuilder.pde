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

    if (options.containsKey("diagonal")) {
      track.Diagonal((Boolean)options.get("diagonal"));
    }

    if (options.containsKey("flip")) {
      track.Flip((Boolean)options.get("flip"));
    }

    if (options.containsKey("name")) {
      track.Name((String)options.get("name"));
    }

    if (options.containsKey("alignName")) {
      track.AlignName((Integer)options.get("alignName"));
    }

    return track;
  }
}
