import oscP5.*;
import netP5.*;
  
public class Communication{
  private OscP5 oscP5;
  //private NetAddress pdAddress;
  
  public Communication(String pdIp, int pdPort, int myPort){
    this.oscP5 = new OscP5(this,"239.0.0.1", myPort);
    //this.pdAddress = new NetAddress(pdIp, pdPort); //localhost: "127.0.0.1" "192.168.15.16" // "192.168.15.1"
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

}
