class FSwitchBlock extends FGameObject {

  FSwitchBlock(float x, float y) {
    super();
    setPosition(x, y);
    setName("switchblock");
    attachImage(switchblockImg);
    setStatic(true);
  }

  void act() {
    if (isTouching("player")) {
      
      
      
    }
  }
}
