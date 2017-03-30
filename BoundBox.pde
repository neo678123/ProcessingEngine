class BoundBox
{
   public Vec2 centre;
   public float w, h, angle;
   
   public BoundBox()
   {
     
   }
   
   public BoundBox(Vec2 pos, float angle, float w, float h)
   {
     centre = pos;
     this.angle = angle;
     this.w = w;
     this.h = h;
   }
   
   public Vec2 leftTop()
   {
     return centre.add(new Vec2( sin(angle) * h - cos(angle) * w, 
                                -cos(angle) * h - sin(angle) * w).mul(0.5f)); 
   }
   
   public void update(Vec2 pos, float angle)
   {
     centre = pos;
     this.angle = angle;
   }
   
   public void translate(Vec2 v)
   {
     centre = centre.add(v);
   }
   
   public Vec2[] getVertices()
   {
      float cw = 0.5f * cos(angle) * w;
      float sh = 0.5f * sin(angle) * h;
      float ch = 0.5f * cos(angle) * h;
      float sw = 0.5f * sin(angle) * w;
      return new Vec2[] { centre.add(new Vec2( sh - cw, -ch - sw)),         //Left top
                          centre.add(new Vec2(-sh - cw,  ch - sw)),     //Left bottom
                          centre.add(new Vec2(-sh + cw,  ch + sw)),     //Right bottom
                          centre.add(new Vec2( sh + cw, -ch + sw)) };
   }
   
   
}

final class Collision
{
  public Collision() {}
  
  private Interval projectToInterval(BoundBox a, Vec2 axis)
  {
      Vec2[] vertices = a.getVertices();
    
      float[] D = new float[4];
      for(int k = 0; k < 4; k++)
          D[k] = vertices[k].dot(axis);
    
      return new Interval(min(D), max(D));
  }
  
  public Vec2 collision(BoundBox a, BoundBox b)
  {
    Vec2 out = new Vec2(0,0);
    float overlap = 1E9;
    
    Vec2 smallestAxis = new Vec2(0,0);
    Vec2[] axes = new Vec2[4];
    
    Vec2[] A = a.getVertices();
    Vec2[] B = b.getVertices();
    
    //Waar is mijn operator overloading QQ
    axes[0] = (A[3].sub(A[0])).div(a.w);
    axes[1] = (A[1].sub(A[0])).div(a.h);
    axes[2] = (B[3].sub(B[0])).div(b.w);
    axes[3] = (B[1].sub(B[0])).div(b.h);
    
    for(Vec2 ax : axes)
    {
      Interval proj1 = projectToInterval(a, ax);
      Interval proj2 = projectToInterval(b, ax);
      
      if(proj1.overlapsWith(proj2))
      {
        float o = proj1.computeOverlapWith(proj2);
        if(o < overlap)
        {
          overlap = o;
          smallestAxis = ax;
        }
      } 
      else
        return new Vec2(0,0);
    }
    
    out = smallestAxis.mul(overlap);
    if( a.centre.sub(b.centre).dot(smallestAxis) < 0.0f)
      out = out.sub(out.mul(2));
      
    println(b.w + " " + b.h + " | " + b.centre.x + " " + b.centre.y); 
    println(a.w + " " + a.h + " | " + a.centre.x + " " + a.centre.y); 
    //print(out.x + " " + out.y + "\n");
    return out;      
  }
}