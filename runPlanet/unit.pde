/* default unit class
*
*/

public class Unit
{
  int xpos, ypos;
  boolean alive;
  public Unit(int xp, int yp, boolean a)
  {
    xpos =xp;
    ypos =yp;
    alive = a;
  }
  
  public void update(int updateX, int updateY)
  {
    xpos+=updateX;
    ypos+=updateY;
  }
}
