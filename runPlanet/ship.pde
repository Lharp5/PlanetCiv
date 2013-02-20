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
    size =s;
    movX=xpos;
    movY=ypos;
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
    ellipse(xpos,ypos,size,size);
    fill(255,0,0);
    ellipse(xpos,ypos,size/5,size/5);
  }
  
  public void change(int updateX, int updateY){
    movX+=updateX;
    movY+=updateY;
    super.change(updateX,updateY);
  }
  
  public void selectThis(){
    if(dist(mouseX,mouseY,xpos,ypos)<size/2)    {
      selected=true;
      movX=xpos;
      movY=ypos;
    }
    else
      selected=false;
  }
  
  public void move(int mx, int my){     
        movX=mx;
        movY=my;
        
      if(movX>xpos)
        xpos++;
      if(movY>ypos)
        ypos++;
      if(movX<xpos)
        xpos--;
      if(movY<ypos)
        ypos--;
  }
}
  
