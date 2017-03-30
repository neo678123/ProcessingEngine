import processing.sound.*;

Camera c;
float x = 0;

ColoredRectangle C;
GameObjectAnim G;

Player p;
GameObjectSprite spriteCan;
GameObjectSprite[] ground;

SoundFile bgm;

public void setup()
{
  //size(1280, 720, P2D);
  size(1280, 720);
  
  //String name, Vec2 position, float w, float h, float mass, float rotation, int layer, int r, int g, int b
  C = new ColoredRectangle("ding", new Vec2(100, 100), 100, 100, 1, 0.3, 0, 255, 0, 0);
  G = new GameObjectAnim("ding", new Vec2(600, 400), 150, 500, 1, 0.0, 0, "spritesheet.png", 2, 1);
  
  p = new Player("Player", new Vec2(300, 400), 87, 234, 1, 0, 0, "sprite.png");
  
  spriteCan = new GameObjectSprite("can", new Vec2(500, 400), 130, 234, 1.5, 0, 0, "spritecan.png");
  ground = new GameObjectSprite[] {new GameObjectSprite("ground", new Vec2(300, 594), 425, 154, 0, 0, 0, "spritelogo.jpg")
                                  ,new GameObjectSprite("ground", new Vec2(725, 594), 425, 154, 0, 0, 0, "spritelogo.jpg")};
  
  c = new Camera(new Vec2(0,0), 1, 0);
  
  bgm = new SoundFile(this, "memes.mp3");
  bgm.loop();
  
  textureMode(NORMAL);
  smooth(4);
}

public void update()
{
  //c.translation.x = width / 2 * cos(x);
  C.update(1f/60f);
  G.update(1f/60f);  
    
  p.physics(1, 9.81);
  spriteCan.physics(1, 9.81);
  
  p.projectileColliders(spriteCan, ground[0], ground[1]);
  p.handleCollision(spriteCan);
  
  for(GameObjectSprite g : ground){
    p.handleCollision(g);
    spriteCan.handleCollision(g);
    g.update(1f/60f);
  }
  p.update(1f/60f);
  spriteCan.update(1f/60f);

  
  //p.handleCollision(ground[0]);
}

public void draw()
{
   update();
   println(mouseX + " --> " + p.mx);
   
   clear();
   c.applyTransform();
   
   
   C.draw();
   C.rotation += 0.006f;
   G.draw();
   
   p.draw();
   spriteCan.draw();
   for(GameObjectSprite g : ground)
    g.draw();
}

void keyPressed() 
{
  p.keyPress(key);
  
  if(key == 'e')
   c.rotation += 0.01f;
  if(key == 'q')
   c.rotation -= 0.01f;
   
  if(key == '+')
   c.scale *= 1.01f;
  if(key == '-')
   c.scale /= 1.01f;
   
  if (key == CODED) {
    if (keyCode == UP)
      c.translation.y += 5f;
    if (keyCode == DOWN)
       c.translation.y -= 5f;
       
    if (keyCode == LEFT)
      c.translation.x += 5f;
    if (keyCode == RIGHT)
       c.translation.x -= 5f;
  }
}

void mousePressed()
{
  Vec2 v = c.invTransform(new Vec2(mouseX, mouseY));
  p.mx = v.x; p.my = v.y;
  //p.mx = modelX(mouseX, mouseY,0);
  //p.my = modelY(mouseX, mouseY,0);
  p.keyPress((char)0);
}

void keyReleased()
{
  p.keyRelease(key);
}