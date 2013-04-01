/*
* Small Planet Class
*/

public class SmallPlanet extends Planet
{
  PImage [] planetImg = new PImage[6];
  SmallPlanet(float xp, float yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*2;
    resources*=resources*2;
    
    for(int i=0; i<planetImg.length; i++){
      planetImg[i] = loadImage("SmallPlanet"+i+".png");
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
