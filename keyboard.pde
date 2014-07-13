float x = 0;
float y = 0;
float xball, yball;
float rx, lx;
int Length = 100;
int i = 0;
float[] yplate = new float[Length];
float[] xplate = new float[Length];
float[] xscore = new float[Length];
float[] yscore = new float[Length];
float[] ymove = new float[Length];
int objX, objY; 
int alph;
int score;
int start;

void setup(){
  size(320, 568);
  smooth();
  noStroke();
}
 
void draw(){ 
  background(255);
  drawRect();
  drawPoint();
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
 drawBall();
 for(int i = 0; i < Length - 1; i++){
   if(yball > yplate[i] + 10 && yball < yplate[i] + 40 && xball > xplate[i] && xball < xplate[i] + 80){
     y -= 5;
     if(yscore[i] == 0){
       score += 1;
     }
     yscore[i] -= 10;
   }
 }
 if(start == 1){
   y += 3;
 }
}

void drawBall(){
  xball = x + width/2;
  yball = y;
  ellipse( xball, yball, 20, 20);
}

void drawRect(){
  for(int i = 0; i < Length - 1; i++){
    if(yplate[i] > 0){
      if(xplate[i] == 0){
        xplate[i] = random(width - 50);
      }
      yplate[i] = height - ymove[i];
      rect(xplate[i], yplate[i] + 20, 80, 10);
      line(xplate[i], yplate[i] + 20 + yscore[i], xplate[i] + 50, yplate[i] + 20 + yscore[i]);
      ymove[i] += 2;
      
      if(yplate[i+1] == 0 && yplate[i] < 300){
        yplate[i+1] = 1;
      }
    }
  }
}

void drawPoint(){
  String s = "SCORE";
  alph = 120;
  fill(0, 0, 0, alph);
  text(s, 200, 30);
  text(score, 250, 30);
}

void mousePressed( ) {
  yplate[i] = 1;
  start = 1;
}
