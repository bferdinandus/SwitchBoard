public static class Constants {
  public final static Integer switchTrackWidth = 50;
  public final static Integer switchTrackHeight = 25;
  public final static Integer circleDiameter = 20;

  public static enum element {
    SWITCHTRACK
  }

  public static enum terminal {
    A("A"), 
    B("B"), 
    C("C");
    
    private String _value;
    private terminal(String value) 
    {
      _value = value;
    }
  }
}
