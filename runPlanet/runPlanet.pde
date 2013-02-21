/*
* Main Run Program for Civ Space game
* Luke Harper v0.0.1
*/

int time;
Unit p[] = new Unit [10000];
int numUnits;

private boolean clicked = false;
private int boundingX1 = 0;
private int boundingX2 = 0;
private int boundingY1 = 0;
private int boundingY2 = 0;

void setup()
{
  time=0;
  size(1000,650);
  background(0);
  p[0] = new MedPlanet(0, 0, true, 10, (int)random(40,60));
  p[1] = new LargePlanet(-width/2, -height/2, true, 10, (int)random(50,76));
  p[2] = new SmallPlanet(width/2, height/2, true, 10, (int)random(30,50));
  p[3] = new Ship(width, height, true,25);
  numUnits=4;
}

void draw()
{
  background(0);
  
  for(int i=0; i<numUnits; i++)
  {
   p[i].update();
  }
  if (clicked) {
    fill(255, 0);
    stroke(255, 255);
    rect(boundingX1, boundingY1, boundingX2 - boundingX1, boundingY2 - boundingY1);
  }
  mouseTracker();
  time++;
}

public void mouseTracker()
{
  int speed =3;
  int mr=100; //mouseRange
  int xval=0;
  int yval=0;
  
  if (clicked) {
    boundingX2 = mouseX;
    boundingY2 = mouseY;
  }
  
  if(mouseX<mr&&mouseY<mr)  {
    xval=speed;
    yval=speed;
  }
  else if(mouseX<mr&&mouseY>height-mr)  {
    xval=1;
    yval=-speed;
  }
  else if(mouseX>width-mr&&mouseY<mr)  {
    xval=-speed;
    yval=speed;
  }
  else if(mouseX>width-mr&&mouseY>height-mr)  {
    xval=-speed;
    yval=-speed;
  }  
  else if(mouseX<50&&(mouseY>50&&mouseY<height-50))  {
    xval=speed;
    yval=0;
  }
  else if(mouseX>width-50&&(mouseY>50&&mouseY<height-50))  {
    xval=-speed;
    yval=0;
  }
  else if((mouseX>50&&mouseX<width-50)&&mouseY<50)  {
    xval=0;
    yval=speed;
  }
  else if((mouseX>50&&mouseX<width-50)&&mouseY>height-50)  {
    xval=0;
    yval=-speed;
  }
  
  for(int i=0; i<numUnits; i++)  {
    p[i].change(xval,yval);
  }  
}

void mousePressed()
{
  if(mouseButton == LEFT){
    if (!clicked) {
      boundingX1 = mouseX;
      boundingY1 = mouseY;
      boundingX2 = mouseX;
      boundingY2 = mouseY;
    }
    for(int i=0; i<numUnits; i++){
     if(p[i] instanceof Ship){
      ((Ship) p[i]).selectThis();
     } 
    }
    clicked = true;
  }
  else if(mouseButton == RIGHT){
    for(int i=0; i<numUnits; i++){
      if(p[i] instanceof Planet){
        ((Planet) p[i]).clickedOn();
      }
      else if(p[i] instanceof Ship){
        if(p[i].selected){
          ((Ship) p[i]).move(mouseX,mouseY);
        }
      }
    }
  }
}

void mouseReleased()
{
  if(mouseButton == LEFT) {
    boundingX1 = 0;
    boundingX2 = 0;
    boundingY1 = 0;
    boundingY2 = 0;
    clicked = false;
  }
}
