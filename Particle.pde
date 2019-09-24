public class Particle
{
  //private float BOUNCE = -0.5;
  private float MAX_SPEED = 0.1;
  
  private PVector vel = new PVector(random(-MAX_SPEED, MAX_SPEED), random(-MAX_SPEED, MAX_SPEED));
  private PVector acc = new PVector(0, 0);
  private PVector pos;
  
  private float mass = random(2, 2.5);
  private float size = random(0.1, 2.0);
  private int lifespan = 90;
  private color cor;
  
  public Particle(PVector p, color cor){
    this.pos = new PVector (p.x, p.y);
    this.acc = new PVector (random(0.1, 1.5), 0);
    this.cor = cor;
    
    
  }
  
  public void move(){
    this.vel.add(acc); // Apply acceleration
    this.pos.add(vel); // Apply our speed vector
    this.acc.mult(0);
    
    this.size += 0.01; //0.015
    this.lifespan--;
  }
  
  private void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    this.acc.add(f);
  }
  
  private void display(){
  
    
    noStroke();
    //fill(constrain(abs(this.vel.y) * 100, 0, 255), constrain(abs(this.vel.x) * 100, 0, 255), b, lifespan);
    /*if(this.lifespan > 20){
      //fill(this.cor,(pow(this.lifespan,2))*0.23);
      mixer.fill(this.cor,this.lifespan*3);
    }
    if(this.lifespan < 20){
      //fill(this.cor,(30*log(this.lifespan)));
      mixer.fill(this.cor,this.lifespan);
    }*/
    ellipse(this.pos.x, this.pos.y, this.size * 4, this.size * 4);
    /*
    
    mixer.ellipse(this.pos.x,this.pos.y,this.size*4,this.size*4);*/
    fill(this.cor,this.lifespan);
    
  }
  
  private boolean isDead(){
    if (this.lifespan < 2) {
      return true;
    } else {
      return false;
    }
  }
}
