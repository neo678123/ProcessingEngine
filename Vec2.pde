public class Vec2
{
  public float x, y;
 
  public Vec2(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
 
  public float sqrmag() { return x*x+y*y;}
  public float mag() { return sqrt(sqrmag()); }
 
  public Vec2  add(Vec2 v) { return new Vec2(x+v.x, y+v.y); }
  public Vec2  sub(Vec2 v) { return new Vec2(x-v.x, y-v.y); }
  public Vec2  mul(float s){ return new Vec2(x*s, y*s); }
  public Vec2  div(float s){ return new Vec2(x/s, y/s); }
  
  public float dot(Vec2 v) { return x*v.x+y*v.y; }
  public float distance(Vec2 v)
  {
    Vec2 u = new Vec2(x-v.x, y-v.y);
    return u.mag();
  }
  
  public Vec2 normalized()
  {
    float m = mag();
    return new Vec2(x / m, y / m);
  }
  
  public Vec2 reflect(Vec2 normal)
  {
    return this.sub(normal.mul(2 * this.dot(normal)));
  }
  
  public Vec2 transform(float m11, float m12, float m21, float m22)
  {
     return new Vec2(m11*x + m12*y, m21*x + m22*y); 
  }
}