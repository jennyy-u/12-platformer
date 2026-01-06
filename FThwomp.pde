class FThwomp extends FGameObject {


  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
  }


  void act() {
    attachImage(thwomp[0]);
    detect();
    fall();
    reset();

    if (isTouching("player")) {
      player.lives--;
      player.setPosition(150, 0);
    }
  }
  
  void detect() {
    
    
  }

  void fall() {
    /*if (player.x == thwomp.x) {
      attachImage(thwomp[1]);
      setStatic(false);
    }
    */
  }
  
  void reset() {
  }
}

//waiting, falling, reset - modes for thwomp
//rectangle falling x-gridSize, y, x+gridSize, y+?
