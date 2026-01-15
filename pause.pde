button unpauseButton;

void pause() {

  background(sky);

  //game title
  fill(white);
  textSize(30);
  text("paused", width/2, 170);

  //start button
  unpauseButton = new button("unpause", width/2, 210, 70, 20, white, sky);
  click();
  unpauseButton.show();
  pauseClicks();
}

void pauseClicks() {
  if (unpauseButton.clicked) mode = GAME;
}
