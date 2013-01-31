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
  
  public void drawPlanet()
  {
    if(alive)
    {
      fill(255,0,0);
      ellipse(xpos,ypos,size,size);   
    }    }}
