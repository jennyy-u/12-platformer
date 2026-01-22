class FPotion extends FGameObject {

  FPotion(float x, float y) {
    super();
    setPosition(x, y);
    setName("potion");
    attachImage(potionImg);
    setStatic(true);
  }

  void act() {

    if (isTouching("player")) {
      fill(white);
      textSize(30);
      text("task completed :)", width/2, 170);
      //enemies.removeFromWorld;
    }
  }
}
