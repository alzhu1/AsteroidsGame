//your variable declarations here
SpaceShip bob = new SpaceShip();
Star jeff[];
int roat = 0;
double accel = 0;
public void setup() 
{
  //your code here
  size(500,500);
  jeff = new Star[300];
  for(int i=0; i<jeff.length; i++)
  {
    jeff[i] = new Star();
  }
}
public void draw() 
{
  //your code here
  background(0);
  int x = bob.getX();
  int y = bob.getY();
  for(int i=0; i<jeff.length; i++)
  {
    jeff[i].show();
  }
  bob.rotate(roat);
  bob.accelerate(accel);
  bob.move();
  bob.show();
}
class SpaceShip extends Floater  
{   
    //your code here
    public SpaceShip()
    {
      corners = 7;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = -8;
      yCorners[0] = -8;
      xCorners[1] = 0;
      yCorners[1] = -5;
      xCorners[2] = -5;
      yCorners[2] = -13;
      xCorners[3] = 16;
      yCorners[3] = 0;
      xCorners[4] = -5;
      yCorners[4] = 13;
      xCorners[5] = 0;
      yCorners[5] = 5;
      xCorners[6] = -8;
      yCorners[6] = 8;
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
public void keyPressed()
{
  if(key == 'd')
  {
    roat = 3;
  }
  else if(key == 'a')
  {
    roat = -3;
  }
  if(key == 'w')
  {
      accel = .05;
  }
  if(key == 'h')
  {
    bob.setX((int)(Math.random()*499));
    bob.setY((int)(Math.random()*499));
    bob.setDirectionX(0);
    bob.setDirectionY(0);
  }
}
public void keyReleased()
{
  if(key == 'd' || key == 'a')
  {
    roat = 0;
  }
  if(key == 'w')
  {
    accel = 0;
  }
}