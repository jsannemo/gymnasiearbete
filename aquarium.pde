void setup(){
  size(800, 300);
  frameRate(60);
}

int nodes = 6;

boolean[][] matrix = {
	{true, false, false, true, false, true},
	{false, true, false, false, false, true},
	{false, false, true, false, true, false},
	{true, false, false, true, true, false},
	{false, false, true, true, true, true},
	{true, true, false, false, true, true}
};

color[] colors = {#407EF1, #31ED2B, #FFF712, #FF122E, #B412FF, #12FFFF};

void drawMatrix(){
	strokeWeight(0);
	for(int i = 0; i < nodes; i++){
		fill(colors[i]);
		ellipse(80 + i*30, 50, 15, 15);
	}
	for(int i = 0; i < nodes; i++){
		fill(colors[i]);
		ellipse(50, 80 + i * 30, 15, 15);
	}
	for(int x = 0; x < nodes; x++){
		for(int y = 0; y < nodes; y++){
			if(matrix[x][y]){
				fill(#51FF12);
			} else {
				fill(#FF1212);
			}
			rect(80 + x * 30 - 5, 80 + y * 30 - 5, 10, 10);
		}
	}

}

int[][] fishPositions = {
	{360, 70},
	{440, 70},
	{520, 70},
	{360, 100},
	{440, 100},
	{520, 100},
};

int lockedFish = -1;

void mousePressed() {
	float best = 10000000;
	int which = -1;
	for(int i = 0; i < nodes; i++){
		int dx = mouseX - fishPositions[i][0];
		int dy = mouseY - fishPositions[i][1];
		float dist = sqrt(dx*dx + dy*dy);
		if(dist < best){
			best = dist;
			which = i;
		}
	}
	if(best < 100){
		lockedFish = which;
	} else {
		lockedFish = -1;
	}
	mouseDragged();
}



void mouseDragged() {
  if(lockedFish != -1) {
	  fishPositions[lockedFish][0] = mouseX;
	  fishPositions[lockedFish][1] = mouseY;
  }
}



void mouseReleased() {
	lockedFish = -1;
}

void drawFish(){
	strokeWeight(1);
	stroke(0);

	for(int i = 0; i < nodes; i++){
		fill(colors[i]);
		int x = fishPositions[i][0];
		int y = fishPositions[i][1];
	    arc(x, y, 30, 20, 0, PI);
		arc(x, y, 30, 20, PI, 2*PI);
		arc(x+25, y, 20, 15, 0, PI);
		arc(x+25, y, 20, 15, PI, 2*PI);

		fill(0);

		ellipse(x-6, y-2, 2, 2);
	}
}

void drawTanks(){
	int[] bowls = {-1, -1, -1, -1, -1, -1};
	for(int i = 0; i < nodes; i++){
		for(int j = 0; j < 3; j++){
			int mx = 350 + 150*j;
			int my = 170;
			int rad = 70;
			int dx = mx - fishPositions[i][0];
			int dy = my - fishPositions[i][1];
			float dist = sqrt(dx*dx + dy*dy);
			if(dist <= rad && dy < 0) bowls[i] = j;
		}
	}
	boolean[] ok = {true, true, true};
	for(int i = 0; i < nodes; i++)
		for(int j = 0; j < nodes; j++){
			if(i == j) continue;
			if(matrix[i][j] == false && bowls[i] == bowls[j] && bowls[i] != -1){
				ok[bowls[i]] = false;
			}
		}
	strokeWeight(3);
	stroke(0);
	fill(#4139DB);
	for(int i = 0; i < 3; i++){
		if(ok[i]) stroke(0);
		else stroke(#FF0000);
		arc(350 + 150 * i, 170, 140, 140, 0, PI);
	}
	boolean okk = true;
	for(int i = 0; i < nodes; i++) okk = okk && bowls[i] != -1;
	for(int i = 0; i < 3; i++) okk = okk && ok[i];

	fill(0);
	if(!okk){
		text("Inte klar än...", 400, 40);
	} else {
		text("Grattis!", 400, 40);
	}
}

// Main draw loop
void draw(){
  background( 255 );

  drawMatrix();
  drawTanks();
  drawFish();
}
