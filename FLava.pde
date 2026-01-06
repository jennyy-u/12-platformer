class FLava extends FGameObject {

  int numFrames;
  int speed;
  int currentFrame;

  FLava(int n, int s, float x, float y) {
    super();

    numFrames = n;
    speed = s;
    currentFrame = 1;
    setPosition(x, y);
    setName("lava");
    attachImage(lava[0]);
  }


  void act() {
    animate();
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(150, 0);
    }
  }

  void animate() {
    if (currentFrame >= numFrames) currentFrame = 0;
    attachImage(lava[currentFrame]);
    currentFrame++;
  }
}
