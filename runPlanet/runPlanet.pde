/*
* Main Run Program for Civ Space game
* Luke Harper v0.0.1
* This class is for the driver, it mostly handles the mouse interaction, and just loops the game.
*/

/*
int time;
Unit p[] = new Unit [10000];
int numUnits;
*/

private int boundingX1 = 0;
private int boundingX2 = 0;
private int boundingY1 = 0;
private int boundingY2 = 0;
private boolean selectionBox = false;
private boolean clicked = false;

Game g;

void setup()
{
  size(1000,650);
  
  
g = new Game();
}

void draw()
{
  g.gameUpdate();
}


void mousePressed()
{
  for(int i=0; i<g.numUnits; i++)  {
    if(g.p[i].menuDisplay){
      if(mouseButton == LEFT)
        println("This is for interacting with menu");
      else if(mouseButton == RIGHT) //right click closes the menu
        g.p[i].menuDisplay=false;
    }
      else{
        if(mouseButton == LEFT){
          if (!clicked) {
            boundingX1 = mouseX;
            boundingY1 = mouseY;
            boundingX2 = mouseX;
            boundingY2 = mouseY;
          }
           if(g.p[i] instanceof Ship){
            ((Ship) g.p[i]).selectThis(selectionBox, false);
           } 
           
          clicked = true;
        }
        else if(mouseButton == RIGHT){            
            if(g.p[i] instanceof Ship){
              if(g.p[i].selected){
                if(g.checkDestination(mouseX,mouseY))
                  ((Ship) g.p[i]).dock();
                ((Ship) g.p[i]).move(mouseX,mouseY);
              }
            }
            else if(g.p[i] instanceof Planet){
              ((Planet) g.p[i]).clickedOn();
            }
        }
    }
}
}
void mouseReleased()
{
  float objX;
  float objY;
  if(mouseButton == LEFT) {
    for (int i = 0; i < g.numUnits; i++) {
      objX = g.p[i].getX();
      objY = g.p[i].getY();
      if (boundingX1 < objX && boundingX2 > objX && boundingY1 < objY && boundingY2 > objY) {
        if (g.p[i] instanceof Ship) {
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        }
      }
      else if (boundingX1 > objX && boundingX2 < objX && boundingY1 < objY && boundingY2 > objY) {
        if (g.p[i] instanceof Ship) {
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        }
      }
      else if (boundingX1 < objX && boundingX2 > objX && boundingY1 > objY && boundingY2 < objY) {
        if (g.p[i] instanceof Ship) {
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        }
      }
      else if (boundingX1 > objX && boundingX2 < objX && boundingY1 > objY && boundingY2 < objY) {
        if (g.p[i] instanceof Ship) {
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        }
      }
    }
    boundingX1 = 0;
    boundingX2 = 0;
    boundingY1 = 0;
    boundingY2 = 0;
    clicked = false;
  }
}
