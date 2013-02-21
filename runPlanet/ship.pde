/*
* ship class
*/

public class Ship extends Unit
{
  protected int size;
  protected int movX,movY;
  
 public Ship(int xp, int yp, boolean a, int s)
  {
    super(xp,yp,a);
    size = s;
    movX = (int)xpos;
    movY = (int)ypos;
  }
  
  public void update()
  {
    
    if(movX!=xpos||movY!=ypos){
      move(movX,movY);
      }
      
    if(selected)      
      fill(255);
    else      
      fill(150);
    noStroke();
    ellipse(xpos,ypos,size,size);
    fill(255,0,0);
    stroke(0, 255);
    ellipse(xpos,ypos,size/5,size/5);
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
