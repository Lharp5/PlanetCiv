/*
* Default class for planets
* extends units
*/

public class Planet extends Unit
{  
  int resources;
  int size;
  public Planet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a);
    resources=r;
    size=s;
  }
  
  public void drawThis()
  {
    if(alive)
    {
      ellipse(xpos,ypos,size,size);   
    }
  }
  
  public void clickedOn(){
    if(dist(mouseX,mouseY,xpos,ypos)<size/2){
      System.out.println("this planet");
    }
  }
}
