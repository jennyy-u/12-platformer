class FHammerBro extends FGameObject {
  
  
  int direct = L;
  int speed = 50;
  int frame = 0;
  int time = 120;


  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
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

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direct, vy);
  }
  
  
}
