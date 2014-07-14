import ddf.minim.*;

PImage img;

Minim minim;
AudioSample kick;
AudioSample snare;

float x = 0;
float y = 10;
float xball, yball;
float rx, lx;
float come, r;
int Length = 100;
int i = 0;
float[] yplate = new float[Length];
float[] xplate = new float[Length];
float[] xscore = new float[Length];
float[] yscore = new float[Length];
float[] ymove = new float[Length];
float[] col = new float[Length];
float[] scale = new float[Length];
int[] combo = new int[Length];
int objX, objY; 
int alph;
int score, start;
int myCombo = 0;
int pcombo = 0;

void setup(){
  size(320, 568);
  smooth();
  noStroke();
  textSize(18);
  minim = new Minim(this);
  kick = minim.loadSample("poli.wav", 2048);
  img = loadImage("chara.png");
}
 
void draw(){ 
  background(255);
  drawRect(); //bar generate
  drawPoint(); //score count
  if( keyPressed && keyCode == RIGHT ) {
   rx = rx + 0.2; 
   x += rx * 1.05;
   if( rx > 3 ){
    rx = 3;
   }
 }else if( keyPressed && keyCode == LEFT ) {
   lx = lx + 0.2;
   x -= lx * 1.05;
   if( lx > 3 ){
    lx = 3;
   }
 }else if( keyPressed == false ){
   rx = rx - 0.2;
   lx = lx - 0.2;
   if(rx < 0){
     rx = 0;
   }
   if(lx < 0){
     lx = 0;
   }
   x += rx * 0.8;
   x -= lx * 0.8;  
 }
 if(yball > height + r || yball < 10){
   String g = "GAME OVER";
   text(g, width/2, height/2);
   fill(0, 0, 0, alph);
   rect(0, 0, width, height);
   start = 0;
 }
 drawBall();
 for(int i = 0; i < Length - 1; i++){
   if(yball > yplate[i] + 5 && yball < yplate[i] + 20 && xball > xplate[i] && xball < xplate[i] + scale[i]){
     y -= 7;
     if(yscore[i] == 0){
       myCombo = combo[i];
       if(myCombo == 0){
         score += 1;
         kick.trigger();
       }else if(myCombo > 0){
         if(combo[i] == 1){
           if(myCombo == 1){
             pcombo += 1;
             score += sq(pcombo);
             kick.trigger();
           }else if(myCombo == 2){
             myCombo = 2;
             pcombo = 1;
             score += 1;
             kick.trigger();
           }
         }else if(combo[i] == 2){
           if(myCombo == 2){
             pcombo += 1;
             score += sq(pcombo);
             kick.trigger();
           }else if(myCombo == 1){
             myCombo = 1;
             pcombo = 1;
             score += 1;
             kick.trigger();
           }
         }
       }
     }
     yscore[i] -= 10;
   }
 }
 if(start == 1){
   y += 4;
 }
}

void drawBall(){
  xball = x + width/2;
  yball = y;
  r = 30;
  fill(100);
  ellipse(xball, yball, r, r);
  image(img, xball - r, yball - r);
}

void drawRect(){
  for(int i = 0; i < Length - 1; i++){
    
    if(yplate[i] > 0){
      if(xplate[i] == 0){
        xplate[i] = random(width - 90);
        col[i] = random(100);
        scale[i] = random(20, 90);
      }
      yplate[i] = height - ymove[i];
      
      if(col[i] < 50){
        fill(0, 200, 100);
        combo[i] = 1;
      }else if(col[i] >= 50){
        fill(220, 90, 0);
        combo[i] = 2;
      }
      rect(xplate[i], yplate[i] + 20, scale[i], 10);
      line(xplate[i], yplate[i] + 20 + yscore[i], xplate[i] + scale[i], yplate[i] + 20 + yscore[i]);
      ymove[i] += 3;
      
      come = random(200, 400);
      
      if(yplate[i+1] == 0 && yplate[i] < come){
        yplate[i+1] = 1;
      }
    }
  }
}

void drawPoint(){ //score ccount
  String s = "SCORE";
  alph = 120;
  fill(0, 0, 0, alph);
  text(s, 200, 30);
  text(score, 280, 30);
  text(myCombo, 110, 110);
}

void mousePressed( ) {
  yplate[i] = 1;
  start = 1;
}

void stop() { //sound system shutdown
  kick.close();
  minim.stop();

  super.stop();
}
