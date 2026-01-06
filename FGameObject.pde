class FGameObject extends FBox {
  
  final int L = -1;
  final int R = 1;
  
  FGameObject() {
    super(gridSize, gridSize) ;
  }


  void act() {
  }

  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        player.lives--;
        return true; //if spike, back to starting
      }
    }
    return false;
  }
}
