/*
* Medium Class
*/

public class MedPlanet extends Planet
{  
  PImage [] planetImg = new PImage[6];
  MedPlanet(float xp, float yp, boolean a, int r, int s)
  {
    super(xp,yp,a,r,s);
    size=size*3;
    resources*=resources*3;
    
    for(int i=0; i<planetImg.length; i++){
      planetImg[i] = loadImage("MedPlanet"+i+".png");
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
