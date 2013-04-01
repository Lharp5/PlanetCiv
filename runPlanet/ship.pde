/*
* ship class
*/

public class Ship extends Unit
{
  protected int movX,movY;
  protected boolean endDestination;
  protected int distance;
  PImage sprite = loadImage("Settler.png");
  PImage selSprite = loadImage("SettlerSelected.png");
  public int getDist() { return distance; }
  
 public void dock(){endDestination = true; alive = false;}
 
 public Ship(float xp, float yp, boolean a, int s)
  {
    super(xp,yp,a,s);
    size = s;
    movX = (int)xpos;
    movY = (int)ypos;
    endDestination=false;
  }
  
  public void update()
  {
    imageMode(CENTER);
    
    if(movX!=xpos||movY!=ypos){
      move(movX,movY);
      }
    else if(endDestination &&(movX==xpos&&movY==ypos))
      die();
      
    if(alive){
      if(selected)      
        image(selSprite, xpos, ypos);
      else      
        image(sprite, xpos, ypos);
    }
    imageMode(CORNER);
  }
  
  public void change(int updateX, int updateY){
    movX += updateX;
    movY += updateY;
    super.change(updateX,updateY);
  }
  
  public void selectThis(boolean sBox, boolean cap){
    if (!sBox) {
      if(dist(mouseX,mouseY,xpos,ypos)<size/2)    {
        selected = true;
        movX = (int)xpos;
        movY = (int)ypos;
      }
      else
        selected=false;
    }
    else {
      if (cap) {
        selected = true;
        movY = (int)xpos;
        movY = (int)ypos;
      } else {
        selected = false;
      }
    }
  }
  
  public void move(int mx, int my){     
      movX=mx;
      movY=my;
      float difX = movX - xpos;
      float difY = movY - ypos;
      distance = (int)sqrt((difX * difX) + (difY * difY));
      float xSpeed = difX / sqrt((difX * difX) + (difY * difY));
      float ySpeed = difY / sqrt((difX * difX) + (difY * difY));
      
      xpos += xSpeed;
      ypos += ySpeed;
      
      if (difX <= 1 && difX >= -1) {
        xpos = movX;
      }
      if (difY <= 1 && difY >= -1) {
        ypos = movY;
      }
  }
}
