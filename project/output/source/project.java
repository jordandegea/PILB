import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 
import processing.video.*; 
import java.awt.*; 

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
// F for calibration of human
// G for calibration of human
// H for Position conversion
// I for for transmission to camera



class Environnement{
    public Point cameraSize;
    
    Environnement(){
      cameraSize = new Point(640, 400);
    }
}






class TestClass1{
  Capture video;
  OpenCV opencv;

  TestClass1(Environnement env, PApplet parent){
    video = new Capture(parent, env.cameraSize.x/2, env.cameraSize.y/2);
    opencv = new OpenCV(parent, env.cameraSize.x/2, env.cameraSize.y/2);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
    video.start();
  }
  
  public void draw() {
    scale(2);
    opencv.loadImage(video);
  
    image(video, 0, 0 );
  
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    println(faces.length);
  
    for (int i = 0; i < faces.length; i++) {
      println(faces[i].x + "," + faces[i].y);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
  
  public void captureEvent(Capture c) {
    c.read();
  }
}

TestClass1 testClass1;
Point cameraSize = new Point(640, 400);
Environnement env = new Environnement();

public void settings(){
    size(env.cameraSize.x, env.cameraSize.y); 
}

public void setup() {
  testClass1 = new TestClass1(env, this);
}

public void draw() {
  testClass1.draw();
}

public void captureEvent(Capture c) {
  testClass1.captureEvent(c);
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
