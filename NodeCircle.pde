public class NodeCircle {
  //constructor
  public NodeCircle() {
  }

  public void display(Integer x, Integer y, Integer colour, Character letter) {
    fill(colour);
    circle(x, y, Constants.circleDiameter);
    fill(#000000);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(letter, x, y);
  }
}
