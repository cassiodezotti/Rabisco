
public class PollockParticle{
  private float px, py;
  private int NUM = 500;
  private color col;
  private float radius;
  private PollockParticle [] particle = new PollockParticle [NUM];
  
public PollockParticle(float x,float y/*, PollockParticles [] particles*/){
    this.px = x;
    this.py = y;
    //this.particle = particles;
  }
  void appear(){
    noStroke();
    fill(this.col);
    ellipse(this.px,this.py,this.radius,this.radius);
  }

void active() {
  
  for(int j = 0; j<5;j++){
    for(int i = 0; i< this.NUM; i++){
      if(this.px < width/2 && this.py <height/2){this.col = color (255,random(0,150),random(0,150));};
      if(this.px > width/2 && this.py <height/2){this.col = color (random(0,150),255,random(0,150));};
      if(this.px < width/2 && this.py >height/2){this.col = color (random(0,150),random(0,150),255);};
      if(this.px > width/2 && this.py > height/2){this.col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-900,900);
     float divY = random(-900,900);
     float distance = sqrt(divX*divX+divY*divY);
     this.radius = 60* exp(-distance*0.03);
     particle[i] = new PollockParticle(this.px+divX, this.py+divY);
     particle[i].appear();
    }
    for(int i = 0; i< NUM; i++){
      if(this.px < width/2 && this.py <height/2){this.col = color (255,random(0,150),random(0,150));};
      if(this.px > width/2 && this.py <height/2){this.col = color (random(0,150),255,random(0,150));};
      if(this.px < width/2 && this.py >height/2){this.col = color (random(0,150),random(0,150),255);};
      if(this.px > width/2 && this.py > height/2){this.col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-600,600);
     float divY = random(-600,600);
     float distance = sqrt(divX*divX+divY*divY);
     this.radius = 60* exp(-distance*0.06);
     particle[i] = new PollockParticle(this.px+divX, this.py+divY);
     particle[i].appear();
    }
    for(int i = 0; i< NUM; i++){
      if(this.px < width/2 && this.py <height/2){this.col = color (255,random(0,150),random(0,150));};
      if(this.px > width/2 && this.py <height/2){this.col = color (random(0,150),255,random(0,150));};
      if(this.px < width/2 && this.py >height/2){this.col = color (random(0,150),random(0,150),255);};
      if(this.px > width/2 && this.py > height/2){this.col = color (random(0,255),random(0,255),random(0,255));};
     float divX = random(-300,300);
     float divY = random(-300,300);
     float distance = sqrt(divX*divX+divY*divY);
     this.radius = 60* exp(-distance*0.12);
     particle[i] = new PollockParticle(this.px+divX, this.py+divY);
     particle[i].appear();
    }
  }
  }
}
