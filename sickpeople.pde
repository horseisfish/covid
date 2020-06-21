class sickpeople {
	float x, y;
	float w = 170;
	float h = 170;
    boolean isAlive = true;
    boolean counted = false;

	void checkCollision(Player player){

		if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
            // println("X"+x);
		    // println("Y"+y);
            // println("playerX"+player.x);
		    // println("playerY"+player.y);
            if(spaceState == false){
                player.hurt();
                isAlive = false;
                x = 10000;
                y = 10000;
            
                
            }else{
                isAlive = false;
                x = 10000;
                y = 10000;
                if(counted == false){
                    count--;
                    counted = true;
                }
                
            }
			

		}
	}

	void display(int who){
        if(isAlive == true){

			image(sickPeoples[who], x, y, w, h);
		    
            
        }
        
    }
	void update(){
        x -= speed;
        // println("mun"+i+"X"+x);
		// println("Y"+y);
        if(x + w < 0 && counted == false){
            count--;
            counted = true;
        }
    }
	//void detectPlayer(Player player){}

	sickpeople(float x, float y){
		this.x = x;
		this.y = y;
	}
}
