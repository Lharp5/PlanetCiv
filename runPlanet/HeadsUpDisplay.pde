class HeadsUpDisplay {
  
  int time;
  int resources;
  String eventStatus = "";
  float rotation = 0;
  public float statusAlpha = 0;
  
  public HeadsUpDisplay() {
    time = 0;
    resources = 0;
    eventStatus = "";
  }
  
  public void update(int t, int r) {
    time = t;
    resources = r;
    stroke(230);
    fill(50, 175);
    beginShape();
    vertex(width/2 - 225, height);
    vertex(width/2 - 200, height - 50);
    vertex(width/2 + 200, height - 50);
    vertex(width/2 + 225, height);
    endShape();
    
    beginShape();
    vertex(0, -10);
    vertex(250, -10);
    vertex(225, 40);
    vertex(0, 40);
    endShape();
    
    beginShape();
    vertex(width, -10);
    vertex(width - 250, -10);
    vertex(width - 225, 40);
    vertex(width, 40);
    endShape();
    
    fill(255);
    stroke(0);
    textSize(20);
    textAlign(LEFT);
    text("Time: " + time / 3600 + "." + (time / 60) % 60 + "." + (time / 10) % 6, 15, 25);
    textAlign(RIGHT);
    text("Resources: " + resources, width - 15, 25);
    fill(255, statusAlpha);
    textAlign(CENTER);
    text(eventStatus, width / 2, height - 15);
    statusAlpha -= 1;
    
  }
}
