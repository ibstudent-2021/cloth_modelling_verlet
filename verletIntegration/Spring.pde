class Spring extends VerletSpring2D{

  Spring(Particle a, Particle b) {
    super(a, b, w, 1.5);
  }
  
  void display() {
    stroke(255);
    strokeWeight(1);
    line(a.x, a.y, b.x, b.y);
  }
}
