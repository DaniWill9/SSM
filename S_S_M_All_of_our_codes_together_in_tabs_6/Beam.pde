float xSpeed,xSpeed2,hSpeed,hSpeed2,beamDistance,playerX,playerY,playerW,playerH;
boolean shoot,offScreen, hit;

void setup(){
  size(500,300);
  playerX=250;
  playerY=width/2;
  playerW=50;
  playerH=50;
  shoot=true;
  offScreen=false;
  hit=false;
rectMode(CENTER);
xSpeed=250;
xSpeed2=250;
hSpeed=150;
hSpeed2=150;
beamDistance=100;

}

void draw(){
  background(100);
  rect(playerX,playerY,playerW,playerH);

  if(keyCode==UP){
playerY=playerY+1;}

println(mouseX,mouseY,xSpeed);
noStroke();

fill(0);

if(shoot==true){

rect(xSpeed,150,10,3);
xSpeed=xSpeed+1;
rect(xSpeed2,150,10,3);
xSpeed2=xSpeed2-1;
rect(250,hSpeed,3,10);
hSpeed=hSpeed+1;
rect(250,hSpeed2,3,10);
hSpeed2=hSpeed2-1;
fill(150);
rect(width/2,height/2,30,50);
rect(width/2,height/2,50,30);
if(xSpeed>=width-beamDistance){
beam();
}
}

//if(hit==false){
  //Left beam collision
if (xSpeed2 + 5 > playerX - playerW/2 && xSpeed2 - 5 < playerX + playerW/2 && 150 > playerY - playerH/2 && 150 < playerY + playerH/2) {
  
  hit=true;

} //right beam collision
//if (xSpeed2 - 5 > playerX + playerW/2 && xSpeed2 + 5 < playerX - playerW/2 && 150 > playerY + playerH/2 && 150 < playerY - playerH/2) {
//{hit=true;}}

if(hit==true){
playerX=0;
playerY=0;
hit=false;
}
else{hit=false;}
}
void beam(){
 xSpeed=250;
xSpeed2=250;
hSpeed=150;
hSpeed2=150;
}

//Ziggy
class Beam{

float xSpeed,xSpeed2,hSpeed,hSpeed2;
//boolean hit;

void update(){

xSpeed=xSpeed++;
xSpeed2=xSpeed2--;
hSpeed=hSpeed++;
hSpeed2=hSpeed2--;
}

void display(){
  
  //rect(playerX,playerY,playerW,playerH);
rect(width/2,height/2,30,50);
rect(width/2,height/2,50,30);
}



void beam(){
xSpeed=250;
xSpeed2=250;
hSpeed=150;
hSpeed2=150;
}
}



 //for (int i = 0; i<100; i++) {
 //   rect(250,xSpeed,3,10);
 //   xSpeed=xSpeed+1;
 // }
