class GameObjectSprite extends GameObject
{
   String filename;
   PImage sprite;
  
   public GameObjectSprite(String name, Vec2 position, float w, float h, float mass, float rotation, int layer, String filename)
   {
      super(name, position, w, h, mass, rotation, layer);
      this.filename = filename;
      
      sprite = loadImage(filename);
      textureMode(NORMAL);
   }
   
   public void draw()
   {   
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation);
            
      /*beginShape();
      texture(sprite);
      vertex(-w/2, -h/2, 0, 0);
      vertex( w/2, -h/2, 1, 0);
      vertex( w/2,  h/2, 1, 1);
      vertex(-w/2,  h/2, 0, 1);
      endShape();*/
      
      image(sprite, -w/2, -h/2, w, h);
      
      popMatrix();
   }
}