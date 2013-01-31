/*
* Large Planet Design
*
*/

public class LargePlanet extends Planet
{  
  LargePlanet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*5;
    resources*=resources*5;
  }
}
