public class NodeCircle {
  private Integer _circleDiameter = 20;

  //constructor
  public NodeCircle() {
  }

  public void display(Integer x, Integer y, Integer colour, Character letter) {
    fill(colour);
    circle(x, y, _circleDiameter);
    fill(#000000);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(letter, x, y);
  }
}
