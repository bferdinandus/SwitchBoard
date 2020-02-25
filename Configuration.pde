public static class Configuration
{
  public static void loadBoards(Map<Integer, Board> boards, SwitchBoard switchboard) {
    Board board;

    board = loadKnzHengelo(switchboard);
    boards.put(0, board);

    board = loadSmallBoard(switchboard);
    boards.put(1, board);

    board = loadSmallTestBoard(switchboard);
    boards.put(2, board);

    board = loadSchaduwStation(switchboard);
    boards.put(3, board);
  }

  public static Board loadSmallTestBoard(SwitchBoard switchboard) {
    Board board = switchboard.new Board();
    board.Name("SmallTestBoard");

    Map<String, Object> options = new HashMap<String, Object>();
    options.put("lengthInSwitchTracks", 3);
    board.AddElement(Constants.element.Track, 1, options);
    board.AddElement(Constants.element.Track, 3, options);
    options.put("lengthInSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 5, options);
    options.clear();
    options.put("flip", true);
    board.AddElement(Constants.element.SwitchTrack, 2, options);
    board.AddElement(Constants.element.SwitchTrack, 4);
    board.AddElement(Constants.element.SwitchTrack, 6);

    board.ConnectTerminals(1, Constants.terminal.B, 2, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.B, 3, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.C, 4, Constants.terminal.C);
    board.ConnectTerminals(4, Constants.terminal.B, 5, Constants.terminal.B);
    board.ConnectTerminals(5, Constants.terminal.A, 6, Constants.terminal.A);

    return board;
  }

  public static Board loadKnzHengelo(SwitchBoard switchboard) {
    Board board = switchboard.new Board();
    board.Name("KnzHengelo");

    Map<String, Object> options = new HashMap<String, Object>();
    options.put("lengthInSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 1, options);
    board.AddElement(Constants.element.Track, 10, options);
    board.AddElement(Constants.element.Track, 16, options);
    board.AddElement(Constants.element.Track, 17, options);
    board.AddElement(Constants.element.Track, 23, options);
    options.put("diagonal", true);
    options.put("flip", true);
    board.AddElement(Constants.element.Track, 24, options);
    options.clear();
    options.put("lengthInSwitchTracks", 3);
    board.AddElement(Constants.element.Track, 6, options);
    options.put("lengthInSwitchTracks", 5);
    board.AddElement(Constants.element.Track, 22, options);
    board.AddElement(Constants.element.Track, 9, options);
    board.AddElement(Constants.element.Track, 13, options);
    options.put("lengthInSwitchTracks", 6);
    board.AddElement(Constants.element.Track, 20, options);
    board.AddElement(Constants.element.Track, 21, options);
    options.put("lengthInSwitchTracks", 7);
    board.AddElement(Constants.element.Track, 19, options);
    options.clear();
    options.put("flip", true);
    board.AddElement(Constants.element.SwitchTrack, 2, options);
    board.ConnectTerminals(1, Constants.terminal.B, 2, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 3);
    board.ConnectTerminals(2, Constants.terminal.B, 3, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 4);
    board.ConnectTerminals(3, Constants.terminal.B, 4, Constants.terminal.C);
    board.AddElement(Constants.element.SwitchTrack, 5, options);
    board.ConnectTerminals(3, Constants.terminal.C, 5, Constants.terminal.C);
    board.ConnectTerminals(5, Constants.terminal.B, 6, Constants.terminal.B);
    board.AddElement(Constants.element.SwitchTrack, 7);
    board.ConnectTerminals(5, Constants.terminal.A, 7, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 8, options);
    board.ConnectTerminals(7, Constants.terminal.C, 8, Constants.terminal.C);
    board.ConnectTerminals(8, Constants.terminal.B, 9, Constants.terminal.B);
    board.ConnectTerminals(4, Constants.terminal.B, 10, Constants.terminal.B);
    board.ConnectTerminals(2, Constants.terminal.C, 10, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 11, options);
    board.ConnectTerminals(4, Constants.terminal.A, 11, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 12);
    board.ConnectTerminals(11, Constants.terminal.C, 12, Constants.terminal.C);
    board.ConnectTerminals(12, Constants.terminal.B, 13, Constants.terminal.B);
    board.AddElement(Constants.element.SwitchTrack, 14, options);
    board.ConnectTerminals(12, Constants.terminal.A, 14, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 15);
    board.ConnectTerminals(14, Constants.terminal.C, 15, Constants.terminal.C);
    board.ConnectTerminals(14, Constants.terminal.B, 16, Constants.terminal.A);
    board.ConnectTerminals(15, Constants.terminal.A, 17, Constants.terminal.A);
    board.ConnectTerminals(15, Constants.terminal.B, 19, Constants.terminal.B);
    board.ConnectTerminals(11, Constants.terminal.B, 20, Constants.terminal.A);
    board.ConnectTerminals(7, Constants.terminal.B, 21, Constants.terminal.A);
    board.ConnectTerminals(8, Constants.terminal.A, 22, Constants.terminal.A);
    board.AddElement(Constants.element.SwitchTrack, 18);
    board.ConnectTerminals(17, Constants.terminal.B, 18, Constants.terminal.B);
    board.ConnectTerminals(18, Constants.terminal.A, 23, Constants.terminal.A);

    board.ConnectTerminals(16, Constants.terminal.B, 24, Constants.terminal.A);
    board.ConnectTerminals(24, Constants.terminal.B, 18, Constants.terminal.C);

    return board;
  }

  public static Board loadSmallBoard(SwitchBoard switchboard) {
    Board board = switchboard.new Board();
    board.Name("SmallBoard");

    Map<String, Object> options = new HashMap<String, Object>();
    options.put("lengthInSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 1, options);
    board.AddElement(Constants.element.Track, 4, options);
    board.AddElement(Constants.element.Track, 8, options);
    options.put("lengthInSwitchTracks", 2);

    options.put("lengthInSwitchTracks", 1);
    board.AddElement(Constants.element.Track, 5, options);
    board.AddElement(Constants.element.Track, 6, options);

    options.clear();
    board.AddElement(Constants.element.SwitchTrack, 2);
    board.AddElement(Constants.element.SwitchTrack, 3);
    options.put("flip", true);
    board.AddElement(Constants.element.SwitchTrack, 7, options);

    board.ConnectTerminals(1, Constants.terminal.B, 2, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.B, 7, Constants.terminal.A);
    board.ConnectTerminals(2, Constants.terminal.C, 3, Constants.terminal.A);
    board.ConnectTerminals(3, Constants.terminal.B, 5, Constants.terminal.A);
    board.ConnectTerminals(3, Constants.terminal.C, 6, Constants.terminal.A);
    board.ConnectTerminals(7, Constants.terminal.B, 4, Constants.terminal.A);
    board.ConnectTerminals(7, Constants.terminal.C, 8, Constants.terminal.A);

    return board;
  }

  public static Board loadSchaduwStation(SwitchBoard switchboard) {
    Board board = switchboard.new Board();
    board.Name("SchaduwStation");

    // arguments: element type:enum, element Id:Integer, options: Map (optioneel)
    Map<String, Object> options = new HashMap<String, Object>();
    options.put("lengthInSwitchTracks", 1);
    options.put("name", "Aankomst");
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
    options.put("lengthInSwitchTracks", 4);
    options.put("alignName", RIGHT);
    options.put("name", "Spoor 4");
    board.AddElement(Constants.element.Track, 11, options);
    options.put("name", "Spoor 3");
    board.AddElement(Constants.element.Track, 15, options);
    options.put("alignName", LEFT);
    options.put("name", "Spoor 72");
    board.AddElement(Constants.element.Track, 18, options);
    options.put("name", "Spoor 71");
    board.AddElement(Constants.element.Track, 19, options);
    options.put("lengthInSwitchTracks", 3);
    options.put("alignName", RIGHT);
    options.put("name", "Spoor 5");
    board.AddElement(Constants.element.Track, 12, options);
    options.put("name", "Spoor 2");
    board.AddElement(Constants.element.Track, 16, options);
    options.put("lengthInSwitchTracks", 2);
    options.put("alignName", LEFT);
    options.put("name", "Spoor 12");
    board.AddElement(Constants.element.Track, 20, options);
    options.put("name", "Spoor 11");
    board.AddElement(Constants.element.Track, 21, options);
    options.put("alignName", RIGHT);
    options.put("name", "Spoor 6");
    board.AddElement(Constants.element.Track, 13, options);
    options.put("name", "Spoor 1");
    board.AddElement(Constants.element.Track, 17, options);
    options.put("lengthInSwitchTracks", 1);
    options.put("name", "Spoor 7");
    board.AddElement(Constants.element.Track, 14, options);
    options.put("name", "");    
    board.AddElement(Constants.element.Track, 23, options);

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
    board.ConnectTerminals(4, Constants.terminal.B, 23, Constants.terminal.B);
    board.ConnectTerminals(23, Constants.terminal.A, 10, Constants.terminal.A);
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

    return board;
  }
}
