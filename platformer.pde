import fisica.*;

//jenny yu
//block 1-4
//december 1, 2025

FWorld world;

//colors
color white = color(255, 255, 255);
color sky = color(144, 213, 255);          //background
color black = color(0, 0, 0);              //ground
color grey = color(127, 127, 127);         //walls for enemies
 
color indigo = color(63, 72, 204);         //hammerbro
color purple = color(163, 73, 164);        //thwomp
color pink = color(255, 174, 201);         //goomba

color lpurple = color (200, 191, 231);     //player starting point
color rpurple = color (107, 63, 160);      //portal
color darkPink = color(255, 128, 192);     //switch block
color greyblue = color(112, 146, 190);     //save point block

color redBrown = color(136, 0, 21);        //collapsing bridge
color orange = color(255, 127, 39);        //spike
color red = color(237, 28, 36);            //lava
color lightblue = color(153, 217, 234);    //ice
color yellow = color(255, 201, 14);        //trampoline
color green = color(34, 177, 76);          //tree
color brown = color(185, 122, 87);         //tree trunk
color darkgreen = color(64, 128, 128);     //NPC




//images
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;

PImage map, map2, brick, trampoline, spike, pic;
PImage treeCenter, treeLeft, treeRight, treeInter, treeTrunk;
PImage ice1, ice2, ice3, ice4;
PImage lava0, lava1, lava2, lava3, lava4, lava5;
PImage bridgeCenter, bridgeLeft, bridgeRight;
PImage portal;
PImage hammerImg;
int gridSize = 32;
float zoom = 1.2;
boolean upkey, downkey, leftkey, rightkey, spacekey, wkey, akey, skey, dkey, qkey, ekey;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;
FNpc npc;

//mode framework
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int mode = INTRO;

void setup() {
  size(600, 600);
  Fisica.init(this);
  terrain = new ArrayList <FGameObject>();
  enemies = new ArrayList <FGameObject>();
  loadPlayer();
  loadImages();
  loadWorld(map);
}

void loadImages() {
  map = loadImage("map.png");
  map2 = loadImage("map2.png");
  brick = loadImage("brick.png");
  trampoline = loadImage("trampoline.png");
  trampoline.resize(gridSize, gridSize);
  treeCenter = loadImage("treetop_center.png");
  treeLeft = loadImage("treetop_left.png");
  treeRight = loadImage("treetop_right.png");
  treeInter = loadImage("tree_intersect.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice1 = loadImage("water1.png");
  ice2 = loadImage("water2.png");
  ice3 = loadImage("water3.png");
  ice4 = loadImage("water4.png");
  spike = loadImage("spike.png");
  bridgeCenter = loadImage("bridge_center.png");
  bridgeLeft = loadImage("bridge_left.png");
  bridgeRight = loadImage("bridge_right.png");
  portal = loadImage("yellowStar.png");
  pic = loadImage("hammerbro1.png");
  hammerImg = loadImage("hammer.png");
  reverseImage(pic).save("hammerbro1.png");

  //load actions
  idle = new PImage [2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  action = idle;

  //enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");

  lava = new PImage[8];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava0.png");
  lava[2] = loadImage("lava0.png");
  lava[3] = loadImage("lava1.png");
  lava[4] = loadImage("lava2.png");
  lava[5] = loadImage("lava3.png");
  lava[6] = loadImage("lava4.png");
  lava[7] = loadImage("lava5.png");
}

void loadPlayer() {
  player = new FPlayer();
  //world.add(player);
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < map.height || y < map2.height; y++) {
    for (int x = 0; x < map.width || x < map2.width; x++) {
      color c = img.get(x, y); //color of current pixel
      color cDown = img.get(x, y+1); //color below current pixel
      color cUp = img.get(x, y-1); //color above
      color cLeft = img.get(x-1, y);
      color cRight = img.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      //brick(ground) block
      if (c == black) {
        b.attachImage(brick);
        //b.setSensor(true); //allows for passing thru, also puts it to the background; still checks for collisions
        b.setFriction(4);
        b.setName("brick");
        world.add(b);
      } else if (c == grey) {
        b.attachImage(brick);
        b.setName("wall");
        world.add(b);
      }
      //player starting point
      else if (c == lpurple) {
        world.add(player);
        player.setPosition(x*gridSize, y*gridSize);
      }
      //trampoline
      else if (c == yellow) {
        b.attachImage(trampoline);
        b.setRestitution(2);
        b.setName("trampoline");
        world.add(b);
      }
      //tree
      else if (c == green && cLeft == green && cRight == green) {
        b.attachImage(treeCenter);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && cLeft == green && cRight == white) {
        b.attachImage(treeRight);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && cRight == green && cLeft == white) {
        b.attachImage(treeLeft);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      }
      if (c == brown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("treetrunk");
        world.add(b);
      } else if (c == green && cDown == brown) {
        b.attachImage(treeInter);
        b.setName("treetrunk");
        world.add(b);
      }
      //ice
      if (c == lightblue && cLeft != lightblue) {
        b.attachImage(ice1);
        b.setName("ice");
        world.add(b);
      } else if (c == lightblue) {
        b.attachImage(ice2);
        b.setName("ice");
        world.add(b);
      } else if (c == lightblue && cRight != lightblue) {
        b.attachImage(ice4);
        b.setName("ice");
        world.add(b);
      }
      //spikes
      else if (c == orange) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      }
      //bridge
      else if (c == redBrown) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      //lava
      else if (c == red) {
        FLava lava = new FLava(5, 20, x*gridSize, y*gridSize);
        terrain.add(lava);
        world.add(lava);
      }
      //goomba
      else if (c == pink) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      }
      //thwomp
      else if (c == purple) {
        FThwomp thmp = new FThwomp(x*gridSize+17, y*gridSize+15);
        enemies.add(thmp);
        world.add(thmp);
      }
      //hammerbro
      else if (c == indigo) {
        FHammerBro hmb = new FHammerBro(x*gridSize, y*gridSize);
        enemies.add(hmb);
        world.add(hmb);
      }
      //portal
      else if (c == rpurple) {
        FPortal portal = new FPortal(x*gridSize, y*gridSize);
        b.setFriction(4);
        terrain.add(portal);
        world.add(portal);
      }
    }
  }
}




void draw() {
  background(sky);

  //modes
  if (mode == INTRO) intro();
  else if (mode == GAME) game();
  else if (mode == PAUSE) pause();
  else if (mode == GAMEOVER) gameover();

  drawWorld();
  actWorld();
  player.act();
}



void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw(); //world.drawDebug();
  popMatrix();
}
