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
  final int REQUEST = 1;
  final int RESET = 2;
  int mode = WAITING;



  void act() {
    if (mode == WAITING) waiting();
    else if (mode == REQUEST) request();
    else if (mode == RESET) reset();
  }

  void waiting() {
    setStatic(true);
    //player.getX() <= getX()+3*gridSize || player.getX() >= getX()-3*gridSize &&
    if (abs(getY()-player.getY()) <= 50) {
      mode = REQUEST;
    }
  }

  void request() {
    fill(white);
    textSize(30);
    text("get a potion", width/2, 170);
    mode = RESET;
  }

  void reset() {
    
  }
}
