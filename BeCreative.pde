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
boolean firstTime = true;
private ParticleSystem system = new ParticleSystem();
private ParticleSystem system1 = new ParticleSystem();
PGraphics mixer;
PShader mixerShader;
private int numberOfParticles = 12;
//private color endColor;
//private color startColor;
private color blue = color(0, 0, 255);
private color purple = color(139, 0, 139);
private color red = color(255, 0, 0);
private color orange = color(255, 60, 0);
private color yellow = color(255, 255, 0);
private color green = color(0, 255, 0);
private color pink = color(255, 20, 147);
private color blu = color(0,255,255);
private int firstSkeleton;
private int coder = 9;
private int codel = 9;
private float minHeight;
private float maxHeight;
int pdPort = 12000;
int myPort = 3001;
Communication communication = new Communication("192.168.15.16", pdPort, myPort);

void setup() {
  frameRate(scene.frameRate_);
  size(500, 500, P3D);
  scene.init();
  setUpGraphics();
}

void draw() {
  scene.update();
  for(Skeleton skeleton:scene.activeSkeletons.values()){
    firstSkeleton = skeleton.indexColor;
    println("ID", skeleton.scene.activeSkeletons.values());
    println("UD", skeleton.scene.activeSkeletons.size());
    
    minHeight = (skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2;
    maxHeight = ((skeleton.bones[14].measuredLength+skeleton.bones[18].measuredLength)/2)+((skeleton.bones[13].measuredLength+skeleton.bones[17].measuredLength)/2)+skeleton.bones[0].measuredLength+skeleton.bones[1].measuredLength+skeleton.bones[2].measuredLength+skeleton.bones[3].measuredLength+((skeleton.bones[6].measuredLength+skeleton.bones[10].measuredLength)/2);//+((skeleton.bones[7].measuredLength+skeleton.bones[11].measuredLength)/2);
    if(scene.floor.isCalibrated){
      
      this.normPosRight = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_RIGHT].estimatedPosition);
      this.normPosRight.x = map(this.normPosRight.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
      this.normPosRight.y = map(this.normPosRight.y,maxHeight,minHeight,-height/2,height/2);
      if(skeleton.rightHandRondDuBras.activatedDirectionCode != 0){coder = skeleton.rightHandRondDuBras.activatedDirectionCode;}
      system.addParticles(this.normPosRight,coder,1/*map(this.normPos.y,-height/2, height/2,0,1)*/);
    
      this.normPosLeft = skeleton.scene.floor.toFloorCoordinateSystem(skeleton.joints[HAND_LEFT].estimatedPosition);
      this.normPosLeft.x = map(this.normPosLeft.x,(-scene.floor.dimensions.x)/2,(scene.floor.dimensions.x)/2,-width/2,width/2);
      this.normPosLeft.y = map(this.normPosLeft.y,maxHeight,minHeight,-height/2,height/2);
      if(skeleton.leftHandRondDuBras.activatedDirectionCode != 0){codel = skeleton.leftHandRondDuBras.activatedDirectionCode;}
      system1.addParticles(this.normPosLeft,codel,1/*map(this.normPos.y,-height/2, height/2,0,1)*/);
      println("\nmao x",this.normPosLeft.x,"\nmao y", this.normPosLeft.y);
      if(skeleton.leftHandPollock.activationDirectionCode != 0 ){
        println("\npollock direction x",skeleton.leftHandPollock.headToHandDirection.x,"\npollock direction y",skeleton.leftHandPollock.headToHandDirection.y);
        break;
      }
    }
  }
  if(scene.drawScene){
    scene.draw(); // measuredSkeletons, jointOrientation, boneRelativeOrientation, handRadius, handStates
    firstTime = true;
  } else{
    //if(firstTime) background(color(128));
    // Your animation algorithm should be placed here
    
    beginCamera();
    camera();
    translate(0,0,0);
    rotateX(0);
    rotateY(0);
    endCamera();
    drawBackground();
    translate(width/2, height/2,0);
    
    if (firstDraw) { // annoying bug in Processin which is giving different width and height in setup method
      mixer = createGraphics(width, height, P2D);
      mixer.noStroke();
      mixerShader.set("mixer", mixer);
      firstDraw = false;
      return;
    }
    
    updateMotionBlur();
    mixer.beginDraw();
    mixer.shader(mixerShader);
    //mixer.rect(0, 0, width/2, height/2);
    mixer.resetShader();
    mixer.noStroke();
  
    mixer.endDraw();

    image(mixer, 0, 0);
    
    system1.update();
    system.update();
  }
  
  //communication.sendScene(scene);
}

void setUpGraphics() {
  noStroke();
  mixerShader = loadShader("mixer.frag");
}


/*color desaturate(color col, float factor) {
  float sat = saturation(col) * factor;
  return color(
    hue(col),
    sat,
    brightness(col)
  );
}*/
void updateMotionBlur(){
  float motionBlurFactor = map(maxHeight,height * 2, height * 10, 0, 1);
  motionBlurFactor = constrain(motionBlurFactor,0,1);
  mixerShader.set("motionBlurFactor",motionBlurFactor);
}
void drawBackground(){
  if (MOTION_BLUR) {
    // Background with motion blur
    noStroke();
    fill(255,45);
    rect(0, 0, width, height);
  } else {
    // Normal background
    noStroke();
    background(255);
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
    if(key == '1') codel = 2;
    if(key == '2') codel = -2;
    if(key == '3') codel = 3;
    if(key == '4') codel = -3;
    if(key == '7') coder = 2;
    if(key == '8') coder = -2;
    if(key == '9') coder = 3;
    if(key == '0') coder = -3;
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
    system.addParticles(new PVector (-mouseX, -mouseY),codel,1/*map(this.normPos.y,-height/2, height/2,0,1)*/);
    
    system1.addParticles(new PVector (mouseX, mouseY),coder,1/*map(this.normPos.y,-height/2, height/2,0,1)*/);
    
    
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
