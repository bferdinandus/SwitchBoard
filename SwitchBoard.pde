import java.util.TreeMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Map<Integer, Board> _boards = new HashMap<Integer, Board>();
Board _board;

int _lastMillis = millis();

public void setup() {
  size(1200, 700);
  frameRate(60);

  Configuration.loadBoards(_boards, this);
  _board = _boards.get(3);
}

public void draw() {
  background(204);

  TextUtils text = new TextUtils().Align(LEFT, TOP);
  text.Text("fps: " + round(frameRate), 5, 5);

  drawBoardSelectionTexts();

  _board.Display();
}

private void drawBoardSelectionTexts() {
  TextUtils text = new TextUtils().Align(LEFT, TOP);

  Integer x = 850;
  Integer y = 5;

  text.Text("Geladen boards:", x, y);
  y += 15;

  for (Map.Entry<Integer, Board> entry : _boards.entrySet()) {
    Integer index = entry.getKey();
    Board board = entry.getValue();

    y += 15;

    text.Text((index + 1) + ". " + board.Name(), x, y);
  }

  y += 30;
  text.Text("Commando's:", x, y);

  y += 30;
  text.Text("s: Huidige board opslaan.", x, y);
}

private void saveBoard(Board board) {
  if (_board.Name() == "") {
    println("ERROR: Cannot save board without name!");
    return;
  }

  String boardPath = "boards/" + board.Name() + ".json";
  println("Saving board to: " + boardPath);

  BoardSerializer boardSerializer = new BoardSerializer(board);
  saveJSONObject(boardSerializer.toJSONObject(), boardPath);
}

public void keyTyped() {
  Integer boardCount = _boards.size();
  Integer result = int(key);

  if (result == 115) {
    println("Saving board: " + _board.Name());

    saveBoard(_board);
    return;
  } else if (result < 49 || result > 49 + boardCount - 1) {
    println("User error: invalid key pressed for number of loaded boards!");
    return;
  }

  Integer selectedIndex = result - 49;

  _board = _boards.get(selectedIndex);
}

public void mouseMoved() {
  _board.MouseOverCheck(mouseX, mouseY);
}

public void mouseDragged() {
  // _board.MouseOverCheck(mouseX, mouseY);
}

public void mousePressed() {
  _board.MousePressed(mouseX, mouseY);
}

public void mouseReleased() {
  _board.MouseReleased(mouseX, mouseY);
}

public void mouseClicked() {
  _board.MouseClicked(mouseX, mouseY, mouseButton);
}
