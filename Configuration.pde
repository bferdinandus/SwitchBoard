public static class Configuration {
  
  public static void loadSingleSwitch(Board board) {
    board.AddElement(Constants.element.SwitchTrack, 1);
  }
  
  public static void loadSchaduwStation(Board board) {
    // arguments: element type:enum, element Id:Integer, options: Map (optioneel)
    Map<String, Object> options = new HashMap<String, Object>();
    options.put("numberOfSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 22, options);
    options.clear();
    options.put("flip", true);
    //options.put("reverse", false);
    //options.put("iets_anders", "wat dan");
    board.AddElement(Constants.element.SwitchTrack, 1, options);
    board.AddElement(Constants.element.SwitchTrack, 2, options);
    board.AddElement(Constants.element.SwitchTrack, 3, options);
    options.clear();
    options.put("reverse", true);
    board.AddElement(Constants.element.SwitchTrack, 4, options);
    board.AddElement(Constants.element.SwitchTrack, 5);
    board.AddElement(Constants.element.SwitchTrack, 6);
    board.AddElement(Constants.element.SwitchTrack, 7);
    options.clear();
    options.put("flip", true);
    board.AddElement(Constants.element.SwitchTrack, 8, options);
    board.AddElement(Constants.element.SwitchTrack, 9, options);
    board.AddElement(Constants.element.SwitchTrack, 10);
    options.clear();
    options.put("numberOfSwitchTracks", 4);
    board.AddElement(Constants.element.Track, 11, options);
    board.AddElement(Constants.element.Track, 15, options);
    board.AddElement(Constants.element.Track, 18, options);
    board.AddElement(Constants.element.Track, 19, options);
    options.put("numberOfSwitchTracks", 3);
    board.AddElement(Constants.element.Track, 12, options);
    board.AddElement(Constants.element.Track, 16, options);
    board.AddElement(Constants.element.Track, 20, options);
    board.AddElement(Constants.element.Track, 21, options);  
    options.put("numberOfSwitchTracks", 2);
    board.AddElement(Constants.element.Track, 13, options);
    board.AddElement(Constants.element.Track, 17, options);
    options.put("numberOfSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 14, options);

    // arguments: id1, terminal bij id1, id2, terminal bij id2
    board.ConnectTerminals(22, Constants.terminal.B, 1, Constants.terminal.A);
    board.ConnectTerminals(1, Constants.terminal.C, 2, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.C, 3, Constants.terminal.A);
    board.ConnectTerminals(3, Constants.terminal.C, 4, Constants.terminal.C);
    board.ConnectTerminals(1, Constants.terminal.B, 5, Constants.terminal.A);
    board.ConnectTerminals(5, Constants.terminal.C, 6, Constants.terminal.A);
    board.ConnectTerminals(6, Constants.terminal.C, 7, Constants.terminal.A);
    board.ConnectTerminals(7, Constants.terminal.C, 8, Constants.terminal.C);
    board.ConnectTerminals(8, Constants.terminal.B, 9, Constants.terminal.A);
    board.ConnectTerminals(4, Constants.terminal.B, 10, Constants.terminal.A);
    board.ConnectTerminals(5, Constants.terminal.B, 11, Constants.terminal.A);
    board.ConnectTerminals(6, Constants.terminal.B, 12, Constants.terminal.A);
    board.ConnectTerminals(7, Constants.terminal.B, 13, Constants.terminal.A);
    board.ConnectTerminals(8, Constants.terminal.A, 14, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.B, 15, Constants.terminal.A);
    board.ConnectTerminals(3, Constants.terminal.B, 16, Constants.terminal.A);
    board.ConnectTerminals(4, Constants.terminal.A, 17, Constants.terminal.A);
    board.ConnectTerminals(9, Constants.terminal.B, 18, Constants.terminal.B);
    board.ConnectTerminals(9, Constants.terminal.C, 19, Constants.terminal.B);
    board.ConnectTerminals(10, Constants.terminal.C, 20, Constants.terminal.B);
    board.ConnectTerminals(10, Constants.terminal.B, 21, Constants.terminal.B);
  }
}
