/*
* Default class for planets
* extends units
*/

public class Planet extends Unit
{
  protected final String [] CITY_LIST = {"Settlement","Space Port","Lunar City","Galactic Hub","Universal Command Center"};
  protected final String [] DEFENSE_LIST = {"none","Quake Resister"," Asteroid Inteceptor","Quake Stabalizer","Atmospheric Shield"};
  protected final String [] RESEARCH_LIST = {"none","Greenhouse","Laser Tools","Renewable Energy","Chemical Restructuring"};
  
  protected int city, defenses, research;
  protected int resources;
  
  protected boolean populated;
  
  public Planet(int xp, int yp, boolean a, int r, int s)
  {
    super(xp,yp,a,s);
    resources=r;
    
    populated=false;
    city=0;
    defenses=0;
    research=0;
  }
  
  public void update()
  {
    if(alive)
    {
      ellipse(xpos,ypos,size,size);
    }
    if(menuDisplay){
      displayMenu();
    }
  }
  
  
  public void populate(){
    if(!populated)
      populated=true;
}
  
  public void clickedOn(){
    if(dist(mouseX,mouseY,xpos,ypos)<size/2){
      displayMenu();
    }
  }
  public void displayMenu(){
    if(populated){
      menuDisplay=true;
      fill(255);
      rect(100,100, width-200,height-200);
    }
  }
}
