import toxi.audio.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*; 
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;



int cols = 40;
int rows = 40;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;



float w = 10;

VerletPhysics2D physics;

void setup() {
  size(600, 600);
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics2D();
  Vec2D gravity = new Vec2D(0, 5);
  GravityBehavior2D gb = new GravityBehavior2D(gravity);
  physics.addBehavior (gb);
  
  float x = 100;
  for (int i = 0; i < cols; i++) {
    float y = 10;
    for (int j = 0; j < rows; j++) {
    Particle p = new Particle(x,y);
    particles[i][j] = p;
    physics.addParticle(p);
    y = y + w;
  }
  x = x + w;
 }  
 
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows-1; j++) {
      Particle a = particles[i][j];
      Particle b1 = particles[i+1][j];
      Particle b2 = particles[i][j+1];
      Spring s1 = new Spring(a, b1);
      springs.add(s1);
      physics.addSpring(s1);
      Spring s2 = new Spring(a, b2);
      springs.add(s2);
      physics.addSpring(s2);
    }
  }
 
  particles[0][0].lock();
  particles[cols-1][0].lock();
}

void draw() {
  background(51);
  physics.update();


 for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
    particles[i][j].display();
    }
 }
  
    for (Spring s : springs) {
   s.display();
  }
}
