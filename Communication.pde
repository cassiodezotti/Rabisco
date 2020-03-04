import oscP5.*;
import netP5.*;
  
public class Communication{
  private OscP5 oscP5;
  //private NetAddress pdAddress;
  
  public Communication(String pdIp, int pdPort, int myPort){
    this.oscP5 = new OscP5(this,"239.0.0.1", myPort);
    //this.pdAddress = new NetAddress(pdIp, pdPort); //localhost: "127.0.0.1" "192.168.15.16" // "192.168.15.1"
  }
  
  public void sendScene(Scene scene){
    if(!scene.activeSkeletons.isEmpty()){
      for(Skeleton skeleton:scene.activeSkeletons.values()){
        /*
        this.sendKinectSkeleton(skeleton);
        this.sendGrainParameters(skeleton);
        this.sendVideoParameter(skeleton);
        this.sendSteeringWheel(skeleton);
        */
      }
    }
  }
  
  private void sendTrajectory(PVector current, PVector previous, int face, int orientation, int quadrant){
    
    
     OscMessage messageToPd = new OscMessage("/trajectory");
     messageToPd.add(previous.x);
     messageToPd.add(previous.y);
     messageToPd.add(previous.z);
     messageToPd.add(current.x);
     messageToPd.add(current.y);
     messageToPd.add(current.z);
     messageToPd.add(face);
     messageToPd.add(orientation);
     messageToPd.add(quadrant);
     this.oscP5.send(messageToPd);
  }
  
  private void sendEraser(String check){
    OscMessage messageToPd = new OscMessage("/eraser");
     messageToPd.add(check);
     
     this.oscP5.send(messageToPd);
  }
  
  private void sendChangeFace(String novo,int face){
    OscMessage messageToPd = new OscMessage("/change");
     messageToPd.add(novo);
     messageToPd.add(face);
     
     this.oscP5.send(messageToPd);
  }

  private void sendKinectSkeleton(Skeleton skeleton){ 
    OscMessage messageToPd = new OscMessage("/indexColor:");
    messageToPd.add(skeleton.indexColor);
    this.oscP5.send(messageToPd);
    
    messageToPd = new OscMessage("/handStates:");
    messageToPd.add(skeleton.estimatedHandRadius[0]);
    messageToPd.add(skeleton.estimatedHandRadius[1]);
    this.oscP5.send(messageToPd);
    
    for (int jointType = 0; jointType<25 ; jointType++){
      messageToPd = new OscMessage("/joint" + Integer.toString(jointType) + ":");
      messageToPd.add(skeleton.joints[jointType].trackingState);
      messageToPd.add(skeleton.joints[jointType].estimatedPosition.x);
      messageToPd.add(skeleton.joints[jointType].estimatedPosition.y);
      messageToPd.add(skeleton.joints[jointType].estimatedPosition.z);
      messageToPd.add(skeleton.joints[jointType].estimatedOrientation.real);
      messageToPd.add(skeleton.joints[jointType].estimatedOrientation.vector.x);
      messageToPd.add(skeleton.joints[jointType].estimatedOrientation.vector.y);
      messageToPd.add(skeleton.joints[jointType].estimatedOrientation.vector.z);
      this.oscP5.send(messageToPd);
    }
  }
  
  private void sendGrainParameters(Skeleton skeleton){
    OscMessage messageToPd = new OscMessage("/Ready");
    messageToPd = new OscMessage("/mid_z");
    messageToPd.add(map((skeleton.joints[SPINE_BASE].estimatedPosition.z),0.4,3.5,0,1));
    this.oscP5.send(messageToPd);
    messageToPd = new OscMessage("/hand_left_x");
    messageToPd.add(map((skeleton.joints[HAND_LEFT].estimatedPosition.x),-1.5,1,0,1));
    this.oscP5.send(messageToPd);
    messageToPd = new OscMessage("/hand_left_y");
    messageToPd.add(map((skeleton.joints[HAND_LEFT].estimatedPosition.y),-1.5,1,0,1));
    this.oscP5.send(messageToPd);
    messageToPd = new OscMessage("/hand_right_x");
    messageToPd.add(map((skeleton.joints[HAND_RIGHT].estimatedPosition.x),-1.5,1,0,1));
    this.oscP5.send(messageToPd);
    messageToPd = new OscMessage("/hand_right_y");
    messageToPd.add(map((skeleton.joints[HAND_RIGHT].estimatedPosition.y),-1.5,1,0,1));
    this.oscP5.send(messageToPd);
  }
  
  private void sendVideoParameter(Skeleton skeleton){
    OscMessage messageToPd = new OscMessage("/Ready");  
    this.oscP5.send(messageToPd);
    messageToPd = new OscMessage("/Elastic");
    messageToPd.add((skeleton.distanceBetweenHands));
    this.oscP5.send(messageToPd);
  }
}
