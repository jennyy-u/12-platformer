class FHammerBro extends FGameObject {

  int direct = L;
  int speed = 50;
  int frame = 0;
  int time = 120;

  int timeH = 60;
  float directH;
  PVector loca;
  PVector velo;
  

  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hammerbro");
    setRotatable(false);
  }

  void makeHammer() {
    hammer = new FBox(5, 5);
    hammer.setPosition(getX(), getY()-40);
    hammer.attachImage(hammerImg);
    hammer.setVelocity(random(-100, 100), random(-100, 100));
    hammer.setAngularVelocity(random(100));
    hammer.setSensor(true);
    world.add(hammer);
  }


  void act() {
    animate();
    collide();
    move();
    throwHammers();
    collideH();
    time--;
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direct == R) attachImage(hammerbro[frame]);
      if (direct == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }

  void collide() {
    if (time <= 0) {
      direct *= -1; //acts as a switch
      setPosition(getX() + direct, getY()); //gets off the wall
      time = 120;
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.lives--;
        player.setPosition(150, 0);
      }
    }
  }

  void collideH() {
    /*if (hammer.isTouching("player")) {
      player.lives--;
      player.setPosition(150, 0);
    }*/
  }


  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direct, vy);
  }

  void throwHammers() {
    timeH--;
    if (timeH <= 0) {
      makeHammer();
      println("h");
      timeH = 60;
    }
  }
}
