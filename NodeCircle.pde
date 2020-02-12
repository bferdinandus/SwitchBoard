public class NodeCircle {
  private int _circleDiameter = 20;

  //constructor
  public NodeCircle() {
  }

  public void display(int x, int y, int colour, char letter) {
    fill(colour);
    circle(x, y, _circleDiameter);
    fill(#000000);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(letter, x, y);
  }
}
