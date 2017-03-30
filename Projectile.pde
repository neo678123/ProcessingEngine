class Projectile extends GameObjectSprite
{
  private float time, maxtime;
  public boolean ded;
  
  public Projectile(String name, Vec2 position, float w, float h, float mass, float rotation, int layer, String filename, float maxtime)
  {
      super(name, position, w, h, mass, rotation, layer, filename);
      time = 0;
      this.maxtime = maxtime;
  }
  
  public void update(float dt)
  {
    super.update(dt);
    if(time >= maxtime)
      ded = true;
      
    time += dt;
  }
  
  public void kill()
  {
    ded = true; 
  }
}