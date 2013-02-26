/*
* Small Planet Class
*/

public class SmallPlanet extends Planet
{  
  SmallPlanet(float xp, float yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*2;
    resources*=resources*2;
  }
  
  public void update(){
    fill(0,0,255);
    noStroke();
    super.update();
    if(populated == true){
      fill(50);
      ellipse(xpos, ypos, 30,30);
    }
  }
}
