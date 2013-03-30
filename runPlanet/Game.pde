/*
* Game client is used for assembling the game and running all the functions for the player and overall game view.
*/
//by Jacob Dyck

public class Game{
  public int time;
  private int disaster; //RNG for disaster
  private int planetsComplete;
  
  public Unit p[] = new Unit [10000];
  int numUnits;
  private float barrierX, barrierY;
  /*
  private boolean clicked = false;
  private int boundingX1 = 0;
  private int boundingX2 = 0;
  private int boundingY1 = 0;
  private int boundingY2 = 0;
  private boolean selectionBox = false;*/

  HeadsUpDisplay hud = new HeadsUpDisplay();
  
  public int resources; //total resources the player has, public so mouse can interact thoughts?
  
  final int SETTLER_COST = 2000; //cost of a settler ship STC.
  final int EXPLORE_COST = 1000; //cost of explorer ship STC.
  final int SMIN =30;
  final int SMAX = 45;
  final int MMIN = 46;
  final int MMAX = 50;
  final int LMIN = 51;
  final int LMAX = 76;
  final int SHIP_SIZE=25;
  
  
  public Game(){
    planetsComplete=0;
    time=0;
    background(0);  
      
    //large planets
    p[0] = new LargePlanet(0, -height*2, true, 10, (int)random(LMIN, LMAX));
    p[1] = new LargePlanet(width*2,height*2,true,10,(int)random(LMIN,LMAX));
  
    //medium planets
    p[2] = new MedPlanet(-width, 0, true, 10, (int)random(MMIN, MMAX));
    p[3] = new MedPlanet (width, height*2, true, 10, (int)random(MMIN,MMAX));
    p[4] = new MedPlanet(width,-height*2,true,10,(int)random(MMIN,MMAX));
    p[5] = new MedPlanet(width*2,-height/2,true,10,(int)random(MMIN,MMAX));
    
    //small planets
    p[6] = new SmallPlanet(width/2, height/2, true, 10, (int)random(SMIN, SMAX));  
    p[7] = new SmallPlanet(-100,-400, true, 10, (int)random(SMIN,SMAX));
    p[8] = new SmallPlanet (width*2/3,-height, true, 10, (int)random(SMIN, SMAX));
    p[9] = new SmallPlanet(-width,-height,true,10,(int)random(SMIN,SMAX));
    p[10] = new SmallPlanet(0,height*2,true,10,(int)random(SMIN,SMAX));
    p[11] = new SmallPlanet(-width,height*1.5,true,10,(int)random(SMIN,SMAX));
   
    numUnits=12;
    
    //creating the fog over planets.
    for(int i=0; i<14; i++){
      for(int j=0; j<16; j++){
         p[numUnits] = new Fog(-1000+250*i, -1500+250*j);
         numUnits++;        
      }
    }
    
    //starting ship
    p[numUnits] = new Ship(width/1.5, height/1.5, true, SHIP_SIZE);
    numUnits++;
    p[numUnits] = new ExploreShip (width/1.5+75, height/1.5+75, true, SHIP_SIZE);
    numUnits++;
    
    
    
    
    ///resource recruitment testing
    resources=0;
    barrierX=width/2;
    barrierY=height/2;
  }
  
  public void gameUpdate() {  
    
    
    if(planetsComplete>=3&&resources>=50000)
      winCondition();
      
    else{
      if(time>72000)
        loseCondition();
      
      else {
        background(0);
        //knowing the max range of planets
        noFill();
        stroke(255,0,0);
        strokeWeight(10);
        ellipse(barrierX,barrierY,4000,4000);
        
        strokeWeight(1);
        
        if(time%400==0){ 
          disaster = (int)random(1,9);
          if(disaster == 3)
            quake();
          else if(disaster ==6)
            asteroid();
          else
            hud.eventStatus = "";
        }
               
        //looping to update game visuals                 
        for (int i=0; i<numUnits; i++) {
          p[i].update();
          if(p[i] instanceof Planet){
            ((Planet) p[i]).increaseDecay(time);
            if(((Planet) p[i]).isPopulated()){
              if(time%300==0)
                resources+=((Planet) p[i]).getResources();
            }
          }
        }
        
        miniMap();
        
        //looping to update array of objects, cycling out dead ones and checking for special cases for ships
        for(int i=0; i<numUnits; i++) {
          if(p[i] instanceof Ship){
            if (((Ship)p[i]).getDist() <= 1) {
              if(checkDestination((int)p[i].getX(),(int)p[i].getY()))
                ((Ship) p[i]).dock();
            }
          }
          if(p[i] instanceof ExploreShip){
            if (((ExploreShip)p[i]).getDist() <= 1) {
              removeFog((int)p[i].getX(),(int)p[i].getY());
            }
          }
          if(!p[i].isAlive()){
            p[i]=p[numUnits-1];
            numUnits--;
          }
        }
      
        ///*
        if (clicked) {
            fill(255, 0);
            //strokeWeight(1);
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
                                    
          //looping to show menu on top of goings on in background.
          for (int i = 0; i < numUnits; i++) {    
            if (p[i] instanceof Planet) {
              if((((Planet) p[i]).getCity()>=2)&&!(((Planet)p[i]).counted)){
                planetsComplete++;
                ((Planet) p[i]).counted=true;
              }      
              if (p[i].menuDisplay) {        
                ((Planet)p[i]).displayMenu();
              }
            }
      }
    }
  }    
      // this should always go last.
      hud.update(time, resources);
  
      mouseTracker();  
      time++;
  }
  
  private void asteroid(){ //natural disaster asteriod
    int thisPlanet = (int)random(1,((Planet)p[0]).getAllPopNum());
    for(int i=0; i<numUnits; i++){
       if((p[i] instanceof Planet) &&((Planet) p[i]).getPlanetNum()==thisPlanet){
         resources-=((Planet)p[i]).asteroidDamage();
         hud.eventStatus = "Planet "+((Planet)p[i]).getPlanetNum() + " Has been hit by an Asteroid";
         hud.statusAlpha = 255;
       }
    }
  }
  
  private void quake(){ //natural disaster quake
    int thisPlanet = (int) random(1,((Planet)p[0]).getAllPopNum());
    for(int i=0; i<numUnits; i++){
       if((p[i] instanceof Planet) &&((Planet) p[i]).getPlanetNum()==thisPlanet){
         resources-=((Planet)p[i]).quakeDamage();
         hud.eventStatus = "Planet: "+((Planet)p[i]).getPlanetNum() + " Has been hit by a Quake";
         hud.statusAlpha = 255;
       }       
    }
  }
  
  //this is for movement of the field of view.
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
  barrierX+=xval;
  barrierY+=yval;
  boundingX1+=xval;
  boundingY1+=yval;
  }
  
  public void recruitSettler(float x, float y){
    if(resources>SETTLER_COST){
      resources-=SETTLER_COST;
      p[numUnits] = new Ship(x,y,true, 25);
      numUnits++;
    }
  }
  
  //method for the upcoming explorer ship
  
    public void recruitExplore(float x, float y){
    if(resources>EXPLORE_COST){
      resources-=EXPLORE_COST;
      p[numUnits] = new ExploreShip(x,y,true, 25);
      numUnits++;
    }
  }

  
  //this is used to populate planets.
  public Boolean checkDestination(int mx, int my) {    
    for (int i=0; i<numUnits; i++) {    
      if (p[i] instanceof Planet) {     
        if (dist(mx, my, p[i].getX(), p[i].getY())<p[i].getSize()/2) {
          if(((Planet)p[i]).isPopulated())
            return false;
          else{            
                ((Planet) p[i]).populate(time);       
                return true;
          }
        }
    }
  }  
  return false;
  }
  
  //not exactly accurate to remove fog, but makes it work.
  public void removeFog(int mx, int my){
    for (int i=0; i<numUnits; i++) {    
      if (p[i] instanceof Fog) {     
        if (dist(mx, my, p[i].getX(), p[i].getY())<p[i].getSize()) {
         p[i].die();
        }
    }
  } 
  }
  
  public void winCondition(){
    fill(0);
    rect(width/4,height/4,width*2/4,height*2/4);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("Congrats you won!!!",width/2, height/2);
  }
  
  public void loseCondition(){
    fill(0);
    rect(width/4,height/4,width*2/4,height*2/4);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("You ran out of Time, Nice Try!!!",width/2, height/2);
  }
  
  //Nick's Minimap
  
  public void miniMap() {
    rectMode(CENTER); //to put the origin of the radar
    fill(0);
    noStroke();
    rect(width-125, height-100, 200, 150);
    for (int i=0; i<numUnits; i++) {
      float x = (p[i].getX() / 15) + (width - 155);
      float y = (p[i].getY() / 15) + (height - 122);
      if (p[i] instanceof Planet && x > width-220 && x < width-30 && y > height - 170 && y < height-30) {
        fill(255);
        ellipse(x, y, p[i].getSize()/20, p[i].getSize()/20);
      }
    }
    for (int i = 0; i<numUnits; i++) {
      float x = (p[i].getX() / 15) + (width - 155);
      float y = (p[i].getY() / 15) + (height - 122);
      if (p[i] instanceof Fog &&  x > width-228 && x < width-22 && y > height - 178 && y < height-22) {
        fill(0);
        rect(x, y, 17, 17);
      }
    }
    for (int i=0; i<numUnits; i++) {
      float x = (p[i].getX() / 15) + (width - 155);
      float y = (p[i].getY() / 15) + (height - 122);
      if (x < width-220) {
        x = width-220;
      }
      if (x > width-30) {
        x = width-30;
      }
      if (y < height-170) {
        y = height-170;
      }
      if (y > height-30) {
        y = height-30;
      }
      if (p[i] instanceof Ship) {
        fill(255, 0, 0);
        ellipse(x, y, 5, 5);
      }
      if (p[i] instanceof ExploreShip) {
        fill(0, 0, 255);
        ellipse(x, y, 5, 5);
      }
    }
    fill(0, 0);
    stroke(255);
    rect(width-125, height-100, 200, 150);
    rectMode(CORNER);
  }
}
