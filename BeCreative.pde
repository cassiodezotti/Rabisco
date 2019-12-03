/*
  ToDo: JavaDoc
*/
import java.util.Iterator;

boolean drawSkeletonTool = true;
String userTextInput = "";
boolean gettingUserTextInput = false;
Scene scene = new Scene();
private boolean MOTION_BLUR = true;
private PVector normPosRight = new PVector(0,0);
private PVector normPosLeft = new PVector(0,0);
boolean firstTime = true;
private ParticleSystem systemRight = new ParticleSystem();
private ParticleSystem systemLeft = new ParticleSystem();
PGraphics mixer;
PShader mixerShader;
private int numberOfParticles = 12;
private int firstSkeleton;
private int coder = 2;
private int codel = 2;
private float minHeight;
private float maxHeight;
int pdPort = 3000;
int myPort = 3001;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
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

//Estes são os valores para serem alterados
private int saturationIncrement = 1; //
private float jerkRange =  0.5; //quanto menor mais rápido aumenta a saturação


 




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
  
  for(Skeleton skeleton:scene.activeSkeletons.values()){
    firstSkeleton = skeleton.indexColor;
    minHeight = (skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2;
    maxHeight = ((skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2)+((skeleton.bones[13].measuredLength+skeleton.bones[17].measuredLength)/2)+skeleton.bones[0].measuredLength+skeleton.bones[1].measuredLength+skeleton.bones[2].measuredLength+skeleton.bones[3].measuredLength+((skeleton.bones[6].measuredLength+skeleton.bones[10].measuredLength)/2);//+((skeleton.bones[7].measuredLength+skeleton.bones[11].measuredLength)/2);
    if(scene.floor.isCalibrated){        
        //this.numberOfParticles = int(skeleton.momentum.total/percentOfParticles);
        
        
        this.normPosRight = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition);
        this.normPosRight.x = map(this.normPosRight.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
        this.normPosRight.y = map(this.normPosRight.y,maxHeight,minHeight,-height/2,height/2);
        
        if(skeleton.joints[HAND_RIGHT].standartDeviationNorm < this.jerkRange){
          systemRight.saturation = systemRight.saturation - this.saturationIncrement;
          skeleton.joints[HAND_RIGHT].saturation = systemRight.saturation;
          skeleton.joints[HAND_RIGHT].saturation = norm(skeleton.joints[HAND_RIGHT].saturation,0,100);
        }
        
        if(skeleton.joints[HAND_RIGHT].standartDeviationNorm > this.jerkRange && skeleton.joints[HAND_RIGHT].standartDeviationNorm<1){
          systemRight.saturation = systemRight.saturation + this.saturationIncrement;
          skeleton.joints[HAND_RIGHT].saturation = systemRight.saturation;
          skeleton.joints[HAND_RIGHT].saturation = norm(skeleton.joints[HAND_RIGHT].saturation,0,100);
        }
        
        systemRight.saturation = constrain(systemRight.saturation,0,100);
        if(skeleton.rightHandRondDuBras.activatedDirectionCode != 0){this.coder = skeleton.rightHandRondDuBras.activatedDirectionCode;}
        systemRight.addParticles(this.normPosRight,coder);
      
      
        this.normPosLeft = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_LEFT].estimatedPosition);
        this.normPosLeft.x = map(this.normPosLeft.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
        this.normPosLeft.y = map(this.normPosLeft.y,maxHeight,minHeight,-height/2,height/2);
        
        if(skeleton.joints[HAND_LEFT].standartDeviationNorm<0.5){
          systemLeft.saturation = systemLeft.saturation - this.saturationIncrement;
          skeleton.joints[HAND_LEFT].saturation = systemLeft.saturation;
          skeleton.joints[HAND_LEFT].saturation = norm(skeleton.joints[HAND_LEFT].saturation,0,100);
        }
        if(skeleton.joints[HAND_LEFT].standartDeviationNorm>0.5 && skeleton.joints[HAND_LEFT].standartDeviationNorm<1){
          systemLeft.saturation = systemLeft.saturation + this.saturationIncrement;
          skeleton.joints[HAND_LEFT].saturation = systemLeft.saturation;
          skeleton.joints[HAND_LEFT].saturation = norm(skeleton.joints[HAND_LEFT].saturation,0,100);
        }
        
        systemLeft.saturation = constrain(systemLeft.saturation,0,100);
        if(skeleton.leftHandRondDuBras.activatedDirectionCode != 0){this.codel = skeleton.leftHandRondDuBras.activatedDirectionCode;}
        systemLeft.addParticles(this.normPosLeft,codel);
       
       
        communication.sendMessageToElenaProject(skeleton);
     
    }
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
    drawBackground();
    translate(width/2, height/2,0);
    
    systemLeft.update();
    systemRight.update();
  }
  
  //communication.sendScene(scene);
}
/*void paint(float x,float y,color cor){
  int NUM = 500;
  float mx = x;
  float my = y;  
  color col = cor;
  Particles [] particle = new Particles [NUM]; 
  for(int j = 0; j<5;j++){
    for(int i = 0; i< NUM; i++){
      if(mx < width/2 && my <height/2){col = color (255,random(0,150),random(0,150));};
      if(mx > width/2 && my <height/2){col = color (random(0,150),255,random(0,150));};
      if(mx < width/2 && my >height/2){col = color (random(0,150),random(0,150),255);};
      if(mx > width/2 && my > height/2){col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-900,900);
     float divY = random(-900,900);
     float distance = sqrt(divX*divX+divY*divY);
     float particleR = 60* exp(-distance*0.03);
     particle[i] = new Particles(mx+divX, my+divY, particleR,col);
     particle[i].appear();
    }
    for(int i = 0; i< NUM; i++){
      if(mx < width/2 && my <height/2){col = color (255,random(0,150),random(0,150));};
      if(mx > width/2 && my <height/2){col = color (random(0,150),255,random(0,150));};
      if(mx < width/2 && my >height/2){col = color (random(0,150),random(0,150),255);};
      if(mx > width/2 && my > height/2){col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-600,600);
     float divY = random(-600,600);
     float distance = sqrt(divX*divX+divY*divY);
     float particleR = 60* exp(-distance*0.06);
     particle[i] = new Particles(mx+divX, my+divY, particleR,col);
     particle[i].appear();
    }
    for(int i = 0; i< NUM; i++){
      if(mx < width/2 && my <height/2){col = color (255,random(0,150),random(0,150));};
      if(mx > width/2 && my <height/2){col = color (random(0,150),255,random(0,150));};
      if(mx < width/2 && my >height/2){col = color (random(0,150),random(0,150),255);};
      if(mx > width/2 && my > height/2){col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-300,300);
     float divY = random(-300,300);
     float distance = sqrt(divX*divX+divY*divY);
     float particleR = 60* exp(-distance*0.12);
     particle[i] = new Particles(mx+divX, my+divY, particleR,col);
     particle[i].appear();
    }
  }
}*/

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
    if(key == 's') scene.drawScene = !scene.drawScene;
    if(key == 'm') scene.drawMeasured = !scene.drawMeasured;
    if(key == 'b') scene.drawBoneRelativeOrientation = !scene.drawBoneRelativeOrientation;
    if(key == 'j') scene.drawJointOrientation = !scene.drawJointOrientation;
    if(key == 'h') scene.drawHandRadius = !scene.drawHandRadius;
    if(key == 'H') scene.drawHandStates = !scene.drawHandStates;
    if(key == 'p') scene.drawPollock = !scene.drawPollock;
    if(key == 'r') scene.drawRondDuBras = !scene.drawRondDuBras;
    if(key == 'c') scene.drawCenterOfMass = !scene.drawCenterOfMass;
    if(key == 'M') scene.drawMomentum = !scene.drawMomentum;

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
    systemRight.saturation = 100;
    systemLeft.saturation = 100;
    systemRight.addParticles(new PVector (-mouseX, -mouseY),codel);
    
    systemLeft.addParticles(new PVector (mouseX, mouseY),coder);
    
    
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
