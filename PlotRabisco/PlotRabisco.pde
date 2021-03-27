import oscP5.*;
import netP5.*;


public ArrayList<Trajectory> trajectories = new ArrayList<Trajectory>();
public Trajectory traj;
private float Xp = 0;
private float Yp = 0;
private float Zp = 0;
private float X = 0;
private float Y = 0;
private float Z = 0;
private PVector current = new PVector(0,0);
private PVector previous = new PVector(0,0);
private OscP5 oscP5;
private int red;
private int green;
private int blue;
private int yellow;
private boolean eraser = false;
private boolean MOTION_BLUR = false;
private int counter = 0;
private ArrayList<Integer> colors = new ArrayList<Integer>();
private int cor;
private int quadrante;
private int face = 1;
private PVector [] coordenate = new PVector [2];
int myCurrentRandomNumber;
int mode = 1;
boolean change = false;

//NetAddress myRemoteLocation;


void setup() {
  fullScreen();
  colorMode(HSB,360,100,100);
  frameRate(25);
  oscP5 = new OscP5(this,"239.0.0.1",7777); //For receie data in OSC
  drawBackground();
  //myRemoteLocation = new NetAddress("239.0.0.1",1200);
  traj = new Trajectory(new PVector(0,0),new PVector(0,0),0,0,0,1,0);
}

void draw() {
  

  if(change) {
    changeFace(this.face);
    this.change = false;
    trajectories.add(traj);
    traj = new Trajectory(new PVector(0,0),new PVector(0,0),0,0,0,this.face,0);
    plotAll();
  }
  
  if(this.eraser){
   print("salvou");
   saveFrame("savedSession"+"_"+day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+"-"+second()+".tif"); 
   drawBackground();
   eraserTrajectory();
   this.eraser = false;
   
   counter = counter + 1; 
  }
  
  quadrants();
  this.cor = setColors(this.quadrante);
  this.coordenate = setCoordenates(this.face);
  setReferences(this.face);
  this.current = this.coordenate[0];
  this.previous = this.coordenate[1];
     
  
  float speed = dist(this.previous.x*width, this.previous.y*height, this.current.x*width, this.current.y*height);//dist(Xp*width, Yp*height, X*width, Y*height);
  float lineWidth = map(speed, 5, 50, 2, 20);
  lineWidth = constrain(lineWidth, 0, 100);
  
 
  
  noStroke();
  fill(0, 100);
  strokeCap(ROUND);
  stroke(cor,int(random(80,100)),100);
  strokeWeight(lineWidth);
  //line(Xp*width, Yp*height, X*width, Y*height);
  switch(mode){
    case 1: line(this.previous.x*width, this.previous.y*height, this.current.x*width, this.current.y*height);
      break;
    case 2: point(this.current.x*width, this.current.y*height);
      break;
    case 3: rect(this.current.x*width, this.current.y*height, random(80), random(80));
      break;
  }
  
  
  
  
  
}  
void keyPressed(){
  //For change line effect
    if(key == 'q') this.mode = 1;
    if(key == 'w') this.mode = 2;
    if(key == 'e') this.mode = 3;
    
}

void drawBackground(){
  
  color back = color(100,0,100);
  if (MOTION_BLUR) {
    // Background with motion blur
    noStroke();
    fill(back,45);
    rect(0, 0, width, height);
  } else {
    // Normal background
    noStroke();
    background(back);
  }
}


void oscEvent(OscMessage theOscMessage)
{ 
  // get the values for trajectory tag, for update the trajectory
  if(theOscMessage.checkAddrPattern("/trajectory")==true) {
    
    if(theOscMessage.checkTypetag("ffffffiii")) {
      float xp = theOscMessage.get(0).floatValue();
      float yp = theOscMessage.get(1).floatValue();
      float zp = theOscMessage.get(2).floatValue();
      float x = theOscMessage.get(3).floatValue();
      float y = theOscMessage.get(4).floatValue();
      float z = theOscMessage.get(5).floatValue();
      int face = theOscMessage.get(6).intValue();
      int orientation = theOscMessage.get(7).intValue();
      int quadrant = theOscMessage.get(8).intValue();
      println("x %f",x);
      println("y %f",y);
      println("z %f",y);
      println("xp %f",xp);
      println("yp %f",yp);
      println("zp %f",y);
      //this.orientacao = orientation;
      this.face = face;
      this.quadrante = quadrant;
      this.Xp = xp;
      this.Yp = yp;
      this.Zp = zp;
      this.X = x;
      this.Y = y;
      this.Z = z;
           
      traj.update(new PVector((setCoordenates(this.face))[0].x,(setCoordenates(this.face))[0].y),new PVector((setCoordenates(this.face))[1].x,(setCoordenates(this.face))[1].y),this.face,this.quadrante,this.mode);

    }
  }
  
  // get the values for eraser tag for erase the face and safe screenshot
  if(theOscMessage.checkAddrPattern("/eraser")==true) {
    if(theOscMessage.checkTypetag("s")) {
      String check = theOscMessage.get(0).stringValue();
      
      if(check.equals("true")){
        this.eraser = true;
      }
      else if (check.equals("false")){
       this.eraser = false; 
      }
      //return;
    }
  }
  // get the values for change tag for change face
  if(theOscMessage.checkAddrPattern("/change")==true) {
    if(theOscMessage.checkTypetag("si")) {
      
      String novo = theOscMessage.get(0).stringValue();
      int face = theOscMessage.get(1).intValue();
      
      this.face = face;
      
      if(novo.equals("true")){
        this.change = true;
      }
      else if (novo.equals("false")){
       this.change = false; 
      }
    }
  }
}


public void quadrants(){
  while(this.colors.size()<4){
    do {
        this.myCurrentRandomNumber = (int) random(1, 5);
    //repeat this until the number is not in the list
    } while (this.colors.contains(new Integer(this.myCurrentRandomNumber)));
    //here there is a unique random number, do what you will
    //add the number to the list so it wont be picked again
    this.colors.add(new Integer(this.myCurrentRandomNumber));
  }  
}

public int setColors(int quadrante){
  int cor = 0;
  this.blue = 210;//int(random(170,250));
  this.red = 10;//int(random(0,20));
  this.green = 100;//int(random(80,120));
  this.yellow =40;// int(random(40,70));
  
  if(quadrante == 1){cor = this.colors.get(0);}//primeiro quadrante
  if(quadrante == 2){cor = this.colors.get(1);}//segundo quadrante
  if(quadrante == 3){cor = this.colors.get(2);}//terceiro quadrante
  if(quadrante == 4){cor = this.colors.get(3);}//quarto quadrante
  
  
  switch(cor){
    case 1: cor = this.blue;
      break;
    case 2: cor = this.red;
      break;
    case 3: cor = this.green;
      break;
    case 4: cor = this.yellow;
      break;  
  } 
  return cor;
  
}

public PVector[] setCoordenates(int face){
  PVector current = new PVector(0,0);
  PVector previous = new PVector(0,0);
  switch(face){
    case 1: 
      current.x = this.X;
      current.y = this.Y;
      previous.x = this.Xp;
      previous.y = this.Yp;
      break;
    case 2: 
      current.x = -this.Z;
      current.y = this.Y;
      previous.x = -this.Zp;
      previous.y = this.Yp;
      break;
    case 3: 
      current.x = this.X;
      current.y = this.Z;
      previous.x = this.Xp;
      previous.y = this.Zp;
      break;
    case 4: 
      current.x = this.Z;
      current.y = this.Y;
      previous.x = this.Zp;
      previous.y = this.Yp;
      break;
    case 5: 
      current.x = this.X;
      current.y = -this.Z;
      previous.x = this.Xp;
      previous.y = -this.Zp;
      break;
    case 6: 
      current.x = this.X;
      current.y = -this.Y;
      previous.x = this.Xp;
      previous.y = -this.Yp;
      break;
  }
  PVector [] coordenate = new PVector[2];
  coordenate[0] = current;
  coordenate[1] = previous;
  return coordenate;
}

public void setReferences(int face){
  switch(face){
    case 3: 
      translate(0,height);
      break;
    case 4: 
      translate(width,0);
      break;
    case 6: 
      translate(0,height);
      break;
  }
}
private void plotAll(){
 for(int i = 0; i < this.trajectories.size();i++){ 
   if(this.trajectories.get(i).face == this.face){
     //setReferences(this.trajectories.get(i).face);
     setCoordenates(this.trajectories.get(i).face);
     this.trajectories.get(i).plot();
   }
 }
}
private void changeFace(int face){
  drawBackground();
  setReferences(face);
}
private void eraserTrajectory(){
  for(int i = (this.trajectories.size())-1; i >= 0 ; i--){ 
   if(this.trajectories.get(i).face == this.face){
     //setReferences(this.trajectories.get(i).face);
     this.trajectories.remove(i);
   }
 }
}
