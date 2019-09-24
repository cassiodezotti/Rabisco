


public class ParticleSystem{
  private color endColor;
  private  color startColor;

  private ArrayList<Particle> particles = new ArrayList<Particle>();
  
  public void update(){
    Iterator<Particle> i = particles.iterator();

    while (i.hasNext()) {
      Particle p = i.next();
      
      // Remove any particles outside of the screen
      if (p.pos.x > width /*|| p.pos.x < 0*/) {
        i.remove();
        continue;
      } else if (p.pos.y > height /*|| p.pos.y < 0*/) {
        i.remove();
        continue;
      }
      
      // Apply gravity
      p.applyForce(PVector.random2D());
      
      // Move particle position
      p.move();
      
      // Remove dead particles
      if (p.isDead()) {
        i.remove();  
      } else {
        p.display();
      }
      
    }
  }
  public void addParticles(PVector position, int id, float sat) {
  
  if(id == 9){this.startColor = color(0,0,0);this.endColor = color(255,255,255);}
  else if(id == 2){this.startColor = red;this.endColor = blu;}
  else if(id == -2){this.startColor = pink;this.endColor = yellow;}
  else if(id == 3){this.startColor = blue;this.endColor = green;}
  else if(id == -3){this.startColor = purple;this.endColor = orange;}
  //else {this.startColor = this.endColor;this.endColor = this.startColor;}
  
  for (int i = 0; i < numberOfParticles; i++) {
    
    float amount = random(1);
    color col = lerpColor(this.startColor, this.endColor, amount);
    //col = desaturate(col, sat);
    system.particles.add(new Particle(new PVector(position.x-0.2*i,position.y-0.2*i), col));
  }
  }
  }
