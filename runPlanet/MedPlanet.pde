/*
* Medium Class
*/

public class MedPlanet extends Planet
{  
  MedPlanet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*3;
    resources*=resources*3;
  }
  
  public void update(){
    fill(0,255,0);
    super.update();
  }
}
