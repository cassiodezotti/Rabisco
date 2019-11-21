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
private boolean firstDraw = true;
private boolean drawpaint = false;
boolean firstTime = true;
private ParticleSystem systemRight = new ParticleSystem();
private ParticleSystem systemLeft = new ParticleSystem();
PGraphics mixer;
PShader mixerShader;
private int numberOfParticles = 12;
private int percentOfParticles = 2;
//private color endColor;
//private color startColor;
private int bright = 100;
private int firstSkeleton;
private int coder = 2;
private int codel = 2;
private float minHeight;
private float maxHeight;

int pdPort = 3000;
int myPort = 3001;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
Communication communication = new Communication("143.106.219.176", pdPort, myPort);
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
    //println("ID", skeleton.scene.activeSkeletons.values());
    //println("UD", skeleton.scene.activeSkeletons.size());
    
    minHeight = (skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2;
    maxHeight = ((skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2)+((skeleton.bones[13].measuredLength+skeleton.bones[17].measuredLength)/2)+skeleton.bones[0].measuredLength+skeleton.bones[1].measuredLength+skeleton.bones[2].measuredLength+skeleton.bones[3].measuredLength+((skeleton.bones[6].measuredLength+skeleton.bones[10].measuredLength)/2);//+((skeleton.bones[7].measuredLength+skeleton.bones[11].measuredLength)/2);
    if(scene.floor.isCalibrated){
      //if((skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_LEFT].estimatedPosition)).y > (skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[SPINE_BASE].estimatedPosition)).x && (skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition)).y > (skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[SPINE_BASE].estimatedPosition)).x){
        //println("Momentum Average",skeleton.momentum.averageTotal);//varia mais devagar, até 30
        //println("Momentum TOtal",skeleton.momentum.total); //varia mais rápido até 40
        //println("Deviation R",skeleton.joints[HAND_RIGHT].previousStandartDeviation);//chega até 7 com muito esforço, é possível manter em 2 ou 3
        //println("Deviation L",skeleton.joints[HAND_LEFT].previousStandartDeviation);
        
        //this.numberOfParticles = int(skeleton.momentum.total/percentOfParticles);
        this.normPosRight = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition);
        this.normPosRight.x = map(this.normPosRight.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
        this.normPosRight.y = map(this.normPosRight.y,maxHeight,minHeight,-height/2,height/2);
        
        
          
        //if(skeleton.rightHandRondDuBras.activatedDirectionCode != 0){coder = skeleton.rightHandRondDuBras.activatedDirectionCode;}
        
        if(skeleton.joints[HAND_RIGHT].standartDeviationNorm<0.1){
          systemRight.saturation = systemRight.saturation - 15;
        }
        if(skeleton.joints[HAND_RIGHT].standartDeviationNorm>0.1 && skeleton.joints[HAND_RIGHT].standartDeviationNorm<1){
          systemRight.saturation = systemRight.saturation + 15;
        }
        systemRight.saturation = constrain(systemRight.saturation,0,100);
        //systemRight.saturation = 100;
        
        if(skeleton.rightHandRondDuBras.activatedDirectionCode != 0){this.coder = skeleton.rightHandRondDuBras.activatedDirectionCode;}
        
        //println("CORR", this.coder);
        systemRight.addParticles(this.normPosRight,coder);/*map(this.normPos.y,-height/2, height/2,0,1)     ,map(skeleton.joints[HAND_RIGHT].previousStandartDeviation,0,6,0,100*/
      
        this.normPosLeft = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_LEFT].estimatedPosition);
        this.normPosLeft.x = map(this.normPosLeft.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
        this.normPosLeft.y = map(this.normPosLeft.y,maxHeight,minHeight,-height/2,height/2);
        
        //if(skeleton.leftHandRondDuBras.activatedDirectionCode != 0){codel = skeleton.leftHandRondDuBras.activatedDirectionCode;}
        
        if(skeleton.joints[HAND_LEFT].standartDeviationNorm<0.1){
          systemLeft.saturation = systemLeft.saturation - 15;
        }
        if(skeleton.joints[HAND_LEFT].standartDeviationNorm>0.1 && skeleton.joints[HAND_LEFT].standartDeviationNorm<1){
          systemLeft.saturation = systemLeft.saturation + 15;
        }
        systemLeft.saturation = constrain(systemLeft.saturation,0,100);
        //systemLeft.saturation = 100;
        
        if(skeleton.leftHandRondDuBras.activatedDirectionCode != 0){this.codel = skeleton.leftHandRondDuBras.activatedDirectionCode;}
        //println("CORL", this.codel);
        systemLeft.addParticles(this.normPosLeft,codel);/*map(this.normPos.y,-height/2, height/2,0,1)      ,map(skeleton.joints[HAND_LEFT].previousStandartDeviation,0,6,0,100*/
        
       /* if(skeleton.leftHandPollock.activationDirectionCode != 0 ){
          paint(normPosLeft.x,normPosLeft.y,color(0));
          println("\nmao x",this.normPosLeft.x,"\nmao y", this.normPosLeft.y);
          println("\npollock direction x",(scene.floor.toFloorCoordinateSystem(skeleton.leftHandPollock.headToHandPosition)).x,"\npollock direction y",(scene.floor.toFloorCoordinateSystem(skeleton.leftHandPollock.headToHandPosition).y));
          println("\npollock2 direction x",(reScaleX(skeleton.leftHandPollock.headToHandPosition.x,"pollockdraw")),"\npollock2 direction y",(reScaleY(skeleton.leftHandPollock.headToHandPosition.y,"pollockdraw")));
          break;
        }*/
        communication.sendMessageToElenaProject(skeleton);
      //}
    }
  }
  
  if(scene.drawScene){
    scene.draw(); // measuredSkeletons, jointOrientation, boneRelativeOrientation, handRadius, handStates
    firstTime = true;
  } else{
    //if(firstTime) background(color(128));
    // Your animation algorithm should be placed here
    /*if(drawpaint){
     paint(mouseX,mouseY,color (0));
  }*/
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
    if(key == '1') codel = 1;
    if(key == '2') codel = 2;
    if(key == '3') codel = 3;
    if(key == '4') codel = 4;
    if(key == '5') codel = 5;
    if(key == '6') codel = 6;
    if(key == '7') coder = 1;
    if(key == '8') coder = 2;
    if(key == '9') coder = 3;
    if(key == '0') coder = 4;
    if(key == '-') coder = 5;
    if(key == '=') coder = 6;
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
