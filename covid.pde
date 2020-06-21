import processing.video.*;
import java.util.Collections;
Movie leading, transit1, transit2, transit3, ending; 
Animation animation1;


PImage title, gameover, gamewin, gameresult, startNormal, startHovered, restartNormal, restartHovered;
PImage manHide, manJump, manSpray, manRun1, manRun2, credit;
PImage gamewin1, gameover1, gamewin2, gameover2, gamewin3, gameover3, next, next_h;
PImage bg1, bg2, bg3, life, alcohol, hand, leadingstop, transit1stop, transit2stop, transit3stop;
PImage bigVirus, play, play_h, mask;
//PImage[] animals;
PImage[] virus, sickPeoples;
PFont font;

final int GAME_START = 0, GAME_1 = 1, GAME_2 = 2, GAME_3 = 3, GAME_WIN = 4, GAME_OVER = 5, GAME_TRANSIT1 = 6, GAME_TRANSIT2 = 7, GAME_TRANSIT0 = 8, GAME_TRANSIT3 = 9;
final int GAME_INIT = 10, GAME_GAME1WIN = 11, GAME_GAME1LOSE = 12, GAME_GAME2WIN = 13, GAME_GAME2LOSE = 14,GAME_GAME3WIN = 15, GAME_GAME3LOSE = 16;
int gameState = 2;

final int ROUND_1 = 1, ROUND_2 = 2, ROUND_3 = 3;
int round = 1;



final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;


final int GAME_INIT_TIMER = 7200;
int gameTimer = 0;

float bgx,bgy;
float speed = 5;
final float CLOCK_BONUS_SECONDS = 15f;

boolean leftState = false;
boolean rightState = false;
boolean upState = false;
boolean spaceState = false;
boolean hurtState = false;
boolean readanimal1, readanimal2, readanimal3, inited1, inited2, inited3, inited4, play1 = false;
boolean ended, ended0, ended1, ended2, ended3, ended4;
boolean maskcount = false;
int i = 0, sickamount = 0;
Newspicture news;
sickanimal animals;
Player player;
sickpeople[] sick;
bigbigvirus corona;
int[] num;
int count, masknum = 3;
float newX = 0;

ArrayList<Newspicture> newspictures;
ArrayList<sickanimal>animals0,animals1,animals2,animals3;




void setup() {
	size(640, 481, P2D);
	frameRate(60);
	bg1 = loadImage("img/GAME_1_T.png");
	bg2 = loadImage("img/GAME_2.png");
	bg3 = loadImage("img/GAME_3.png");
	title = loadImage("img/GAME_start.png");
	gamewin1 = loadImage("img/GAME_clear_1.png");
	gameover1 = loadImage("img/GAME_1_gameover.png");
	gamewin2 = loadImage("img/GAME_clear_2.png");
	gameover2 = loadImage("img/GAME_2_gameover.png");
	gamewin3 = loadImage("img/GAME_clear_3.png");
	gameover3 = loadImage("img/GAME_3_gameover.png");
	credit = loadImage("img/credit.png");
	startNormal = loadImage("img/button.png");
	startHovered = loadImage("img/button_2.png");
	restartNormal = loadImage("img/again.png");
	restartHovered = loadImage("img/again_2.png");
	next = loadImage("img/next.png");
	next_h = loadImage("img/next_2.png");
	manHide = loadImage("img/people/hide.png");
	manJump = loadImage("img/people/jump.png");
	manRun1 = loadImage("img/people/run1.png");
	manRun2 = loadImage("img/people/run2.png");
	mask = loadImage("img/mask.png");
	life = loadImage("img/heart.png");
	alcohol = loadImage("img/people/alcohol.png");
	hand = loadImage("img/hand.png");
	play = loadImage("data/Play.png");
	play_h = loadImage("data/Play_H.png");
	leadingstop = loadImage("data/leadingstop.png");
	transit1stop = loadImage("data/transit1stop.jpg");
	transit2stop = loadImage("data/transit2stop.jpg");
	transit3stop = loadImage("data/transit3stop.jpg");
	bigVirus = loadImage("img/virus/_corona.png");


	font = createFont("font/font.ttf", 56);
	textFont(font);


	sickPeoples = new PImage[2];
	for(int i = 0; i < sickPeoples.length; i++){
		sickPeoples[i] = loadImage("img/people/cough" + i + ".png");
	}

	// Load leading
	leading = new Movie(this, "leading.mp4"){
    @ Override public void eosEvent() {
      super.eosEvent();
      ended0 = true;
    }
  };

	// Load transit1
	transit1 = new Movie(this, "transit1.mp4"){
    @ Override public void eosEvent() {
      super.eosEvent();
      ended1 = true;
    }
  };


	// Load transit2
	transit2 = new Movie(this, "transit2.mp4"){
    @ Override public void eosEvent() {
      super.eosEvent();
      ended2 = true;
    }
  };

	// Load transit3
	transit3 = new Movie(this, "transit3.mp4"){
    @ Override public void eosEvent() {
      super.eosEvent();
      ended3 = true;
    }
  };
	
	ending = new Movie(this, "ending.mp4"){
    @ Override public void eosEvent() {
      super.eosEvent();
      ended4 = true;
    }
  };

	

	newspictures = new ArrayList<Newspicture>();
	readnews();
	Collections.shuffle(newspictures);

	animals0 = new ArrayList<sickanimal>();
	animals1 = new ArrayList<sickanimal>();
	animals2 = new ArrayList<sickanimal>();
	animals3 = new ArrayList<sickanimal>();

	leading.play();

	// Initialize player
	player = new Player();
	corona = new bigbigvirus(550,100);
	sick = new sickpeople [10];
	num = new int[10];
	

	for(int i = 0; i < sick.length; i++){
		newX = 500*(i*4 + floor(random(2)));
		sick[i] = new sickpeople(newX,200);
		num[i] = floor(random(2));
		//println(num[i]);
	}

	animation1 = new Animation("run", 60);
	count = sick.length;
	
}




void draw(){

	switch(gameState){
		case GAME_INIT:
		image(title,0,0,640,481);
		image(startNormal,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(startHovered,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				gameState = GAME_START;
				mousePressed = false;							
			}
		}

		
		break;

		case GAME_START:
		
		if (!ended0){
			image(leading,0,0);
			
		}else{ //movie must be finished
					transit1.play();
					gameState = GAME_TRANSIT0;
		}
		break;

		case GAME_TRANSIT0:
		
		if (!ended1){
			image(transit1,0,0);
			
		}else{ //movie must be finished
			image(transit1stop,0,0,640,481);
			image(play,480,30,116,60);
			if(isMouseHit(480,30,116,60)){
				image(play_h,480,30,116,60);
				if(mousePressed == true){
					
					gameState = GAME_1;
					mousePressed = false;
					
					
				}
			}
		}
		break;		

		case GAME_1:
		switch(round){
			case ROUND_1:
			if(inited1 == false){
				initGametime1();
			}
			
			background(bg1);
			if(readanimal1 == false){
				readanimals(2);
				readsickanimals(1);
				animals1 = animals0;
				readanimal1 = true;
				Collections.shuffle(animals1);
				sickamount = 1;
			}
			// println(animals1.size());
			// println("s0"+animals0.size());
			for(int i = 0; i<3; i++){
				animals = animals1.get(i);
				animals.display(180+i*150,240,150,150);
				animals.checksick(180+i*150,240,150,150);
				if(animals.sickminus == true){
					sickamount --;
					animals.sickminus = false;
				}
				if(sickamount == 0){
					round = ROUND_2;
				}
			}
			image(hand,mouseX,mouseY,121,121);
			gametimeui();
			if(gameTimer == 0){
				gameState = GAME_GAME1LOSE;
				inited1 = false;
			}						
		

			break;

			case ROUND_2:
			if(inited2 == false){
				initGametime2();
			}			

			background(bg1);
			if(readanimal2 == false){
				animals0.clear();
				readanimals(3);
				readsickanimals(2);
				animals2 = animals0;
				readanimal2 = true;
				Collections.shuffle(animals2);
				sickamount = 2;
			}	

			// println(animals1.size());
			// println("s0"+animals0.size());
			// println("s2"+animals2.size());
			// println("s3"+animals3.size());
			for(int i = 0; i<5; i++){
				animals = animals2.get(i);
				animals.display(100+i*110,240,121,121);
				animals.checksick(100+i*110,240,121,121);
				//println(isMouseHit(100+i*110,240,121,121));
				//println("num"+ i + animals.sick);
				//println(mouseX+","+mouseY);
				if(animals.sickminus == true){
					sickamount --;
					animals.sickminus = false;
				}
				if(sickamount == 0){
					round = ROUND_3;
				}
			}
			image(hand,mouseX,mouseY,121,121);			
			gametimeui();
			if(gameTimer == 0){
				gameState = GAME_GAME1LOSE;
				inited2 = false;
			}

			break;

			case ROUND_3:
			if(inited3 == false){
				initGametime3();
			}
			background(bg1);
			if(readanimal3 == false){
				animals0.clear();
				readanimals(7);
				readsickanimals(3);
				animals3 = animals0;
				readanimal3 = true;
				Collections.shuffle(animals3);
				sickamount = 3;
			}
			for(int i = 0; i<10; i++){
				animals = animals3.get(i);
				if(i<5){
					animals.display(90+i*120,210,100,100);
					animals.checksick(90+i*120,210,100,100);
				}else{
					animals.display(90+(i-5)*120,320,100,100);
					animals.checksick(90+(i-5)*120,320,100,100);
				}
				if(animals.sickminus == true){
					sickamount --;
					animals.sickminus = false;
				}
				if(sickamount == 0){
					
					gameState = GAME_GAME1WIN;	
				}
				
				
			}
			image(hand,mouseX,mouseY,100,100);
			gametimeui();
			if(gameTimer == 0){
				gameState = GAME_GAME1LOSE;
				inited3 = false;
			}				

			break;
		}


		break;

		case GAME_GAME1WIN:
		imageMode(CORNER);
		image(gamewin1,0,0,640,481);
		image(next,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(next_h,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				transit2.play();
				gameState = GAME_TRANSIT1;
				mousePressed = false;							
			}
		}
		break;

		case GAME_GAME1LOSE:
		imageMode(CORNER);
		image(gameover1,0,0,640,481);
		image(restartNormal,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(restartHovered,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				gameState = GAME_1;
				mousePressed = false;							
			}
		}
		break;

		case GAME_TRANSIT1:
		imageMode(CORNER);
		if (!ended2){
			image(transit2,0,0);
		}else{ //movie must be finished
			image(transit2stop,0,0,640,481);
			image(play,480,30,116,60);
			if(isMouseHit(480,30,116,60)){
				image(play_h,480,30,116,60);
				if(mousePressed == true){
					
					gameState = GAME_2;
					mousePressed = false;
				}
			}
		}

		break;

		case GAME_2:
		background(bg2);
			if(inited4 == false){
				initGametime4();
			}		
		//line(width/2, 0, width/2, height);
		noStroke();
		if( mouseX < width/2 && mouseX > 0){
			fill(255,50);
			rect(0, 0, width/2, height);
		} else if( mouseX > width/2 && mouseX <width){
			fill(255,50);
			rect(width/2, 0, width, height);
		}
		news = newspictures.get(i);
		news.display();
		maskcount = false;
		news.mouseDragged();
		if(mouseX < 100 && mouseY > 190 && mouseY <290 && news.added == false){
			if(mousePressed == true && news.torf == true){
				// if(maskcount == false){
				// 	masknum--;
				// 	maskcount = true;
				// }
				
				// news.x = news.y = 1000;
				// news.added = true;
				// mouseX = width/2;
				// mouseY = height/2;
				// i++;
			}else if(mousePressed == true && news.torf == false){
				news.x = news.y = 1000;
				news.added = true;
				mouseX = width/2;
				mouseY = height/2;
				i++;
			}
		}
		if(mouseX > 480 && mouseY > 190 && mouseY <290 && news.added == false){
			if(mousePressed == true && news.torf == false){
				// if(maskcount == false){
				// 	masknum--;
				// 	maskcount = true;
				// }
				
				// news.x = news.y = 1000;
				// news.added = true;
				// mouseX = width/2;
				// mouseY = height/2;
				// i++;
			}else if(mousePressed == true && news.torf == true){
				news.x = news.y = 1000;
				news.added = true;
				mouseX = width/2;
				mouseY = height/2;
				i++;
				
			}
		}
		gametimeui();
		// for(int i = 0; i < masknum; i++){
		// 	image(mask, 10 + i * 70, 10);
		// }
		if(gameTimer == 0){
			gameState = GAME_GAME2LOSE;
			inited4 = false;
		}

		//println("num"+ i + news.torf);
		if(i == 12){
			
			gameState = GAME_GAME2WIN;			
		}		
		// println(news.added);
		break;

		case GAME_GAME2WIN:
		imageMode(CORNER);
		image(gamewin2,0,0,640,481);
		image(next,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(next_h,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				transit3.play();
				gameState = GAME_TRANSIT2;
				mousePressed = false;							
			}
		}
		break;

		case GAME_GAME2LOSE:
		imageMode(CORNER);
		image(gameover2,0,0,640,481);
		image(restartNormal,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(restartHovered,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				gameState = GAME_2;
				mousePressed = false;							
			}
		}
		break;

		case GAME_TRANSIT2:
		imageMode(CORNER);
		if (!ended3){
			image(transit3,0,0);
		}else{ //movie must be finished
			image(transit3stop,0,0,640,481);
			image(play,480,30,116,60);
			if(isMouseHit(480,30,116,60)){
				image(play_h,480,30,116,60);
				if(mousePressed == true){
					
					gameState = GAME_3;
					mousePressed = false;
				}
			}
		}

		break;
		
	
		case GAME_3:
		imageMode(CORNER);
		image(bg3, bgx, 0);
		image(bg3, bgx + bg3.width, 0);
		bgx -= speed;
		if(bgx < -bg3.width){
			bgx = 0;
		}
		

		player.update();
		count = 0;
		//sickpeople
		for(int i = 0; i < sick.length; i++){
			if(sick[i] == null)continue;
			sick[i].update();
			sick[i].display(num[i]);
			sick[i].checkCollision(player);
		}
		for(int i = 0; i < player.health; i++){
			image(life, 10 + i * 70, 10);
		}
		fill(255);
		textAlign(LEFT, BOTTOM);
		text("Last  " + count + "  cough people", 10, height);
		if(count == 0){
			speed = 0;
			corona.display();
			corona.update();
			corona.checkCollision(player);
			// ending.play();
			// gameState = GAME_WIN;
		}

		break;

		case GAME_GAME3WIN:
		image(gamewin3,0,0,640,481);
		image(next,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(next_h,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				ending.play();
				gameState = GAME_WIN;
				mousePressed = false;							
			}
		}
		break;

		case GAME_GAME3LOSE:
		image(gameover3,0,0,640,481);
		image(restartNormal,width/2-71,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(restartHovered,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				gameState = GAME_3;
				mousePressed = false;							
			}
		}
		break;

		case GAME_WIN:
		if (!ended4){
			image(ending,0,0);
		}else{ //movie must be finished
			image(credit,0,0,640,480);
			
		image(restartNormal,width/2-72,height/2+100,142,142);
		if(isMouseHit(width/2-72,height/2+100,142,142)){
			image(restartHovered,width/2-72,height/2+100,142,142);
			if(mousePressed == true){
				gameState = GAME_INIT;
				mousePressed = false;							
			}
		}
		}
	//		image(ending,0,0);
		break;

		case GAME_OVER:
		background(#000000);
		text("you dead",width/2,height/2);
		break;



	}
	

	
}


void addTime(float seconds){
	gameTimer += round(seconds * 60);
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh){
	return	ax + aw > bx &&    // a right edge past b left
		    ax < bx + bw &&    // a left edge past b right
		    ay + ah > by &&    // a top edge past b bottom
		    ay < by + bh;
}

void gametimeui(){
	// Time UI
	textAlign(LEFT, BOTTOM);
	String timeString = convertFrameToTimeString(gameTimer);
	fill(0, 120);
	text(timeString, 10, height + 3);
	fill(getTimeTextColor(gameTimer));
	text(timeString, 10, height);

	gameTimer --;
	//if(gameTimer <= 0) gameState = GAME_OVER;
}

boolean isMouseHit(float bx, float by, float bw, float bh){
	return	mouseX > bx && 
		    mouseX < bx + bw && 
		    mouseY > by && 
		    mouseY < by + bh;
}

color getTimeTextColor(int frames){
	if(frames >= 7200){
		return #00ffff;
	}else if(frames >= 3600){
		return #ffffff;
	}else if(frames >= 1800){
		return #ffffff;
	}else if(frames >= 180){
		return #ff6600;
	}

	return #ff0000;
}

String convertFrameToTimeString(int frames){
	String result = "";
	float totalSeconds = float(frames) / 60;
	result += nf(floor(totalSeconds/60), 2);
	result += ":";
	result += nf(floor(totalSeconds%60), 2);
	return result;
}


void keyPressed(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = true;
			break;
			case RIGHT:
			rightState = true;
			break;
			case UP:
			upState = true;
			break;
		}
	}else if(key == 'r'){
		gameState = GAME_OVER;
	}else if(key == ' '){
		spaceState = true;
	}
}

void keyReleased(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = false;
			break;
			case RIGHT:
			rightState = false;
			break;
			case UP:
			upState = false;
			break;
		}
	}else if(key == ' '){
		spaceState = false;
	}
}

void readanimals(int num){
	for(int i = 0; i<num ; i++)
	 {
		sickanimal H; 	
    	H = new sickanimal();
		int pick = floor(random(6)); 
	 	H.readAnimal(pick);
	 	animals0.add(H);
	 }
}

void readsickanimals(int num){
	for(int i = 0; i<num ; i++)
	 {
		sickanimal S; 	
    	S = new sickanimal();
		int pick = floor(random(num));
	 	S.readSickAnimal(pick);
	 	animals0.add(S);
	 }
}

void readnews(){
	for(int i = 0; i<6 ; i++)
	 {
		Newspicture T; 	
    	T = new Newspicture();
	 	T.readtrueImg(i);
	 	newspictures.add(T);
	 }

	for(int i = 0; i<6 ; i++)
	 {
    	Newspicture F;
	 	F = new Newspicture();
	 	F.readfalseImg(i);
	 	newspictures.add(F);
	 }	
}

void initGametime1(){

	gameTimer = 300;
	inited1 = true;
}
void initGametime2(){

	gameTimer = 300;
	inited2 = true;
}
void initGametime3(){

	gameTimer = 300;
	inited3 = true;
}

void initGametime4(){

	gameTimer = 6000;
	inited4 = true;
}

//check video all read
void movieEvent(Movie m){
	m.read();
}
void myEoS() {
  ended = true;
  //frameRate(1);
}
