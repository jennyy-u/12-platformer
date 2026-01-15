class FThwomp extends FGameObject {

  float startX;
  float startY;
  int time = 120;

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
    startX = getX();
    startY = getY();
  }

  //thwomp mode framework
  final int WAITING = 0;
  final int FALLING = 1;
  final int RESET = 2;
  int mode = WAITING;


  void act() {
    attachImage(thwomp[0]);
    if (mode == WAITING) waiting();
    else if (mode == FALLING) falling();
    else if (mode == RESET) reset();

    //collision
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(150, 0);
    }
  }

  void waiting() {
    setStatic(true);
    if (player.getX() > getX() && player.getX() < getX()+gridSize &&
      player.getY() > getY() && player.getY() < getY()+6*gridSize) {
      println(startX, startY);
      mode = FALLING;
    }
  }

  void falling() {
    attachImage(thwomp[1]);
    setStatic(false);
    println(getY(), startY+ 4*gridSize);
    if (getY() >= startY+ 4*gridSize) {
      mode = RESET;
    }
  }


  void reset() {
    
    time--;
    if (time <= 0) {
      setPosition(startX, startY);
      mode = WAITING;
      time = 120;
    }
  }
}
