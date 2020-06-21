class Newspicture{
  
  PImage news;
  float x, y;
  boolean torf;
  float easing;
  boolean added;
  
  void readtrueImg(int num){
    news = loadImage("img/news0/real_" + (num+1) + ".png");
    torf = true;
    added = false;
  }

  void readfalseImg(int num){
    news = loadImage("img/news1/fake_" + (num+1) + ".png");
    torf = false;
    added = false;
  }
  
  void display(){
    imageMode(CENTER);
    image(news, x, y, 200, 200);
  }

  void mouseDragged(){
    x += (mouseX-x) * easing;
    y += (mouseY-y) * easing;
  }

  Newspicture(){
    easing = 0.08;
    x = width/2;
    y = height/2;
  }
  

}
