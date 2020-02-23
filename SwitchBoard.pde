import java.util.TreeMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

Map<Integer, Board> _boards = new HashMap<Integer, Board>();
Board _board;

int _lastMillis = millis();

void setup() {
  size(1000, 400);
  frameRate(60);

  Configuration.loadBoards(_boards, this);
  _board = _boards.get(0);
}

void draw() {
  background(204);

  fill(#000000);
  textAlign(LEFT, TOP);
  textSize(10);
  text("fps: " + round(frameRate), 5, 5);

  drawBoardSelectionTexts();

  _board.Display();
}

void drawBoardSelectionTexts() {
  fill(#000000);
  textAlign(LEFT, TOP);
  textSize(10);

  Integer x = 850;
  Integer y = 5;

  text("Geladen boards:", x, y);
  y += 15;

  for(Map.Entry<Integer, Board> entry : _boards.entrySet()) {
    Integer index = entry.getKey();
    Board board = entry.getValue();

    y += 15;

    text((index + 1) + ". " + board.Name(), x, y);
  }

  y += 30;
  text("Commando's:", x, y);

  y += 30;
  text("s: Huidige board opslaan.", x, y);
}

void saveBoard(Board board) {
  if (_board.Name() == "") {
    println("ERROR: Cannot save board without name!");
    return;
  }

  String boardPath = "boards/" + _board.Name() + ".json";
  println("Saving board to: " + boardPath);

  BoardSerializer boardSerializer = new BoardSerializer(_board);
  saveJSONObject(boardSerializer.toJSONObject(), boardPath);
}

void keyTyped() {
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

void mouseMoved() {
  _board.MouseOverCheck(mouseX, mouseY);
}

void mouseDragged() {
  // _board.MouseOverCheck(mouseX, mouseY);
}

void mousePressed() {
  _board.MousePressed(mouseX, mouseY);
}

void mouseReleased() {
  _board.MouseReleased(mouseX, mouseY);
}

void mouseClicked() {
  _board.MouseClicked(mouseX, mouseY, mouseButton);
}
