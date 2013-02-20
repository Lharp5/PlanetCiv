/* default unit class
*
*/

public abstract class Unit
{
  int xpos, ypos;
  boolean alive;
  public Unit(int xp, int yp, boolean a)
  {
    xpos =xp;
    ypos =yp;
    alive = a;
  }
  
  public void change(int updateX, int updateY)
  {
    xpos+=updateX;
    ypos+=updateY;
  }
  public abstract void update();
}
