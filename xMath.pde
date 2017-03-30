public class xMath
{
   public xMath() {}
 
   public float derivative(float tnow, float tprev, float fnow, float fprev)
   {
     return (fnow-fprev)/(tnow-tprev);
   }
   
   public Vec2 lerp(float tnow, float tmax, Vec2 start, Vec2 end)
   {
     return start.add(end.sub(start).mul(tnow/tmax));
   }
   
   public float lerp(float tnow, float tmax, float start, float end)
   {
     return start + (end-start) * tnow/tmax;
   }
   
   public float max(float... v)
   {
     float max = v[0];
     for (int k = 1; k < v.length; k++)
     {
       if (v[k] > max)
         max = v[k];
     }
     return max;
   }
  
   public float min(float... v)
   {
     float min = v[0];
     for (int k = 1; k < v.length; k++)
     {
       if (v[k] < min)
         min = v[k];
     }
     return min;
   }
}