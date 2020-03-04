import oscP5.*;
import netP5.*;


OscP5 oscP5;
//NetAddress myBroadcastLocation;




void setup() {
  size(500,500,P3D);
  noStroke();
 frameRate(25);
  oscP5 = new OscP5(this,"239.0.0.1",7777);
  //myBroadcastLocation = new NetAddress("239.0.0.1",1200);
 



}

void draw() {
OscMessage myMessage = new OscMessage("/trajectory");
   float xp = float(pmouseX)/width;
   float yp = float(pmouseY)/height;
   float x = float(mouseX)/width;
   float y = float(mouseY)/height;
   myMessage.add(xp); /* add a float to the osc message */
   myMessage.add(yp); /* add a float to the osc message */
   myMessage.add(x); /* add a float to the osc message */
   myMessage.add(y); /* add a float to the osc message */
   oscP5.send(myMessage); 
}
