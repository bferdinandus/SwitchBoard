public class TerminalCircle 
{
  //constructor
  public TerminalCircle() {
  }

  public void display(Integer x, Integer y, Integer colour, Character letter) {
    strokeWeight(1);
    fill(colour);
    circle(x, y, Constants.circleDiameter);
    y-=2;

    TextUtils text = new TextUtils().Align(CENTER, CENTER).Size(15).Colour(#000000).OutlineColour(#FFFFFF);
    text.Text(letter.toString(), x, y);
  }
}
