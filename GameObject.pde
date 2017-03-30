public class GameObject
{
   public String name;
   
   public Vec2 position, velocity, acceleration; //s, s', s''
   
   public float w, h, mass;
   public float rotation, angularvel;
   
   public int layer;
  
   //(mass = 0) == (mass = \infty)
   public GameObject(String name, Vec2 position, float w, float h, float mass, float rotation, int layer)
   {
      this.name = name;
      this.position = position;
      this.w = w;
      this.h = h;
      this.mass = mass;
      this.rotation = rotation;
      this.layer = layer;
      
      velocity = acceleration = new Vec2(0,0);
      angularvel = 0;
   }
   
   public GameObject(String name, Vec2 position, float w, float h)
   {
      this.name = name;
      this.position = position;
      this.w = w;
      this.h = h;
      this.mass = 1;
      this.rotation = 0;
      this.layer = 0;
      
      velocity = acceleration = new Vec2(0,0);
      angularvel = 0;
   }
   
   public void physics(float drag, float grav)
   {
     this.addForce(new Vec2(0, 18*mass*grav)); 
     this.addForce(velocity.mul(-drag)); 
   }
   
   public void update(float dt)
   {
      velocity = velocity.add(acceleration.mul(dt));
      position = position.add(velocity.mul(dt));
      
      rotation += angularvel * dt;
      
      acceleration = new Vec2(0,0);
   }
   
   public BoundBox getBox()
   {
     return new BoundBox(position, rotation, w, h);
   }
   
   public void handleCollision(GameObject G)
   {
    Vec2 v = new Collision().collision(getBox(),G.getBox());
    
    if(v.sqrmag() > 0 && mass * G.mass != 0)
    {
      //ik veronderstel hier dat b stilstaat
      //a.translate(v.div(2));
        position =    position.add(v.mul(mass/(mass+G.mass)));
      G.position =  G.position.sub(v.mul(G.mass/(mass+G.mass)));
      //acceleration = new Vec2(0,0);
      
      //G.addForce
      
      velocity = G.velocity = velocity.mul(mass/(mass+G.mass));
    }
    else if(v.sqrmag() > 0 && G.mass == 0)
    {
      position = position.add(v.mul(1.15f));
      //velocity = new Vec2(velocity.x,0);
      //if(v.y > v.x)
      //  velocity.y /= 4;
      //else if(v.x > v.y)
      //  velocity.x /= 4;
    }
   }
   
   public void addForce(Vec2 F) { this.acceleration = this.acceleration.add(F.div(mass)); }
}