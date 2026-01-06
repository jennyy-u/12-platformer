class FThwomp extends FGameObject {


  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
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
    if (player.getX() > getX() && player.getX() < getX()+gridSize &&
      player.getY() > getY() && player.getY() < getY()+6*gridSize) {
      mode = FALLING;
    }
  }

  void falling() {
    attachImage(thwomp[1]);
    setStatic(false);

    if (getY() >= getY()+ 6*gridSize) {
      mode = RESET;
    }
  }


  void reset() {
    int time = 120;
    time--;
    if (time <= 0) {
      setPosition(getX(), getY()-6*gridSize);
      mode = WAITING;
    }
  }
}
