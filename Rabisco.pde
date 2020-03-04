/*
  ToDo: JavaDoc
*/
import java.util.Iterator;


public ArrayList<Trajectory> trajectories = new ArrayList<Trajectory>();
boolean drawSkeletonTool = true;
String userTextInput = "";
boolean gettingUserTextInput = false;
Scene scene = new Scene();
private boolean MOTION_BLUR = true;
private PVector normPosCurrent = new PVector(0,0);
private PVector normPosPrevious = new PVector(0,0);
boolean firstTime = true;
PGraphics mixer;
PShader mixerShader;
private boolean wasGrabbed = false;
private String change = "false";
float red;
float blue;
float gren;
float speed;
float alpha;
float lineWidth;
int pdPort = 7777;
int myPort = 7777;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
Communication communication = new Communication("143.106.219.176" , pdPort, myPort);//"127.0.0.1"  "143.106.219.176"
private color blue1 ;
  private color purple1;
  private color red1;
  private color red2;
  private color orange;
  private color yellow1;
  private color yellow2;
  private color pink ;
  private color blu1;
  private color blu2;
  private color green;
  private color blue2;
  private color purple2;
  private String eraser = "false";
  private int quadrante;
  private int face = 1;
  private int orientation  = 1;
  private int rotate = 0;


 




void setup() {
  colorMode(HSB,360,100,100);
  frameRate(scene.frameRate_);
  size(500, 500, P3D);
  scene.init();
  green = color(100,100,100);
  blue1 = color(270, 100, 100);//245
  purple1 = color(295, 100, 100);//280
  red1 = color(0, 100, 100);
  red2 = color(359, 100, 100);
  orange = color(38, 100, 100);//38
  yellow1 = color(60, 100, 100);
  yellow2 = color(70, 100, 100);
  pink = color(315, 100, 100);
  blu1 = color(180,100,100);
  blu2 = color(210,100,100);//150
  purple2 = color(290, 100, 100);//295
  blue2 = color(240, 100, 100);//270
  
}

void draw() {
  scene.update();
  
    
  for(Skeleton skeleton:scene.activeSkeletons.values()){ //example of consulting feature
  
    
    switch (skeleton.leftHandRondDuBras.activatedDirectionCode){
      case(-2):
        this.rotate = 1;
        change = "true";
        break;
      case(2):
        this.rotate = 3;
        change = "true";
        break;
      case(-1):
        this.rotate = 2;
        change = "true";
        break;
      case(1):
        this.rotate = 4;
        change = "true";
        break;
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
  
    
    
      this.normPosCurrent = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition);
      
      if(skeleton.scene.floor.isCalibrated){
        
      }
      
      if(!(skeleton.measuredHandStates[1] == 2)){ // testar laço
          
          this.normPosCurrent = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition);
          this.normPosCurrent.x = norm(skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition).x,-skeleton.wingspan/2,skeleton.wingspan/2);
          this.normPosCurrent.y = map(skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition).y,skeleton.waistHeigth,skeleton.maxHeigth,1,0);
          
          if(!wasGrabbed){
            this.normPosPrevious = this.normPosCurrent;
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
          this.normPosPrevious = this.normPosCurrent;
          
          wasGrabbed = true;

        
      }
      else{
        wasGrabbed = false; 
      }
      
      if (skeleton.joints[HAND_RIGHT].estimatedPosition.y > skeleton.joints[HEAD].estimatedPosition.y && skeleton.joints[HAND_LEFT].estimatedPosition.y > skeleton.joints[HEAD].estimatedPosition.y && (this.eraser.equals("false"))){
        this.eraser = "true";
        communication.sendEraser(this.eraser);
      }
      else if(skeleton.joints[HAND_RIGHT].estimatedPosition.y < skeleton.joints[HEAD].estimatedPosition.y && skeleton.joints[HAND_LEFT].estimatedPosition.y < skeleton.joints[HEAD].estimatedPosition.y ){
        this.eraser = "false";
        communication.sendEraser(this.eraser);
      }
      
      //communication.sendTrajectory(this.normPosCurrent,this.normPosPrevious);
      //this.normPosPrevious = this.normPosCurrent;
    //}
  }
  
  if(scene.drawScene){
    scene.draw(); // measuredSkeletons, jointOrientation, boneRelativeOrientation, handRadius, handStates
    firstTime = true;
  } else{
    // Your animation algorithm should be placed here
    beginCamera();
    camera();
    translate(0,0,0);
    rotateX(0);
    rotateY(0);
    endCamera();
    
    
    
    
  }
  
  //communication.sendScene(scene);
}




void drawBackground(){
  
  color back = color(0,0,0);
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

void keyPressed(){
  if(gettingUserTextInput){
    if (keyCode == BACKSPACE) {
      if (userTextInput.length() > 0) {
        userTextInput = userTextInput.substring(0, userTextInput.length()-1);
        println(userTextInput);
      }
    } else if (keyCode == DELETE) {
      userTextInput = "";
    } else if (keyCode == RETURN || keyCode == ENTER){
      gettingUserTextInput = false;
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      userTextInput = userTextInput + key;
      println(userTextInput);
    }
  } else{
    
    if(key == 'f') scene.floor.manageCalibration();
    if(key == 'f') scene.floor.manageCalibration();
    if(key == 's') scene.drawScene = !scene.drawScene;
    if(key == 'm') scene.drawMeasured = !scene.drawMeasured;
    if(key == 'b') scene.drawBoneRelativeOrientation = !scene.drawBoneRelativeOrientation;
    if(key == 'j') scene.drawJointOrientation = !scene.drawJointOrientation;
    if(key == 'h') scene.drawHandRadius = !scene.drawHandRadius;
    if(key == 'H') scene.drawHandStates = !scene.drawHandStates;
    if(key == 'c') scene.drawCenterOfMass = !scene.drawCenterOfMass;
    if(key == 'l') firstTime = !firstTime;
    if(key == 'd') {
      this.rotate = 1;
      change = "true";
    }
    if(key == 'w') {
      this.rotate = 2;
      change = "true";
    }
    if(key == 'a') {
      this.rotate = 3;
      change = "true";
    }
    if(key == 'x') {
      this.rotate = 4;
      change = "true";
    }
    

  }
}

void mouseDragged() {
  if(mouseButton == CENTER){
    scene.cameraRotX = scene.cameraRotX - (mouseY - pmouseY)*PI/height;
    scene.cameraRotY = scene.cameraRotY - (mouseX - pmouseX)*PI/width;
  }
  if(mouseButton == LEFT){
    scene.cameraTransX = scene.cameraTransX + (mouseX - pmouseX);
    scene.cameraTransY = scene.cameraTransY + (mouseY - pmouseY);
   // translate(width/2, height/2);
    normPosPrevious.x = pmouseX;
    normPosPrevious.y = pmouseY;
    normPosCurrent.x = mouseX;
    normPosCurrent.y = mouseY;
    
    
  }
}

void mouseWheel(MouseEvent event) {
  float zoom = event.getCount();
  if(zoom < 0){
    scene.cameraTransZ = scene.cameraTransZ + 30;
  }else{
    scene.cameraTransZ = scene.cameraTransZ - 30;
  }
}
