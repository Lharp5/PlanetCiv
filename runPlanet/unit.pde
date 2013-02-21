/* default unit class
*
*/

public abstract class Unit
{
  
  protected float xpos, ypos;
  protected int size;
  protected boolean alive, selected;
  public boolean menuDisplay;
  
  public int getSize;
  public float getX() { return xpos; }
  public float getY() { return ypos; }
  public int getSize() { return size; }
  
  public Unit(int xp, int yp, boolean a, int s)  
{
    xpos =xp;
    ypos =yp;
    alive = a;
    selected=false;
    menuDisplay=false;
    size=s;
  }
  
  public void change(int updateX, int updateY)
  {
    xpos+=updateX;
    ypos+=updateY;
  }  
  
  
  public void die()
  {
    alive=false;    
  }
  
  public abstract void update();
}
