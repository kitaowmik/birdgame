//TODO: add code in order to make the duck have feet that also walk as it animates maybe?

PVector Dloc;
PVector dir;

int x, x2, y1;
float wingRR, wingRL,time;


boolean wingDown = false;
boolean wing2Down = false;

boolean animate = false;
boolean deadCount = false;
boolean deadCount2 = false;
boolean win = false;


  
//code to draw the duck with animation parameters neckR and wingR - other transforms align
//the peices to the correct pivot points
class Fire
{
  ArrayList<Flame> screen;
  PVector location;

  public Fire(PVector loc)
  {
    location = loc.get();
    screen = new ArrayList<Flame>();
  }


  void addFlame()
  {
    for (int i =0; i < 3; i++)
    {
      screen.add(new Flame(new PVector(location.x+locx, location.y+locy)));
    }
  }

  void run()
  {
    for (int i =0; i < screen.size (); i++)
    {
      Flame p = screen.get(i);
      p.run();
      if (p.isDead())
      {
        screen.remove(i);
        i--;
      }
    }
  }
}

class Flame
{

  PVector location, velocity, acceleration, size;
  float lifespan, colorVal;

  Flame(PVector loc)
  {
   colorMode(HSB, 360, 100, 100);
   colorVal =10;
    lifespan = 155.0;
    location = loc.get();
    velocity = new PVector(random(-2,2), random(2,0));
    acceleration = new PVector(0,-0.05);
    size = new PVector(random(5,10), random(5,10));
  }

  void run()
  {
    update();
    drawFlame();
  }
  void update()
  {
    colorMode(HSB,360, 100, 100);
    location.add(velocity);
    velocity.add(acceleration);
    lifespan-=3;
    colorVal -= 1.5;
  }
  void drawFlame()
  {
    noStroke();
    //stroke(colorVal, 100,100,lifespan);
    fill(colorVal, 100, 100, lifespan);
    ellipse(location.x, location.y, size.x, size.y);
  }
  boolean isDead()
  {
    return lifespan<0;
  }
}



void drawCharacter() {
    noStroke();
    
    pushMatrix();
      //move the entire duck
      translate(Dloc.x+320, Dloc.y+440);
      scale(2); //scale the entire duck
    //legs
    fill(#FC8B2E);
    pushMatrix();
        translate(-8,10);//move into draw position
        //rotate(legR1); //animation parameter to control walking
        translate(10,-15); // move to the pivot point
      triangle(-11.5,10,-8.5,20,-14.5,20); //foot1
      //rect(-13,16.3,3,9); //leg1
    popMatrix();
    //the body stuff
    
    pushMatrix();
       translate(3,10); //move into draw position
       //rotate(legR2); //animation parameter to control walking
       translate(1,-15); //move to the pivot point
     triangle(-2.5,10,0.5,20,-5.5,20);//foot2
    //rect(0,16.5,3,9);//leg2
    popMatrix();
      
      fill(#FFFEFC);
      ellipse(-5, 0, 30, 20); //body
      

      
      //draw neck and head with possible animation transforms
      pushMatrix();
        translate(-16, 0); //move back into draw position
        //rotate(neckR);  //rotate by neckR parameter
        translate(16, 0); //move neck and head to pivot point
        ellipse(-6, -9, 7, 15); //neck
        ellipse(-6, -20, 12, 12); //head
        fill(0);
        ellipse(-4, -20.5, 3, 4);  //eye
        ellipse(-8,-20.5,3,4);
        fill(#E58E45);
        triangle(-6, -15, -8, -19, -4, -19); //beak
      popMatrix();
     
      //draw wing with possible animation transforms
      fill(#818181);
      frameRate(100);
      pushMatrix();
         translate(-8, -5); //move into draw position
         rotate(wingRR); //animtion parameter to control wing flap
         translate(14, 0); //move to the pivot point
        ellipse(5, 0, 24, 15); //wing
       popMatrix();
        
      pushMatrix();
        translate(-8,-5);
        rotate(-wingRR);
        translate(14,0);  
        ellipse(-30,0,24,15);
      popMatrix();
        
  popMatrix();
           
}



void bar1() {

  //drawing bar 1
  noStroke();
  fill(#767676);
  rect(x, 400, 100, 70);
  //drawing the spikes
  fill(0);
  triangle(x+100, 400, x+130, 410, x+100, 428);
  triangle(x+100, 420, x+130, 430, x+100, 448);
  triangle(x+100, 440, x+130, 450, x+100, 468);
}

void bar2() {


  //drawing bar2
  noStroke();
  fill(#767676);
  rect(x2, 300, 100, 70);
  //drawing the spikes
  fill(0);
  triangle(x2, 300, x2-30, 310, x2, 328);
  triangle(x2,320, x2-30, 330, x2, 348);
  triangle(x2, 340, x2-30, 350, x2, 368);
}

 
//function to update all animation parameters 
void animate() {
  //update the ducks global location
  Dloc.x = Dloc.x + dir.x*time;
  Dloc.y = Dloc.y + dir.y*time;

  //find out how much the wing is rotated to decide which way to rotate
  //these constrain how much the wing moves up and down
  if (wingRR < -0.5) {
      wingDown = true;
  } 
  if (wingRR > 0.3) {
    wingDown = false;
  }
 
  if (wingDown == false) {
     wingRR -= .03; 
  } else {
    wingRR += .03;
  }
  
    if (wingRL < -0.5) {
      wing2Down = false;
  } 
  if (wingRL > -0.3) {
    wing2Down = true;
  }
 
  if (wing2Down == false) {
     wingRL += .03; 
  } else {
    wingRL -= .03;
  }
}

Fire fi;
float locx, locy;

//normal set up
void setup() {
   size(600, 600);
  smooth();
  x = -100;
  x2 = 600;
  wingRR =-.2;
  wingRL = .2;
  Dloc = new PVector(width*.001, height/110);
  dir = new PVector(-1, 0);
  fi = new Fire(new PVector(width/2, 330));
  time =0.5;
  locx = 8;
  locy = 90;
  textFont(createFont("Georgia", 36));
  
}

//normal draw
void draw() {
  
background(#81D6FF);
   fill(#E8C877);
  rect(0, 400, width, height/2);

  println(mouseX, mouseY);
  println(Dloc.x, Dloc.y);
  println(frameCount);

   if (x < 600) {
      x++;
    bar1();
    }
    
  
 if (Dloc.y <= -120) { 
   if (x2 > 0) {
  
      x2--;
  
      bar2();
    }
 }
  
  

  drawCharacter();
  if (animate) {
    animate();
  }
  if (x >= 200 && Dloc.y >= -20.0 && Dloc.y <= 20.0) {
  fi.addFlame();
  fi.run();
  deadCount = true;
 }

 
 if (Dloc.y <= -100.0 && Dloc.y >= -140.0 && x2 <=300) {
 
   locy=-50;
   fi.addFlame();
   fi.run(); 
  
  deadCount2 = true; 
}


if (deadCount == true && frameCount > 500) {
background(0);
noStroke();
fill(128);
ellipse(300,300,200,200);
rect(200,300,200,250);
fill(0);
textSize(40);
text("R.I.P", 252, 300);
  }
  
if (deadCount2 == true && frameCount > 1000) {
background(0);
noStroke();
fill(128);
ellipse(300,300,200,200);
rect(200,300,200,250);
fill(0);
textSize(40);
text("R.I.P", 252, 300);
  }

}



//method to control starting the duck over again and control animation on and off

void keyPressed() {
  time =0;
  if (key == 'u' || key == 'U') {
   if(Dloc.y > -410) {
    Dloc.y--;
   }
    animate = !animate;
  }
}
