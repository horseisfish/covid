class sickanimal{
	
    PImage animal;
    boolean sick,sickminus=false;
    boolean isAlive = true;

    void readAnimal(int num){
        animal = loadImage("img/animals/animal0/animal"+num+".png");
		sick = false;
    }

	void readSickAnimal(int num){
        animal = loadImage("img/animals/animal1/animal"+num+".png");
		sick = true;
    }

	void display(int x,int y,int x_size,int y_size){
		if(isAlive == true){
			imageMode(CENTER);
			image(animal, x, y, x_size, y_size);
		}
		
	}

	void checksick(int x,int y,int x_size,int y_size){
		if(isMouseHit(x-x_size/2, y-y_size/2, x_size, y_size) && sick == true && mousePressed == true && isAlive == true){
			isAlive = false;
			//println("you got it");
			//x = y = 1000;
			mousePressed = false;
			sickminus = true;
		}
	}
	

	sickanimal(){
		
	}	    
}
