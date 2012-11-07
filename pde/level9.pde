// let's do some processing
Hero hero;
Paddle pv1,pv2,ph1,ph2;

boolean movingOn = false;

void setup() {
  size(200, 200);
  background(0);
  strokeWeight(2);
  stroke(180);
  PVector a = new PVector(0, 0);
  
  
  PVector v = new PVector(random(-1.5, 1.5), random(-1.5,1.5));
  PVector l = new PVector(width/2, height/2);
  hero = new Hero(a, v, l);
  rectMode(CENTER);

  ph1 =new Paddle(width/2, 180, 75, 10);
  ph2 =new Paddle(width/2, 20, 75, 10);
  pv1 =new Paddle(20, height/2, 10, 75);
  pv2 =new Paddle(180, height/2, 10, 75);
}

void draw() {
  background(0);
  //float c = -0.23;                            // Drag coefficient
  // PVector heroVel = hero.getVel();              // Velocity of our thing
  //PVector force = PVector.mult(heroVel, c);   // Following the formula
  //hero.applyForce(force);                        // Adding the force to our object, which will ultimately affect its acc
  // Run the Thing object
  if (movingOn== false) {
    hero.makeAppear();
  }
  hero.go();

  pv1.drawMe();
  pv1.updateWy(mouseY);
  if (//hero.loc.x>pv1.xpos-pv1.pwidth/2
   hero.loc.x<pv1.xpos+pv1.pwidth/2
  && hero.loc.y>pv1.ypos-pv1.pheight/2
  && hero.loc.y<pv1.ypos+pv1.pheight/2){
    
    PVector newV = hero.getVel();
	float newY =map(hero.loc.y,pv1.ypos-pv1.pheight/2,pv1.ypos+pv1.pheight/2,-1,1);
	//println(newY);
	newV.y = newY;
    newV.x*=-1;
    hero.setVel(newV);
    
  }
  

  pv2.drawMe();
  pv2.updateWy(map(mouseY, height, 0, 0, height));
  if (hero.loc.x>pv2.xpos-pv2.pwidth/2
  //&& hero.loc.x<pv2.xpos+pv2.pwidth/2
  && hero.loc.y>pv2.ypos-pv2.pheight/2
  && hero.loc.y<pv2.ypos+pv2.pheight/2){
   
    PVector newV = hero.getVel();
	float newY =map(hero.loc.y,pv2.ypos-pv2.pheight/2,pv2.ypos+pv2.pheight/2,-1,1);
	newV.y = newY;
    newV.x*=-1;
    hero.setVel(newV);
    
  }
  

  ph1.drawMe();
  ph1.updateEx(mouseX);
  if (hero.loc.x>ph1.xpos-ph1.pwidth/2
  && hero.loc.x<ph1.xpos+ph1.pwidth/2
  && hero.loc.y>ph1.ypos-ph1.pheight/2
  //&& hero.loc.y<ph1.ypos+ph1.pheight/2
  ){
    
    PVector newV = hero.getVel();
	float newX =map(hero.loc.x,ph1.xpos-ph1.pwidth/2,ph1.xpos+ph1.pwidth/2,-1,1);
	newV.x = newX;
    newV.y*=-1;
    hero.setVel(newV);
    
  }
  
  ph2.drawMe();
  ph2.updateEx(map(mouseX, width, 0, 0, width));
  if (hero.loc.x>ph2.xpos-ph2.pwidth/2
  && hero.loc.x<ph2.xpos+ph2.pwidth/2
  //&& hero.loc.y>ph2.ypos-ph2.pheight/2
  && hero.loc.y<ph2.ypos+ph2.pheight/2){
    PVector newV = hero.getVel();
	// yeah weird collision !
	float newX =map(hero.loc.x,ph2.xpos-ph2.pwidth/2,ph2.xpos+ph2.pwidth/2,-1,1);
	newV.x = newX;
    newV.y*=-1;
    hero.setVel(newV);
  }
  
/*
  if (mousePressed) {
    // Compute difference vector between mouse and object location
    // 3 steps -- (1) Get Mouse Location, (2) Get Difference Vector, (3) Normalize difference vector
    PVector m = new PVector(mouseX, mouseY);
    PVector diff = PVector.sub(m, hero.getLoc());
    diff.normalize();
    float factor = 0.1;  // Magnitude of Acceleration (not increasing it right now)
    diff.mult(factor);
    //object accelerates towards mouse
    hero.setAcc(diff);
  } 
  else {
    hero.setAcc(new PVector(0, 0));
  }*/
  // boundaries
  if (hero.loc.x<5) {
    movingOn = true;
    hero.makeDisappear();
    if (hero.alph<10) {
      popUp(8);
	  closeWindows(9);
    }
  }
  if (hero.loc.y<5) {
    movingOn = true;
    hero.makeDisappear();
    if (hero.alph<10) {
      popUp(3);
	  closeWindows(9);
    }
  }
  if (hero.loc.x>195) {
    movingOn = true;
    hero.makeDisappear();
    if (hero.alph<10) {
     popUp(10);
	 closeWindows(9);
    }
  }
  if (hero.loc.y>195) {
    movingOn = true;
    hero.makeDisappear();
    if (hero.alph<10) {
      popUp(15);
	  closeWindows(9);
    }
  }
}

class Paddle {
  float xpos, ypos, pwidth, pheight;

  Paddle(float xpos0, float ypos0, float pwidth0, float pheight0) {
    xpos = xpos0;
    ypos = ypos0;
    pwidth = pwidth0;
    pheight= pheight0;
  }

  void drawMe() {
    pushMatrix();
    translate(xpos, ypos);
    strokeWeight(1);
    stroke(255);
    fill(255, 180);
    rect(0, 0, pwidth, pheight);
    popMatrix();
  }

  void updateEx(float ex) {
    xpos =constrain(ex, 40, 160);
  }
  void updateWy(float wy) {
    ypos=constrain(wy, 40, 160);
  }
}

class Hero {
  PVector loc;
  PVector vel;
  PVector acc;
  float maxvel;
  float mass;
  // to tween our object
  float diameter =20;
  float sDist;
  float tweenfactor=0;
  float cellS, cellS2;
  // to makeAppear() and makeDisAppear()
  float alph = 0;

  //The Constructor (called when the object is first created)
  Hero(PVector a, PVector v, PVector l) {
    acc = a;
    vel = v;
    loc = l;
    maxvel = 4;
    mass = 20;
  }
  //main function to operate object
  void go() {
    update();  
    render();
  }
  //function to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    //limit speed to max
    if (vel.mag() > maxvel) {
      vel.normalize();
      vel.mult(maxvel);
    }
  }
  //function to display
  void render() {
    strokeWeight(8);
    stroke(220, alph);
    fill(175, alph);
    tween(); // change appearance while moving
    ellipse(loc.x, loc.y, diameter-cellS, diameter+cellS2);
  }
  // transform movement (used in draw)
  void applyForce(PVector force) {
    force.div(mass);   // Newton's second law
    acc.add(force);    // Accumulate acceleration
  }
  //Add functions to our thing object to access the location, velocity and acceleration from outside the class
  PVector getVel() {
    return vel.get();
  }
  PVector getAcc() {
    return acc.get();
  }
  PVector getLoc() {
    return loc.get();
  }
  void setLoc(PVector v) {
    loc = v.get();
  }
  void setVel(PVector v) {
    vel = v.get();
  }
  void setAcc(PVector v) {
    acc = v.get();
  }

  // ou tween function !
  void tween() {
    // distance from mouse
    sDist = dist(mouseX, mouseY, loc.x, loc.y);
    // change tween factor (angle for our wavelet animation)
    if (sDist>75) {
      tweenfactor+=0.3;
    }
    else {
      tweenfactor+= map(sDist, 0, 75, 0.09, 0.25);
    }
    //scale our multiplication factor for our tween effect
    float sMult = map(sDist, 0, 100, 0.09*diameter, .25 * diameter);
    // fill to global variables  to affect the drawing of our ellipse
    cellS = sMult * cos(tweenfactor);
    cellS2 = sMult * (.5 +(cos(tweenfactor)/2));
  }

  // time related functions
  void makeAppear() {
    alph+=10;
    alph = constrain(alph, 0, 180);
  }
  void makeDisappear() {
    alph-=10;
    alph = constrain(alph, 0, 180);
  }


  // collide with paddle
  void collidePaddleV(Paddle myPaddle) {
    if(loc.x>myPaddle.xpos-myPaddle.pwidth/2 
    && loc.x<myPaddle.xpos+myPaddle.pwidth/2
    && loc.y>myPaddle.ypos-myPaddle.pheight/2
    && loc.y<myPaddle.ypos-myPaddle.pheight/2
    ){


    PVector newV = vel;
    newV.y*=-1;
    hero.setVel(newV);
    }
  }


  void collidePaddleH(Paddle myPaddle) {
    if(loc.x>myPaddle.xpos-myPaddle.pwidth/2 
    && loc.x<myPaddle.xpos+myPaddle.pwidth/2
    && loc.y>myPaddle.ypos-myPaddle.pheight/2
    && loc.y<myPaddle.ypos-myPaddle.pheight/2
    ){


    PVector newV = hero.getVel();
    newV.x*=-1;
    hero.setVel(newV);
  }
  }
}
