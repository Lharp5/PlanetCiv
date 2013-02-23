//by Jacob Dyck

public class Game{
  int time;
  
  Unit p[] = new Unit [10000];
  int numUnits;
  private boolean clicked = false;
  private int boundingX1 = 0;
  private int boundingX2 = 0;
  private int boundingY1 = 0;
  private int boundingY2 = 0;
  private boolean selectionBox = false
  
  
  public Game(){
    time=0;  
    size(1000, 650);  
    background(0);  
    p[0] = new MedPlanet(0, 0, true, 10, (int)random(40, 60));  
    p[1] = new LargePlanet(-width/2, -height/2, true, 10, (int)random(50, 76));  
    p[2] = new SmallPlanet(width/2, height/2, true, 10, (int)random(30, 50));  
    p[3] = new Ship(width, height, true, 25);  
    numUnits=4;
  }
}
