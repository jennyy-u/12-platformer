class FPlayer extends FGameObject {

  int frame;
  int direct;
  int lives = 5;


  FPlayer() {
    super();
    frame = 0;
    direct = R;
    setPosition(150, 0);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }

  void act() {
    input();
    collisions();
    animate();
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direct == R) attachImage(action[frame]);
      if (direct == L)attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void input() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (abs(vy) < 0.1) { //absolute value
      action = idle;
    }
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direct = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direct = R;
    }
    if (wkey) setVelocity(vx, -200);
    if (skey) setVelocity(vx, 200);
    if (abs(vy) > 0.1) {
      action = jump;
    }
  }

  void collisions() {
    if (isTouching("spike")) {
      setPosition(150, 0);
    }
  }
}
