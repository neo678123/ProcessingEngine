class Player extends GameObjectSprite
{
  ArrayList<Projectile> projectiles, deletelist;
  public float mx, my;
  
  public Player(String name, Vec2 position, float w, float h, float mass, float rotation, int layer, String filename)
  {
      super(name, position, w, h, mass, rotation, layer, filename);
      projectiles = new ArrayList<Projectile>();
      deletelist  = new ArrayList<Projectile>();
  }
  
  public void update(float dt)
  {
    super.update(dt);
    
    for(Projectile p : projectiles)
    {
      p.update(dt);
      if(p.ded)
        deletelist.add(p);
    }
    
    for(Projectile p : deletelist)
    {
      for(int j = 0; j < projectiles.size(); j++)
      {
        Projectile x = projectiles.get(j);  
        if(x.equals(p)){
          projectiles.remove(j);
          break;
        }
      }
    }
  }
  
  public void draw()
  {
    super.draw(); 
    
    for(Projectile p : projectiles)
    {
      p.draw();
    }
  }
  
  public void projectileColliders(GameObject... objects)
  {
    for(GameObject o : objects)
    {
      for(Projectile p : projectiles)
      {
          Vec2 v = new Collision().collision(p.getBox(),o.getBox());
          if(v.sqrmag() > 0)
            p.kill();
      }
    }
  }
  
  public void keyPress(char k)
  {
    if(k == 's'){
      velocity.y = 200f;
      //addForce(new Vec2(0, 5000));
    }
    if(k == 'w'){
      velocity.y = -200f;
      //addForce(new Vec2(0, -5000));
    }
    if(k == 'd'){
      velocity.x = 200;
      //addForce(new Vec2(5000, 0));
    }
    if(k == 'a'){
      velocity.x = -200f;
      //addForce(new Vec2(-5000, 0));
    }
    
    if(k == 0)
    {
      //mx = mouseX; my = mouseY;      
      
      float x = mx - position.x;
      float y = my - position.y;
      float theta = atan2(y, x);
      
      
      Projectile p = new Projectile("projectile", position.add(new Vec2(cos(theta), sin(theta)).mul(2)), 44, 20, 1, theta, 0, "sprite1.png", 3);
      p.velocity = new Vec2(mx,my).sub(position).normalized().mul(400);
      projectiles.add(p);
      
      println(projectiles.size());
    }
  }
  
  public void keyRelease(char k)
  {
    if(k == 's'){
      velocity.y = 0;
    }
    if(k == 'w'){
      velocity.y = 0;
    }
    if(k == 'd'){
      velocity.x = 0;
    }
    if(k == 'a'){
      velocity.x = 0;
    }
  }
  
  
}