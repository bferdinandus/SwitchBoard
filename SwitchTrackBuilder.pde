public class SwitchTrackBuilder {
  private Integer _id;

  public SwitchTrackBuilder() {
  }

  public SwitchTrackBuilder setId(Integer id) {
    _id = id;

    return this;
  }

  public SwitchTrack build() {
    return new SwitchTrack(_id);
  }

  public SwitchTrack buildWithOptions(Map<String, Object> options) {
    SwitchTrack switchTrack = build();

    if (options.containsKey("flip")) {
      switchTrack.Flip((Boolean)options.get("flip"));
    }

    if (options.containsKey("reverse")) {
      switchTrack.Reverse((Boolean)options.get("reverse"));
    }

    return switchTrack;
  }
}
