void setup(){
  size(800, 300);
  frameRate(60);
  for(int i = 0; i < nodes; i++)
	for(int j = 0; j < nodes; j++)
		matrix[i][j] = !matrix[i][j];
	smooth();
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

int[][] nodePositions = {
	{340, 180},
	{320, 50},
	{390, 120},
	{450, 100},
	{250, 220},
	{440, 200},
};

void mouseReleased() {
	lockedFish = -1;
}

int[] aq = {1, 1, 1, 1, 1, 1};

void drawNodes(){
	strokeWeight(1);
	stroke(0);

	for(int i = 0; i < nodes; i++){
		fill(colors[i]);
		int x = nodePositions[i][0];
		int y = nodePositions[i][1];
		ellipse(x, y, 30, 30);
		fill(0);
		text(aq[i], x-3, y+3);
	}
}

void drawEdges(){
	boolean bad = false;
	for(int i = 0; i < nodes; i++)
		for(int j = 0; j < i; j++){
			if(matrix[i][j]){
				if(aq[i] == aq[j]){
					bad = true;
					stroke(#FF122E);
				} else {
					stroke(0);
				}
				line(nodePositions[i][0], nodePositions[i][1], nodePositions[j][0], nodePositions[j][1]);
			}
		}
	if(!bad){
		stroke(0);
		text("Du klarade det!", 100, 100);
	}
}

// Main draw loop
void draw(){
	background( 255 );
	drawEdges();
	drawNodes();
}

void mousePressed() {
	float best = 10000000;
	int which = -1;
	for(int i = 0; i < nodes; i++){
		int dx = mouseX - nodePositions[i][0];
		int dy = mouseY - nodePositions[i][1];
		float dist = sqrt(dx*dx + dy*dy);
		if(dist < best){
			best = dist;
			which = i;
		}
	}
	if(best < 15){
		aq[which]++;
		if(aq[which] == 4) aq[which] = 1;
	}
}

