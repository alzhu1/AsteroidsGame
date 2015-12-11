//your variable declarations here
SpaceShip bob = new SpaceShip();
ArrayList <Asteroid> terry;
ArrayList <Bullet> bang;
Star jeff[];
int roat = 0;
double accel = 0;
int deathCount = 0;
int score = 0;
int highScore = 0;
int powerFill = 0;
boolean powerUp = false;
public void setup() 
{
  //your code here
  size(500,500);
  jeff = new Star[300];
  terry = new ArrayList <Asteroid>();
  bang = new ArrayList <Bullet>();
  for(int i=0; i<jeff.length; i++)
  {
    jeff[i] = new Star();
  }
  for(int i=0; i<8; i++)
  {
    terry.add(i,new Asteroid());
  }
}
public void draw() 
{
  //your code here
  background(0);
  for(int i=0; i<jeff.length; i++)
  {
    jeff[i].show();
  }
  bob.rotate(roat);
  bob.accelerate(accel);
  bob.move();
  bob.show();
  for(int i=0; i<bang.size(); i++)
  {
    bang.get(i).move();
    bang.get(i).show();
    if(bang.get(i).getX()<1 || bang.get(i).getX()>width-1 || bang.get(i).getY()<1 || bang.get(i).getY()>height-1)
    {
      bang.remove(i);
    }
  }
  for(int i=0; i<terry.size(); i++)
  {
    terry.get(i).show();
    if(dist(bob.getX(), bob.getY(), terry.get(i).getX(), terry.get(i).getY())<20)
    {
      terry.remove(i);
      terry.add(0,new Asteroid());
      deathCount++;
      bob.setX(250);
      bob.setY(250);
      bob.setDirectionX(0);
      bob.setDirectionY(0);
      if(score>highScore)
      {
        highScore = score;
      }
      score = 0;
      powerFill=0;
    }
    else
    {
      terry.get(i).move();
    }
    for(int j=0; j<bang.size(); j++)
    {
      if(dist(bang.get(j).getX(), bang.get(j).getY(), terry.get(i).getX(), terry.get(i).getY())<20)
      {
        bang.remove(j);
        terry.remove(i);
        terry.add(0, new Asteroid());
        score++;
        if(powerFill>-100)
        {
          powerFill--;
        }
      }
    }
  }
  fill(255);
  text("You have died: " + deathCount + " times", 5, 15);
  text("Score: " + score, 5, 28);
  text("High Score: " + highScore, 5, 41);
  rect(470, 10, 20, 100);
  fill(255, 0, 0);
  rect(470, 110, 20, powerFill);
  if(powerUp)
  {
    if(powerFill<=0)
    {
      powerFill++;
    }
    else 
    {
      powerUp=false;
    }
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();
  abstract public void setY(int y);   
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY(); 
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
}
class SpaceShip extends Floater  
{   
  //your code here
  public SpaceShip()
  {
    corners = 7;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -4;
    yCorners[0] = -4;
    xCorners[1] = 0;
    yCorners[1] = -3;
    xCorners[2] = -3;
    yCorners[2] = -7;
    xCorners[3] = 8;
    yCorners[3] = 0;
    xCorners[4] = -3;
    yCorners[4] = 7;
    xCorners[5] = 0;
    yCorners[5] = 3;
    xCorners[6] = -4;
    yCorners[6] = 4;
    myColor = 255;
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;};  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;} 
}
class Star
{
  private double myX, myY;
  private int myColor;
  public Star()
  {
    myX = Math.random()*501;
    myY = Math.random()*501;
    myColor = color(0,255,0);
  }
  public void show()
  {
    fill(myColor);
    stroke(0);
    ellipse((float)myX, (float)myY, 3, 3);
  }
}
class Asteroid extends Floater
{
  protected int rotSpd;
  public Asteroid()
  {
    rotSpd = ((int)(Math.random()*5))-2;
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -20;
    yCorners[0] = -20;
    xCorners[1] = 0;
    yCorners[1] = -30;
    xCorners[2] = 14;
    yCorners[2] = -16;
    xCorners[3] = 8;
    yCorners[3] = 2;
    xCorners[4] = -2;
    yCorners[4] = 4;
    xCorners[5] = -16;
    yCorners[5] = 0;
    myColor = 204;
    myCenterX = Math.random()*501;
    myCenterY = Math.random()*501;
    myDirectionX = Math.random()*3;
    myDirectionY = Math.random()*3;
    myPointDirection = Math.random()*501;
  }
  public void move()
  {
    rotate(rotSpd);
    super.move();
  }
  public void setX(int x){myCenterX = x;};  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;} 
}
class Bullet extends Floater
{
  public Bullet(SpaceShip theShip, int powerSet)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    if(powerUp)
    {
      if(powerSet==0)
      {
        myDirectionX = 10*Math.cos(dRadians)+theShip.getDirectionX();
        myDirectionY = 10*Math.sin(dRadians)+theShip.getDirectionY();
      }
      if(powerSet==1)
      {
        myDirectionX = -10*Math.cos(dRadians)+theShip.getDirectionX();
        myDirectionY = -10*Math.sin(dRadians)+theShip.getDirectionY();
      }
      if(powerSet==2)
      {
        myDirectionX = 10*Math.cos(dRadians+(Math.PI/2))+theShip.getDirectionX();
        myDirectionY = 10*Math.sin(dRadians+(Math.PI/2))+theShip.getDirectionY();
      }
      if(powerSet==3)
      {
        myDirectionX = 10*Math.cos(dRadians-(Math.PI/2))+theShip.getDirectionX();
        myDirectionY = 10*Math.sin(dRadians-(Math.PI/2))+theShip.getDirectionY();
      }
    }
    else
    {
      myDirectionX = 5*Math.cos(dRadians)+theShip.getDirectionX();
      myDirectionY = 5*Math.sin(dRadians)+theShip.getDirectionY();
    }
  }
  public void show()
  {
    fill(200,0,0);
    stroke(0);
    ellipse((float)(myCenterX),(float)(myCenterY),5,5);
  }
  public void setX(int x){myCenterX = x;};  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;} 
}
public void keyPressed()
{
  if(key == 'd')
  {
    roat = 5;
  }
  else if(key == 'a')
  {
    roat = -5;
  }
  if(key == 'w')
  {
    accel = .05;
  }
  if(key == 's')
  {
    accel = -.05;
  }
  if(key == 'h')
  {
    bob.setX((int)(Math.random()*499));
    bob.setY((int)(Math.random()*499));
    bob.setDirectionX(0);
    bob.setDirectionY(0);
    bob.setPointDirection((int)(Math.random()*360));
  }
  if(key == ' ')
  {
    bang.add(new Bullet(bob,0));
    bang.add(new Bullet(bob,1));
    bang.add(new Bullet(bob,2));
    bang.add(new Bullet(bob,3));
  }
  if(key == 'p')
  {
    if(powerFill==-100)
    {
      powerUp=true;
    }
  }
}
public void keyReleased()
{
  if(key == 'd' || key == 'a')
  {
    roat = 0;
  }
  if(key == 'w' || key == 's')
  {
    accel = 0;
  }
}