class ColoredRectangle extends GameObject
{
   int r, g, b;
  
   public ColoredRectangle(String name, Vec2 position, float w, float h, float mass, float rotation, int layer, int r, int g, int b)
   {
      super(name, position, w, h, mass, rotation, layer);
      this.r = r;
      this.g = g;
      this.b = b;
   }
   
   public void draw()
   {
      fill(r,g,b); 
     
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation);
      rect(-w/2, -h/2, w, h); 
      popMatrix();
   }
}