public class Camera
{
   Vec2 translation;
   float scale;
   float rotation;
   
   public Camera(Vec2 T, float S, float R)
   {
      translation = T;
      scale = S;
      rotation = R;
   }
   
   public void applyTransform() //Tr1
   {
      translate(width/2, height/2);
      scale(scale);
      translate(translation.x, translation.y);
      rotate(rotation);
      translate(-width/2, -height/2);

   }
   
   /*   R(S(v+u)+T)-u
   public Vec2 transform(Vec2 v)
   {
     float c = cos(rotation); float s = sin(rotation);
     Vec2 u = new Vec2(width/2, height/2);
     
     return v.add(u).transform(scale, 0, 0, scale).add(translation).transform(c, -s, s, c).sub(u);
   }*/
   
   //   SiRi(v-u)+u-T
   public Vec2 invTransform(Vec2 v)
   {
     float c = cos(rotation); float s = sin(rotation);
     Vec2 u = new Vec2(width/2, height/2);
     
     return v.sub(u).transform(c, -s, s, c).transform(1f/scale, 0, 0, 1f/scale).add(u).sub(translation);
   }
   
   public void applyInverseTransform() //Tr2
   {   
      translate(width/2, height/2);
      rotate(-rotation);
      translate(-translation.x, -translation.y);   
      scale(1.0f/scale);
      translate(-width/2, -height/2);

   }
}
