public static class Constants 
{
  public final static Boolean debug = true;
  public final static Boolean useNodeCircle = false;
  public final static Integer circleDiameter = 20;
  public final static Integer trackBoxHeight = 20;


  public final static Integer switchTrackWidth = 80;
  public final static Integer switchTrackHeight = 30;


  public static enum element {
    SwitchTrack, 
      Track
  }

  public static enum buttons {
    Reset, 
      PlanRoute
  }

  public static enum terminal {
    A("termA"), 
      B("termB"), 
      C("termC");

    private String _value;
    private terminal(String value)
    {
      _value = value;
    }
  }
}
