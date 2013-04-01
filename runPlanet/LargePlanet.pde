/*
* Large Planet Design
*
*/

public class LargePlanet extends Planet
{  
  PImage [] planetImg = new PImage[6];
  LargePlanet(float xp, float yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*5;
    resources*=resources*5;
    
    for(int i=0; i<planetImg.length; i++){
      planetImg[i] = loadImage("LargePlanet"+i+".png");
    }
  }
  
  public void update(){
  if(alive){
      imageMode(CENTER);
      image(planetImg[city], xpos, ypos);
      imageMode(CORNER);
    }
  }
}
