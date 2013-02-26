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
      if(mouseButton == LEFT){
        if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>175&&mouseY<205)) //buildCity button
          g.resources=((Planet)g.p[i]).buildCity(g.resources);
        else if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>210&&mouseY<240)) //buildDefenses button
          g.resources=((Planet)g.p[i]).buildDefense(g.resources);
        else if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>245&&mouseY<275)) //buildResearch button
          g.resources=((Planet)g.p[i]).buildResearch(g.resources);
          
        else if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>(height / 2) + 65&&mouseY<(height / 2) + 95)) //SettleShip button
          g.recruitSettler(g.p[i].getX() + g.p[i].getSize()+30,g.p[i].getY());
        /*else if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>(height / 2) + 100 &&mouseY<(height / 2) + 130)) //ExploreShip button
          g.resources=buildCity(g.resources);*/
      }
          
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
