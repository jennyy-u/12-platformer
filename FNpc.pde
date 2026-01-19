class FNpc extends FGameObject {

  float startX, startY;

  FNpc(float x, float y) {
    super();
    setPosition(x, y);
    attachImage(npcImg);
    setName("npc");
    setRotatable(false);
  }

  //npc modes
  final int WAITING = 0;
  final int INTERACT = 1;
  final int RESET = 2;
  int mode = WAITING;



  void act() {
    if (mode == WAITING) waiting();
    else if (mode == INTERACT) request();
    else if (mode == RESET) reset();
  }

  void waiting() {
    setStatic(true);
    //player.getX() <= getX()+3*gridSize || player.getX() >= getX()-3*gridSize &&
    if (abs(getY()-player.getY()) <= 10) {

      mode = INTERACT;
    }
  }

  void request() {
    text("get this potion for me", width/2, 170);
  }

  void reset() {
  }
}
