class Interval 
{
  float min, max;
  public Interval(float min, float max)
  {
   this.min = min;
   this.max = max;
  }
  
  public boolean overlapsWith(Interval i2){  return !doNotOverlap(i2);}
  
  public float length() { return max - min; }
  
  public float computeOverlapWith(Interval i2) { return computeOverlap(i2); }
  
  public boolean contains(Interval i2) {  return min <= i2.min && i2.max <= max;}
  
  private boolean doNotOverlap(Interval i2) {
    return max <= i2.min || i2.max <= min;
  }
  private float computeOverlap(Interval i2) {
    
    if (doNotOverlap(i2))
      return 0.0f;
    
    if (contains(i2))
      return i2.length();
      
    if (i2.contains(this))
      return length();
      
    if (min < i2.min)
      return max - i2.min;
      
    return i2.max - min;
    
  }
}