import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

/*
* Title Screen for game S.P.A.C.E
* Intro and title screen
* by: Luke Harper 100886836
* Nick Chaisson 
* Jacob Dyck 100895857
*/

public class TitleScreen{

  Minim minim;
  AudioPlayer vo, ambiance;
  AudioInput input;
  PImage p, show;
  
  float introTime;
  float [] starsX = new float[300]; //recording all the random star positions in X and Y
  float [] starsY = new float[300];
  float [] planetX = new float[10]; //the planet positions in X and Y
  float [] planetY = new float[10];
  float sunX, sunY; //position for the sun when the sun is being drawn
  float zoom; //zoom magnification for th sun
  
  int fadetime =0; //to fade the title in.
  
  public TitleScreen()
  {
    //minim for imputting, and playing the ambiance sound and voice over  
    //minim= new Minim(this);  
    
    
    //loading title
    p=loadImage("SPACETitle.png");
    p.loadPixels();
    show = createImage(p.width,p.height,RGB);
    
    zoom=0;
    introTime=0;
    background(0);
    size(1000,650);
    createStars();
    sunX=width/2;
    sunY=height/2;
    
    //assigning the values for the planets, specifically placed
    planetX[0]=350;
    planetX[1]=700;
    planetX[2]=422;
    planetX[3]=517;
    planetX[4]=678;
    planetX[5]=473;
    planetX[6]=280;
    planetX[7]=490;
    planetX[8]=475;
    planetX[9]=310;
    
    planetY[0]= 95;
    planetY[1]=223 ;
    planetY[2]= 375;
    planetY[3]= 410;
    planetY[4]= 487;
    planetY[5]= 146;
    planetY[6]= 585;
    planetY[7]= 372;
    planetY[8]= 470;
    planetY[9]= 99;
    
  }
  
  public void titleUpdate()
  {
    //playing sound and starting intro.
    ambiance.play();
    mainStartIntro(introTime);
    introTime++;
    //image(p,0,0);
  }
  

  
  void createStars()
  {
    for(int i=0; i<starsX.length; i++)
    {
      starsX[i] =  random(-10, width+10);
      starsY[i] =  random(-height-20,0);
    }
  }
  
  //runs through the intro, possibly putting into class for the main assignment (couldn't get it working within the timeFrame like I wanted)
  
    void mainStartIntro(float c)
    {
      background(0);
      if(c>60&&c<225)
      {
        mainMoveStars(c);
      }
      else if(c>=210&&c<=1000)
      {
        backgroundStars();
        sunZoom(c);
        vo.play();
      }
      else if(c>=1000&&c<1400)
      {
        backgroundStars();
        solarSystem();
        sunMove(c);
      }           
      else if(c>=1400)
      {
        if(c==1400)
        {
          sunX-=400;
          sunY+=400;       
        } 
        
        backgroundStars();
        solarSystem();
        sunStay();
        image(show,width*10/17, height*8/10);
        fadetime++;
        fadein(fadetime);
        show.updatePixels();
        
      }
    }
    //the stars moving from the top (camera looks upward)
    void mainMoveStars(float c)
    {
      float move=4;
      for(int i=0; i<starsY.length; i++)
      {
        starsY[i]+=move; 
      }
      for(int i=0; i<starsX.length; i++)
      {
        ellipse(starsX[i], starsY[i], 3,3);
      }
    }
    
    //the stars static as the backdrop of space
    void backgroundStars()
    {
      fill(255);
      for(int i=0; i<starsX.length; i++)
      {
        ellipse(starsX[i], starsY[i],3,3);
      }
      ellipse(sunX, sunY, 0,0);
    }
    
    //zooms in on a particular star in the array of them, focuses in the center
    void sunZoom(float c)
    {
      zoom = c-210;
      if(zoom<=255)
      {      
      fill(255,255,255-zoom);      
      }
      else
      {
        fill(255,255,0);
      }
      ellipse(sunX, sunY, zoom, zoom);
    }
    
    
    //drawing the planets
    void solarSystem()
    {   
      fill(0,0,255);
      ellipse(planetX[4],planetY[5],245,245);
      
      fill(0,255,255);
      ellipse(planetX[9],planetY[0],201,201);
      
      fill(255,0,255);
      ellipse(planetX[6], planetY[3],175,175);    
          
      fill(0,255,0);
      ellipse(planetX[3],planetY[6],123,123);
     
      fill(0,255,255);
      ellipse(planetX[7],planetY[2],111,111); 
      
      fill(255,0,0);
      ellipse(planetX[1],planetY[8],100,100);
      
      fill(255,0,255);
      ellipse(planetX[8], planetY[1],93,93);
      
      fill(0,0,255);
      ellipse(planetX[5],planetY[4],82,82);
      
      fill(255,0,0);
      ellipse(planetX[0],planetY[9],50,50);    
      
      fill(0,255,0);
      ellipse(planetX[2],planetY[7],25,25);
      
      
    }
    
    //moving the sun to the left screen to reveal the planets, meant to mimic the camera moving around the sun
    void sunMove(float c)
    {
      float move=c-1000;    
      fill(255,255,0);
      ellipse(sunX-move,sunY+move,zoom,zoom);
    }
    
    //sun staying in the corner of the screen
    void sunStay()
    {
      fill(255,255,0);
      ellipse(sunX,sunY,zoom,zoom);    
    }
    
    //fading in of the title. Taken from 1406 fade in template
    void fadein(int fadetime)
  {
    float ratio = fadetime/100.0;
    
    if (ratio > 1) ratio = 1; 
    
    for (int i = 0; i < show.height*show.width; i++)
      {
        color c = p.pixels[i];   
        show.pixels[i] = color(red(c)*ratio,green(c)*ratio,blue(c)*ratio);
      
      }
  }
}
