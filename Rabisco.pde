/*
  ToDo: JavaDoc
*/
import java.util.Iterator;
  
import processing.sound.*;
  
SoundFile face1;
SoundFile face2;
SoundFile face3;
SoundFile face4;
SoundFile face5;
SoundFile face6;
SoundFile rotE;
SoundFile rotD;
SoundFile rotC;
SoundFile rotB;

private PVector normPosCurrent = new PVector(0,0);
private PVector normPosPrevious = new PVector(0,0);
private boolean wasDrawing = false;
private boolean enableMouseControl = true;
private String change = "false";
float red;
float blue;
float gren;
float speed;
float alpha;
float lineWidth;
int pdPort = 7777;
int myPort = 7777;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
private String eraser = "false";
private int quadrante;
private int face = 1;
private int orientation  = 1;
private int rotate = 0;

Communication communication = new Communication("143.106.219.176" , pdPort, myPort);//"127.0.0.1"  "143.106.219.176"

public ArrayList<Trajectory> trajectories = new ArrayList<Trajectory>();




void setup() {
  colorMode(HSB,360,100,100);
  frameRate(25);
  size(500, 500, P3D);
  face1 = new SoundFile(this, "face1.wav");
  face2 = new SoundFile(this, "face2.wav");
  face3 = new SoundFile(this, "face3.wav");
  face4 = new SoundFile(this, "face4.wav");
  face5 = new SoundFile(this, "face5.wav");
  face6 = new SoundFile(this, "face6.wav");
  rotD = new SoundFile(this, "rota1.wav");
  rotC = new SoundFile(this, "rota2.wav");
  rotE = new SoundFile(this, "rota3.wav");
  rotB = new SoundFile(this, "rota4.wav");
}

void draw() {
    // Your animation algorithm should be placed here
    beginCamera();
    camera();
    translate(0,0,0);
    rotateX(0);
    rotateY(0);
    endCamera();
    
    drawBackground();
    
    
  if(enableMouseControl == true) {
   if (mousePressed){
     this.normPosCurrent.x = float(mouseX)/width;
     this.normPosCurrent.y = float(mouseY)/height;
     switch(this.face){
       case(2):
         this.normPosCurrent.z = -this.normPosCurrent.x;
         break;
       case(4):
         this.normPosCurrent.z = -this.normPosCurrent.x;
         break;
       case(3):
         this.normPosCurrent.z = -this.normPosCurrent.y;
         break;
       case(5):
         this.normPosCurrent.z = -this.normPosCurrent.y;
         break;
     }
    if(!wasDrawing){
      this.normPosPrevious.x = this.normPosCurrent.x;
      this.normPosPrevious.y = this.normPosCurrent.y;
      
      switch(this.face){
        case(2):
          this.normPosPrevious.z = -this.normPosCurrent.x;
          break;
        case(4):
          this.normPosPrevious.z = -this.normPosCurrent.x;
          break;
        case(3):
          this.normPosPrevious.z = -this.normPosCurrent.y;
          break;
        case(5):
          this.normPosPrevious.z = -this.normPosCurrent.y;
          break;
      }
    }
    
     switch(this.face){
       case(1): 
         if(this.normPosCurrent.x<0.5 && this.normPosCurrent.y<0.5){quadrante = 1;}//primeiro quadrante
         if(this.normPosCurrent.x>0.5 && this.normPosCurrent.y<0.5){quadrante = 2;}//segundo quadrante
         if(this.normPosCurrent.x>0.5 && this.normPosCurrent.y>0.5){quadrante = 3;}//terceiro quadrante
         if(this.normPosCurrent.x<0.5 && this.normPosCurrent.y>0.5){quadrante = 4;}//quarto quadrante
         break;
       case(2):
         if(this.normPosCurrent.y<0.5){quadrante = 2;}
         if(this.normPosCurrent.y>0.5){quadrante = 3;}
         break;
       case(3):
         if(this.normPosCurrent.x<0.5){quadrante = 1;}
         if(this.normPosCurrent.x>0.5){quadrante = 2;}
         break;
       case(4):
         if(this.normPosCurrent.y<0.5){quadrante = 1;}
         if(this.normPosCurrent.y>0.5){quadrante = 4;}
         break;
       case(5):
         if(this.normPosCurrent.x<0.5){quadrante = 4;}
         if(this.normPosCurrent.x>0.5){quadrante = 3;}
         break;  
       case(6):
         if(this.normPosCurrent.x<0.5 && this.normPosCurrent.y<0.5){quadrante = 1;}//primeiro quadrante
         if(this.normPosCurrent.x>0.5 && this.normPosCurrent.y<0.5){quadrante = 2;}//segundo quadrante
         if(this.normPosCurrent.x>0.5 && this.normPosCurrent.y>0.5){quadrante = 3;}//terceiro quadrante
         if(this.normPosCurrent.x<0.5 && this.normPosCurrent.y>0.5){quadrante = 4;}//quarto quadrante
         break;
     }
   
    communication.sendTrajectory(this.normPosCurrent,this.normPosPrevious,this.face,this.orientation,this.quadrante);
    
    this.normPosPrevious.x = this.normPosCurrent.x;
    this.normPosPrevious.y = this.normPosCurrent.y;
    
    println(this.face);
    switch(this.face){
      case(2):
        this.normPosPrevious.z = -this.normPosCurrent.x;
        break;
      case(4):
        this.normPosPrevious.z = -this.normPosCurrent.x;
        break;
      case(3):
        this.normPosPrevious.z = -this.normPosCurrent.y;
        break;
      case(5):
        this.normPosPrevious.z = -this.normPosCurrent.y;
        break;
    }
    wasDrawing = true;
   }
  }
}

void drawBackground(){
  color back = color(0,0,0);
    noStroke();
    fill(back,45);
    rect(0, 0, width, height);
}

void keyPressed(){    
    if(key == 'd') {
      this.rotate = 1;
      change = "true";
      rotD.play();
    }
    if(key == 'w') {
      this.rotate = 2;
      change = "true";
      rotC.play();
    }
    if(key == 'a') {
      this.rotate = 3;
      change = "true";
      rotE.play();
    }
    if(key == 'x') {
      this.rotate = 4;
      change = "true";
      rotB.play();
    }
    if(key == ' '){
      this.eraser = "true";
      communication.sendEraser(this.eraser);
      this.eraser = "false";
    }
     if(this.rotate != 0){
       switch(this.rotate){
         case 1:
           if(this.face == 1 || this.face == 3 || this.face == 5 || this.face == 6 ){
               this.face = 4;
           }
           else if(this.face == 2){
               this.face = 1;
           }
           else if(this.face == 4){
               this.face = 6;
           }
         break;
         case 2:
           if(this.face == 1 || this.face == 2 || this.face == 4 ){
               this.face = 5;
           }
           else if(this.face == 3){
               this.face = 1;
           }
           else if(this.face == 6){
               this.face = 3;
           }
           else if(this.face == 5){
               this.face = 6;
           }
         break;
         case 3:
           if(this.face == 1 || this.face == 3 || this.face == 5 || this.face == 6 ){
               this.face = 2;
           }
           else if(this.face == 2){
               this.face = 6;
           }
           else if(this.face == 4){
               this.face = 1;
           }
         break;
         case 4:
           if(this.face == 1 || this.face == 2 || this.face == 4 ){
               this.face = 3;
           }
           else if(this.face == 3){
               this.face = 6;
           }
           else if(this.face == 5){
               this.face = 1;
           }
           else if(this.face == 6){
               this.face = 5;
           }
         break;
       }
        this.rotate = 0;
        communication.sendChangeFace(change,this.face);
        change = "false";
    }
}

  
void mousePressed() {
  println("face"+this.face);
  switch (this.face){
      case(1):
        if(!face1.isPlaying()){
              face1.loop();  
            }
        break;
      case(2):
        if(!face2.isPlaying()){
              face2.loop();  
            }
        break;
      case(3):
        if(!face3.isPlaying()){
              face3.loop();  
            }
        break;
      case(4):
         if(!face4.isPlaying()){
              face4.loop();  
            }
        break;
      case(5):
        if(!face5.isPlaying()){
              face5.loop();  
            }
      case(6):
        if(!face6.isPlaying()){
              face6.loop();  
            }
        break;
      }
 
}
void mouseReleased() {
  wasDrawing = false;
  face1.stop();
  face2.stop();
  face3.stop();
  face4.stop();
  face5.stop();
  face6.stop();
}
