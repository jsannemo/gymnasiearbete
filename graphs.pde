void setup(){
	size(800, 300);
	frameRate(60);
}

int items = 6;

color[] colors = {#407EF1, #31ED2B, #FFF712, #FF122E, #B412FF, #12FFFF};

PFont arial = loadFont("Arial");

boolean[][] inSet = {
	{true, true},
	{false, false},
	{false, true},
	{true, false},
	{false, false},
	{false, false}
};

void drawSets(){
	fill(0);
	textFont(arial, 30);
	text("A", 60, 30);
	text("B", 100, 30);
	for(int i = 0; i < items; i++){
		fill(colors[i]);
		ellipse(30, 60 + i * 40, 15, 15);
		for(int j = 0; j < 2; j++){
			if(inSet[i][j]){
				cs[j]++];
				fill(0);
			} else {
				fill(255);
			}
			rect(62 + 40 * j, 52 + i * 40, 15, 15);
		}
	}
	textFont(arial, 15);
}

int[] cs = {0, 0};

void drawSet(int i){
	stroke(0);
	fill(255);
	ellipse(200 + 70*i, 60, 60, 60);

	fill(0);
	text(i == 0 ? "A" : "B", 195 + 70*i, 20);
	for(int i = 0; i < colors; i++){

	}
}

void drawIntersection(){
	fill(0);
	text("A ∩ B", 370, 20);
	stroke(0);
	fill(255, 0);
	ellipse(370, 60, 60, 60);
	ellipse(410, 60, 60, 60);
}

void drawUnion(){
	fill(0);
	text("A ∪ B", 510, 20);
	stroke(0);
	fill(255, 0);
	ellipse(510, 60, 60, 60);
	ellipse(550, 60, 60, 60);
}

// Main draw loop
void draw(){
	background( 255 );
	drawSets();
	drawSet(0);
	drawSet(1);
	drawIntersection();
	drawUnion();
}

void mouseClicked(){
	for(int i = 0; i < items; i++){
		for(int j = 0; j < 2; j++){
			int cx = 62 + 7 + 40 * j;
			int cy = 52 + 7 + 40 * i;
			int dx = cx - mouseX;
			int dy = cy - mouseY;
			if(sqrt(dx*dx + dy*dy) < 8){
				inSet[i][j] = !inSet[i][j];
			}
		}
	}
}