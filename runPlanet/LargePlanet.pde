/*
* Large Planet Design
*
*/

public class LargePlanet extends Planet
{  
  LargePlanet(float xp, float yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*5;
    resources*=resources*5;
  }
  
  public void update(){
    fill(255,0,0);
    noStroke();
    super.update();
  }
}
