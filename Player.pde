class Player {
	
	float x, y;
	float w = 170, h = 170;
	
	final float PLAYER_INIT_X = 30;
	final float PLAYER_INIT_Y = 200;

	int health = 2;
	final int PLAYER_MAX_HEALTH = 5;

	int moveDirection = 0;
	int moveTimer = 0;
	int moveDuration = 15;
	final int SPACE = 32;
	final int hurt = 358;

	void update(){
		PImage manDisplay = manJump;
		//println(health);
		// println("X"+x);
		// println("Y"+y);
		//animation1.display(30, 200,170,170);

		// If player is not moving, we have to decide what player has to do next
		if(moveTimer == 0){
		

				if(spaceState){

					manDisplay = alcohol;
					moveDirection = SPACE;
					moveTimer = moveDuration;
					x = 30;
					y = 230;
						
				

				}else if(upState){

					manDisplay = manJump;
					moveDirection = UP;
					moveTimer = moveDuration;
					x = 30;
					y = 30;

				}else if(hurtState){
					manDisplay = manHide;
					moveDirection = hurt;
					moveTimer = moveDuration;
					x = 30;
					y = 230;
				}
			

		}else{
			// Draw image before moving to prevent offset
			switch(moveDirection){
				case SPACE:	manDisplay = alcohol;	break;
				case UP:	manDisplay = manJump;	break;
				case hurt:	manDisplay = manHide;	break;
			}
		}

		if(keyPressed == false && moveTimer == 0){
			x = PLAYER_INIT_X;
			y = PLAYER_INIT_Y;
			animation1.display(x, y,w,h);
		}else{
			image(manDisplay, x, y, w, h);
		}
		
		

		// If player is now moving?

		if(moveTimer > 0){

			moveTimer --;
			switch(moveDirection){

				case UP:
				manDisplay = manJump;
				break;

				case SPACE:
				manDisplay = alcohol;
				break;

				case hurt:
				manDisplay = manHide;
				speed = 0;
				if(moveTimer <= 1){
					speed = 5;
					count--;
					hurtState = false;
				}
				break; 
			}

		}

	}
		//animation1.display(30, 200,170,170);
	

	void hurt(){
		health --;

		if(health == 0){

			gameState = GAME_OVER;

		}else{

			hurtState = true;
			
			// moveTimer = moveDuration;
			// for(int i = 0; i < moveDuration; i++){
			// 	if(moveTimer > 0){
			// 		image(manHide, x, y, 170, 170);
			// 		speed = 0;
			// 	}
			// 	if(moveTimer == 0){
			// 		animation1.display(30, 200,170,170);
			// 		speed = 5;
			// 	}
			// 	moveTimer--;
			// }
			

		}
	}

	Player(){
		 health = 3;
		 x = PLAYER_INIT_X;
		 y = PLAYER_INIT_Y;
		// col = (int) x / SOIL_SIZE;
		// // row = (int) y / SOIL_SIZE;
		moveTimer = 0;
	}

}
