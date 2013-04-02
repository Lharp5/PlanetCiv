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

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

private boolean startGame;

private int boundingX1 = 0;
private int boundingX2 = 0;
private int boundingY1 = 0;
private int boundingY2 = 0;
private boolean selectionBox = false;
private boolean clicked = false;

Game g;
TitleScreen t;

void setup()
{
  size(1000,650);
  startGame=false;
  
  g = new Game();
  t = new TitleScreen();
  t.minim= new Minim(this);
  t.vo=t.minim.loadFile("VoiceOver.wav");
  t.ambiance=t.minim.loadFile("161615__keinzweiter__deep-space.aiff");  
  t.input = t.minim.getLineIn();
}

void draw()
{
  if(!startGame)
    t.titleUpdate();
  else
    g.gameUpdate();
}

  void stop()
  {
    t.vo.close();
    t.ambiance.close();
    t.input.close();
    t.minim.stop();
    super.stop();
  }
void mousePressed()
{
  for(int i=0; i<g.numUnits; i++) {
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
        else if((mouseX>(width / 2) + 280 &&mouseX<(width / 2) + 355)&&(mouseY>(height / 2) + 100 &&mouseY<(height / 2) + 130)) //ExploreShip button
         g.recruitExplore(g.p[i].getX() + g.p[i].getSize()+30,g.p[i].getY());
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
           else if(g.p[i] instanceof ExploreShip){
            ((ExploreShip) g.p[i]).selectThis(selectionBox, false);
           }
           
          clicked = true;
        }
        else if(mouseButton == RIGHT){            
            if(g.p[i] instanceof Ship){
              if(g.p[i].selected){
                  ((Ship) g.p[i]).move(mouseX,mouseY);
              }
            }
            //duplicating Ship for ExploreShip
            else if(g.p[i] instanceof ExploreShip){
              if(g.p[i].selected){
                  ((ExploreShip) g.p[i]).move(mouseX,mouseY);
                  g.removeFog((int)g.p[i].getX(),(int)g.p[i].getY());
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
    
    //updated adding the second ship.
    
    for (int i = 0; i < g.numUnits; i++) {
      objX = g.p[i].getX();
      objY = g.p[i].getY();
      if (boundingX1 < objX && boundingX2 > objX && boundingY1 < objY && boundingY2 > objY) {
        if (g.p[i] instanceof Ship)
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        if(g.p[i] instanceof ExploreShip)
          ((ExploreShip)g.p[i]).selectThis(selectionBox, true);
      }
      else if (boundingX1 > objX && boundingX2 < objX && boundingY1 < objY && boundingY2 > objY) {
        if (g.p[i] instanceof Ship) 
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        if(g.p[i] instanceof ExploreShip)
          ((ExploreShip)g.p[i]).selectThis(selectionBox, true);
      }
      else if (boundingX1 < objX && boundingX2 > objX && boundingY1 > objY && boundingY2 < objY) {
        if (g.p[i] instanceof Ship)
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        if(g.p[i] instanceof ExploreShip)
          ((ExploreShip)g.p[i]).selectThis(selectionBox, true);
      }
      else if (boundingX1 > objX && boundingX2 < objX && boundingY1 > objY && boundingY2 < objY) {
        if (g.p[i] instanceof Ship)
          ((Ship)g.p[i]).selectThis(selectionBox, true);
        if(g.p[i] instanceof ExploreShip)
          ((ExploreShip)g.p[i]).selectThis(selectionBox, true);
      }
    }
    boundingX1 = 0;
    boundingX2 = 0;
    boundingY1 = 0;
    boundingY2 = 0;
    clicked = false;
  }
}

void keyPressed(){
  if(key == ' ')
    startGame = true;
}
