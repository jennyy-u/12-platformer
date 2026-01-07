button startButton;

void intro() {
  background(sky);


  //game title
  fill(white);
  textSize(30);
  text("platformer game", width/2, 170);

  //start button
  startButton = new button("START", width/2, 210, 50, 20, white, sky);
  click();
  startButton.show();
  introClicks();
}

void introClicks() {
  if (startButton.clicked) mode = GAME;
}
