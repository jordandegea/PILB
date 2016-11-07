import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 
import processing.video.*; 
import java.awt.*; 
import java.util.*; 
import java.nio.*; 
import org.opencv.core.Core; 
import org.opencv.core.Mat; 
import org.opencv.core.CvType; 
import org.opencv.core.Scalar; 
import org.opencv.objdetect.HOGDescriptor; 
import org.opencv.core.MatOfRect; 
import org.opencv.core.MatOfDouble; 
import org.opencv.core.Rect; 
import org.opencv.core.Size; 
import org.opencv.imgproc.Imgproc; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class project extends PApplet {

// Dont write anything in that

// Classes have to start with 
// E for Environnement class
// F for calibration of scene
// G for calibration of human
// H for Position conversion
// I for for transmission to projector



class Environnement{
    public Point cameraSize;
    public Projector projector;
    public BaseExecutor executor;
    public PApplet app;
    
    public int state;
    
    public static final int SETTING_UP = 1;
    public static final int CALIBRINGE_SCENE = 2;
    public static final int CALIBRINGE_USER = 3;
    public static final int RUNINNG = 4;
    
    
    Environnement(){
      state = SETTING_UP;
      cameraSize = new Point(1280, 960);
    }
    
    public boolean keyPressed(){
      return true;
    }
    public void draw() {
      executor.draw();
    }
  
    public void captureEvent(Capture c) {
      executor.captureEvent(c);
    }
}
class Projector{

  private Point position;
  
  Projector(){
    position = new Point(0,0);
  }
  
  public boolean moveTo(Point dest){
    return true; 
  }
  
  public boolean moveUp(){
    return true;
  }
  public boolean moveUpRight(){
    return true;
  }
  public boolean moveRight(){
    return true;
  }
  public boolean moveDownRight(){
    return true;
  }
  public boolean moveDown(){
    return true;
  }
  public boolean moveDownLeft(){
    return true;
  }
  public boolean moveLeft(){
    return true;
  }
  public boolean moveUpLeft(){
    return true;
  }
}

class BaseExecutor{
  BaseExecutor(){}
  BaseExecutor(Environnement env){}
  
  public void draw() {}
  
  public void captureEvent(Capture c) {}
}



















class TestClass1 extends BaseExecutor{
  Capture video;
  OpenCV opencv;
  
  PImage small;
  HOGDescriptor hog;
 
  byte [] bArray;
  int [] iArray;
  int pixCnt1, pixCnt2;
  int w, h;
  float ratio;

  TestClass1(Environnement env){
    video = new Capture(env.app, env.cameraSize.x/2, env.cameraSize.y/2);
    opencv = new OpenCV(env.app, env.cameraSize.x/2, env.cameraSize.y/2);
    
  
    video.start();
  }
  
  public void draw() {
    
    text("Frame Rate: " + round(frameRate), 0, 0 );
    
    scale(2);
    opencv.loadImage(video);
  
    image(video, 0, 0);
  
    noFill();
    stroke(0, 255, 0);
    strokeWeight(2);
    
    //TRY TO FIND LOWER BODY
    Rectangle[] lb = findLowerBody();
    //IF LowerBodies not found, try to look for face
    if (lb.length == 0){
     findFace();
    }
    
  }
  
  public Rectangle[] findLowerBody(){
    
    opencv.loadCascade(OpenCV.CASCADE_LOWERBODY); 
    Rectangle[] lowerbodies = opencv.detect();
    println(lowerbodies.length);
  
    for (int i = 0; i < lowerbodies.length; i++) {
      println(lowerbodies[i].x + "," + lowerbodies[i].y);
      stroke(0, 255, 0);
      rect(lowerbodies[i].x, lowerbodies[i].y, lowerbodies[i].width, lowerbodies[i].height);
      stroke(255, 0, 0);
      ellipse(lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y , 4, 4);
      
      println("POSITION FOR LIGHT(LOWER BODY):" + lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y );

    }
    
    return lowerbodies;
    
  }
  
  public void findFace(){
    
     opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
      Rectangle[] faces = opencv.detect();
      println(faces.length);
      
      for (int i = 0; i < faces.length; i++) {
        println(faces[i].x + "," + faces[i].y);
        stroke(0, 255, 0);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        stroke(255, 0, 0);
        ellipse(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2 , 4, 4);
        
        println("POSITION FOR LIGHT (FACE):" + faces[i].x + faces[i].width / 2 , faces[i].y + faces[i].height / 2 );
        
      }
    
  }
  
  
  public void captureEvent(Capture c) {
    c.read();
  }
}

TestClass1 testClass1;
Environnement env = new Environnement();


public void settings(){
    env.projector = new Projector();
    env.app = this;
    size(env.cameraSize.x, env.cameraSize.y);
}

public void setup() {
    env.executor = new TestClass1(env);
}

public void draw() {
  env.draw();
}

public void captureEvent(Capture c) {
  env.captureEvent(c);
}


int rectWidth;
public void keyPressed() {
  env.keyPressed();
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (keyIndex == -1) {
    // If it's not a letter key, clear the screen
    background(0);
  } else { 
    // It's a letter key, fill a rectangle
    fill(millis() % 255);
    float x = map(keyIndex, 0, 25, 0, width - rectWidth);
    rect(x, 0, rectWidth, height);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
