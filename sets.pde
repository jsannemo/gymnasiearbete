void setup(){
  size(800, 300);
  frameRate(60);
}

int items = 6;

color[] colors = {#407EF1, #31ED2B, #FFF712, #FF122E, #B412FF, #12FFFF};



// Main draw loop
void draw(){

  background( 255 );

  noFill();
  stroke(170);
  strokeWeight(1);
  rect(0, 0, width-1, height-1);

}
