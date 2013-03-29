//Jacob
public class Fog extends Unit {
  
  Fog(float xp, float yp){
    super(xp,yp,true,250);    
   }   
    
  public void update(){
    rectMode(CENTER);
    strokeWeight(0);
    fill(5,1,7);
    if(alive == true)
      rect(xpos,ypos,size,size);
  }
    
  }
