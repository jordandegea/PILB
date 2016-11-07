
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
  
  void draw() {
    
    text("Frame Rate: " + round(frameRate), 0, 0 );
    
    scale(2);
    opencv.loadImage(video);
  
    image(video, 0, 0);
  
    noFill();
    stroke(0, 255, 0);
    strokeWeight(2);
    
    findPeople();
    env.projector.updateMove(env.positionGuy);
    println("lolol");
  }

  void findPeople(){
    //TRY TO FIND LOWER BODY
    Rectangle[] lb = findLowerBody();
    //IF LowerBodies not found, try to look for face
    if (lb.length == 0){
     findFace();
    }
  }
  
  Rectangle[] findLowerBody(){
    
    opencv.loadCascade(OpenCV.CASCADE_LOWERBODY); 
    Rectangle[] lowerbodies = opencv.detect();
    //println(lowerbodies.length);
  
    for (int i = 0; i < lowerbodies.length; i++) {
      //println(lowerbodies[i].x + "," + lowerbodies[i].y);
      stroke(0, 255, 0);
      rect(lowerbodies[i].x, lowerbodies[i].y, lowerbodies[i].width, lowerbodies[i].height);
      stroke(255, 0, 0);
      ellipse(lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y , 4, 4);
      
      //println("POSITION FOR LIGHT(LOWER BODY):" + lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y );
        env.positionGuy = new Point(lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y);

    }
    
    return lowerbodies;
    
  }
  
  void findFace(){
    
     opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
      Rectangle[] faces = opencv.detect();
      //println(faces.length);
      
      for (int i = 0; i < faces.length; i++) {
        //println(faces[i].x + "," + faces[i].y);
        stroke(0, 255, 0);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        stroke(255, 0, 0);
        ellipse(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2 , 4, 4);
        
        //println("POSITION FOR LIGHT (FACE):" + faces[i].x + faces[i].width / 2 , faces[i].y + faces[i].height / 2 );
        
        env.positionGuy = new Point(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2);
      }
    
  }
  
  
  void captureEvent(Capture c) {
    c.read();
  }
}
