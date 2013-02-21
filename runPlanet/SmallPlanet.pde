/*
* Small Planet Class
*/

public class SmallPlanet extends Planet
{  
  SmallPlanet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*2;
    resources*=resources*2;
  }
  
  public void update(){
    fill(0,0,255);
    noStroke();
    super.update();
  }
}
