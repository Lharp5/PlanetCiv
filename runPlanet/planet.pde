/*
* Default class for planets
* extends units
*/

protected static int PLANET_NUMBER = 1;

public class Planet extends Unit
{
  protected final String [] CITY_LIST = {"Settlement","Space Port","Lunar City","Galactic Hub","Universal Command Center"};
  protected final String [] DEFENSE_LIST = {"none","Quake Resister"," Asteroid Inteceptor","Quake Stabalizer","Atmospheric Shield"};
  protected final String [] RESEARCH_LIST = {"none","Greenhouse","Laser Tools","Renewable Energy","Chemical Restructuring"};
  
  protected int city, defenses, research;
  protected int resources;
  protected int decay;
  protected int population; //need a menu display for this
  
  protected boolean populated;
  
  protected int planetNum;
  
  public Planet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a,s);
    resources=r;
    
    populated=false;
    city=0;
    defenses=0;
    research=0;
    decay=0;
    population=0;
  }
  
  public void update()
  {
    if(alive)
    {
      ellipse(xpos,ypos,size,size);
    }
  }
  
  
  public void populate(){
    if(!populated) {
      populated=true;
      planetNum = PLANET_NUMBER;
      PLANET_NUMBER ++;
    }
}
  
  public void clickedOn(){
    if(dist(mouseX,mouseY,xpos,ypos)<size/2){
      displayMenu();
    }
  }
  public void displayMenu(){
    if(populated){
      menuDisplay=true;
      noStroke();
      fill(255);
      rect(100,50, width-200,height-150);
      fill(180);
      rect(120, 120, (width / 2) - 130, (height / 2) - 130);
      rect(width / 2 + 10, 120, (width / 2) - 130, (height / 2) - 130);
      rect(120, height / 2 + 10, (width / 2) - 130, (height / 2) - 130);
      rect(width / 2 + 10, height / 2 + 10, (width / 2) - 130, (height / 2) - 130);
      fill(120);
      rect(width / 2 - 100, 60, 200, 50);
      fill(0);
      textSize(30);
      text("Planet " + planetNum, width / 2 - 85, 95);
      text("Civilization Progress",  135, 155);
      text("Upgrade", (width / 2) + 25, 155);
      text("Planet Info",  135, (height / 2) + 45);
      text("Dispatch", (width / 2) + 25, (height / 2) + 45);
      textSize(26);
      
      //buttons
      stroke(0);
      fill(230);
      rect((width / 2) + 280, 175, 75, 30);
      rect((width / 2) + 280, 210, 75, 30);
      rect((width / 2) + 280, 245, 75, 30);
      rect((width / 2) + 280, (height / 2) + 65, 75, 30);
      rect((width / 2) + 280, (height / 2) + 100, 75, 30);
      
      fill(0);
      //civilization info
      text("City: " + CITY_LIST[city], 130, 200);
      text("Defenses: " + DEFENSE_LIST[defenses], 130, 235);
      text("Research: " + RESEARCH_LIST[research], 130, 270);
      
      //upgrades
      text("City..........................", (width / 2) + 20, 200);
      text("Defenses..................", (width / 2) + 20, 235);
      text("Research..................", (width / 2) + 20, 270);
      
      //planet info
      text("Planet Decay: "+decay+"%", 130, (height / 2) + 90);
      text("Resource Rate: "+resources, 130, (height / 2) + 125);
      
      //recruit ships
      text("Ship 1......................", (width / 2) + 20, (height / 2) + 90);
      text("Ship 2......................", (width / 2) + 20, (height / 2) + 125);
      
      //prices
      text("Price", (width / 2) + 285, 200);
      text("Price", (width / 2) + 285, 235);
      text("Price", (width / 2) + 285, 270);
      text("Price", (width / 2) + 285, (height / 2) + 90);
      text("Price", (width / 2) + 285, (height / 2) + 125);
    }
  }
}
