class bigbigvirus extends sickpeople {

    int virusspeed = 2;
    int w = 250, h = 250;

	void checkCollision(Player player){

		if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
            // println("X"+x);
		    // println("Y"+y);
            // println("playerX"+player.x);
		    // println("playerY"+player.y);
            if(spaceState == false){
                player.hurt();
                isAlive = false;
                gameState = GAME_GAME3LOSE;
                x = 100000;
                y = 10000;
                
            
                
            }else{
                isAlive = false;
                x = 100000;
                y = 10000;
                gameState = GAME_GAME3WIN;
                
                
            }
			

		}
	}

	void display(){
        if(isAlive == true){

			image(bigVirus, x, y, w, h);
		    
            
        }
        
    }
	void update(){
        x -= virusspeed;
        // println("mun"+i+"X"+x);
		// println("Y"+y);


    }
	//void detectPlayer(Player player){}

	bigbigvirus(float x, float y){
		super(x,y);
	}
}
