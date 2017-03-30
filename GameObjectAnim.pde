class GameObjectAnim extends GameObject
{
   String filename;
   //PGraphics sprite;
   PImage sprite;
   int animW, animH;
   float X, Y;
   float time;
  
   public GameObjectAnim(String name, Vec2 position, float w, float h, float mass, float rotation, int layer, String filename, int animW, int animH)
   {
      super(name, position, w, h, mass, rotation, layer);
      this.filename = filename;
      
      //sprite = createGraphics((int)w/animH, (int)h/animW, P2D);
      sprite = loadImage(filename);
      //((PGraphicsOpenGL)sprite).textureSampling(POINT);
      
      //sprite.beginDraw();
      //sprite.image(loadImage(filename), 0, 0);
      //sprite.endDraw();
      
      this.animW = animW;
      this.animH = animH;
      X = Y = 0;
      time = 0;
   }
   
   public void update(float dt)
   {
      super.update(dt);
      
      if(time < 1/1f)
        time += dt;
      else
      {
        nextIndex();
        time = 0;
      }
   }
   
   public void nextIndex()
   {
      //println(X + ", " + (X + 1f/animW));
      //println(Y + ", " + (Y + 1f/animH));
     
      if(X < 1 - 1f/animW)
      {
         X+=1f/animW; return; 
      }
      
      if(Y < 1 - 1f/animH)
      {
         Y+=1f/animH; X = 0; return; 
      }
      
      X = Y = 0;
   }
   
   public void draw()
   {   
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation);
      
      //noStroke(); noFill();
      beginShape();
      texture(sprite);

      vertex(-w/2, -h/2, X, Y);
      vertex( w/2, -h/2, X + 1f/animW, Y);
      vertex( w/2,  h/2, X + 1f/animW, Y+ 1f/animH);
      vertex(-w/2,  h/2, X, Y + 1f/animH);
      
      /*vertex(-w/2, -h/2, 0, 0);
      vertex( w/2, -h/2, 1, 0);
      vertex( w/2,  h/2, 1, 1);
      vertex(-w/2,  h/2, 0, 1);*/
      
      endShape();

      popMatrix();
   }
}