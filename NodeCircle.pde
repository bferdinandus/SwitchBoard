public class NodeCircle {
  //constructor
  public NodeCircle() {
  }

  public void display(Integer x, Integer y, Integer colour, Character letter) {
    strokeWeight(1);
    fill(colour);
    circle(x, y, Constants.circleDiameter);
    y-=2;
    textSize(15);
    textAlign(CENTER, CENTER);
    fill(#ffffff);
    text(letter, x+1, y);
    text(letter, x, y+1);
    text(letter, x-1, y);
    text(letter, x, y-1);
    fill(#000000);
    text(letter, x, y);
  }
}
