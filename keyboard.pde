float x = 0;
float rx, lx;
int Length = 5;
int i = 0;
int[] yplate = new int[Length];
float[] xplate = new float[Length];
int[] ymove = new int[Length];
int objX, objY; 

void setup() 
{ 
 size(400, 400);
 smooth();
 
  objX = mouseX;    //objX, disXを現在のマウスのx座標で初期化
  objY = mouseY;
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
   if(rx<0){
     rx = 0;
   }
   if(lx<0){
     lx = 0;
   }
   x += rx * 0.8;
   x -= lx * 0.8;
   
 }
 ellipse( x + width/2, height/2, 20, 20);
}

void drawRect(){
  for(int i = 0; i < Length - 1; i++){
    if(yplate[i] > 0){
      if(xplate[i] == 0){
        xplate[i] = random(400);
      }
      yplate[i] = height - ymove[i];
      rect(xplate[i], yplate[i] - 20, 50, 10);
      ymove[i] += 1;
      if(yplate[i+1] == 0 && yplate[i] < 200){
        yplate[i+1] = 1;
      }
    }
  }
}

void drawPoint(){
  String s = "SCORE";
  fill(0);
  text(s, 200, 30);
}

void mousePressed( ) {
  yplate[i] = 1;
}
