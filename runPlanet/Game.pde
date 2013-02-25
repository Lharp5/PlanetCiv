//by Jacob Dyck

public class Game{
  public int time;
  
  public Unit p[] = new Unit [10000];
  int numUnits;
  private boolean clicked = false;
  private int boundingX1 = 0;
  private int boundingX2 = 0;
  private int boundingY1 = 0;
  private int boundingY2 = 0;
  private boolean selectionBox = false;

  HeadsUpDisplay hud = new HeadsUpDisplay();
  
  private int resources; //total resources the player has
  final int SETTLER_COST = 1000;
  
  
  public Game(){
    time=0;
    background(0);  
    p[0] = new MedPlanet(0, 0, true, 10, (int)random(40, 60));  
    p[1] = new LargePlanet(-width/2, -height/2, true, 10, (int)random(50, 76));  
    p[2] = new SmallPlanet(width/2, height/2, true, 10, (int)random(30, 50));  
    p[3] = new Ship(width, height, true, 25);  
    numUnits=4;
  }
  
  public void gameUpdate() {  
      background(0);    
        
      /*  fill(255, 255); 
      textSize(20);  
      text("x: " + p[3].getX(), 20, 20);  
      text("y: " + p[3].getY(), 20, 40);  
      text("bx1: " + boundingX1, 20, 60);  
      text("by1: " + boundingY1, 20, 80);  
      text("bx2: " + boundingX2, 20, 100);  
      text("by2: " + boundingY2, 20, 120);  
      */
                            
    for (int i=0; i<numUnits; i++) {   
    p[i].update();
    }  
    if (clicked) {    
        fill(255, 0);    
        stroke(255, 255);    
        rect(boundingX1, boundingY1, boundingX2 - boundingX1, boundingY2 - boundingY1);    
        int difX = boundingX2 - boundingX1;    
        int difY = boundingY2 - boundingY1;    
        if ((difX > 5 || difX < -5) || (difY > 5 || difY < -5)) {      
            selectionBox = true;
          } 
          else {      
                selectionBox = false;
          }
                                }  
          for (int i = 0; i < numUnits; i++) {    
                if (p[i] instanceof Planet) {      
                              if (p[i].menuDisplay) {        
                                        ((Planet)p[i]).displayMenu();
                    }
                }
          }
          
          
      // this should always go last.
      hud.update(time, resources);
  
      mouseTracker();  
      time++;
  }
  public void mouseTracker() {  
      int speed =3;  
      int mr=100;   
      int xval=0;  
      int yval=0;    
              if (clicked) {    
                    boundingX2 = mouseX;    
                        boundingY2 = mouseY;
              }    
              if (mouseX<mr&&mouseY<mr) {    
                    xval=speed;    
                    yval=speed;
              }  
              else if (mouseX<mr&&mouseY>height-mr) {    
                    xval=1;    
                    yval=-speed;
              }  
              else if (mouseX>width-mr&&mouseY<mr) {    
                    xval=-speed;    
                    yval=speed;
              }  
              else if (mouseX>width-mr&&mouseY>height-mr) {    
                    xval=-speed;    
                    yval=-speed;
              }    
              else if (mouseX<50&&(mouseY>50&&mouseY<height-50)) {    
                    xval=speed;    
                    yval=0;
              }  
              else if (mouseX>width-50&&(mouseY>50&&mouseY<height-50)) {    
                    xval=-speed;    
                    yval=0;
              }  
              else if ((mouseX>50&&mouseX<width-50)&&mouseY<50) {    
                    xval=0;    
                    yval=speed;
              }  
              else if ((mouseX>50&&mouseX<width-50)&&mouseY>height-50) {    
                    xval=0;    
                    yval=-speed;
              }    
           for (int i=0; i<numUnits; i++) {    
                p[i].change(xval, yval);
        }
  }
  
  public Boolean checkDestination(int mx, int my) {    
      for (int i=0; i<numUnits; i++) {    
            if (p[i] instanceof Planet) {     
                    if (dist(mx, my, p[i].getX(), p[i].getY())<p[i].getSize()/2) {              
                              ((Planet) p[i]).populate();       
                                      return true;
                    }
            }
      }  
        return false;
  }
}
  
  
