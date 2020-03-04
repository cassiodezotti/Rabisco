import java.util.ArrayList;



  public class Trajectory{
    public ArrayList<PVector> currentPos = new ArrayList<PVector>();
    public ArrayList<PVector> previousPos = new ArrayList<PVector>();
    public ArrayList<PVector> relativeVel = new ArrayList<PVector>();
    public ArrayList<Integer> quadrants = new ArrayList<Integer>();
    public ArrayList<Integer> modes = new ArrayList<Integer>();
    
    
    public Trajectory(PVector cPosition,PVector pPosition, PVector velocity,int quadrant, int mode){
      this.currentPos.add(cPosition); 
      this.previousPos.add(pPosition);
      this.relativeVel.add(velocity);
      this.quadrants.add(quadrant);
      this.modes.add(mode);
      
  }
  private void update(PVector cPosition,PVector pPosition, PVector velocity,int quadrant, int mode){
      this.currentPos.add(cPosition); 
      this.previousPos.add(pPosition);
      this.relativeVel.add(velocity);
      this.quadrants.add(quadrant);
      this.modes.add(mode);
  }
  
}
