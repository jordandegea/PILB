
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
 
  byte [] bArray;
  int [] iArray;
  int pixCnt1, pixCnt2;
  int w, h, camwidth, camheight;
  float ratio;
  int X = 640, Y = 400;

  TestClass1(Environnement env){
    
    String[] cameras = Capture.list();
  
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println("i=" + i + " - " + cameras[i]);
      }    
    }
    
   
   
    video = new Capture(env.app, env.cameraSize.x/2 , env.cameraSize.y/2, cameras[55], 30);
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
    
    //TRY TO FIND LOWER BODY
    Rectangle[] lb = findLowerBody();
    //IF LowerBodies not found, try to look for face
    if (lb.length == 0){
     println("NO LOW BODIES");
     findFace();
    }
    
  }
  
  Rectangle[] findLowerBody(){
    
    opencv.loadCascade(OpenCV.CASCADE_UPPERBODY); 
    Rectangle[] lowerbodies = opencv.detect();
    println(lowerbodies.length);
  
    for (int i = 0; i < lowerbodies.length; i++) {
      println(lowerbodies[i].x + "," + lowerbodies[i].y);
      stroke(0, 255, 0);
      rect(lowerbodies[i].x, lowerbodies[i].y, lowerbodies[i].width, lowerbodies[i].height);
      stroke(255, 0, 0);
      ellipse(lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y + lowerbodies[i].height , 4, 4);
      
      println("POSITION FOR LIGHT(UPPER BODY):" + lowerbodies[i].x + lowerbodies[i].width / 2, lowerbodies[i].y + lowerbodies[i].height );

    }
    
    return lowerbodies;
    
  }
  
  void findFace(){
    
     opencv.loadCascade(OpenCV.CASCADE_PEDESTRIAN); 
      Rectangle[] faces = opencv.detect();
      println(faces.length);
      
      for (int i = 0; i < faces.length; i++) {
        println(faces[i].x + "," + faces[i].y);
        stroke(0, 255, 0);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        stroke(255, 0, 0);
        ellipse(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2 , 4, 4);
        
        println("POSITION FOR LIGHT (PEDESTRIAN):" + faces[i].x + faces[i].width / 2 , faces[i].y + faces[i].height / 2 );
        
      }
    
  }
  
  void findResolution(){
   String[] cameras = Capture.list();
   
   if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
   } 
   else {
     int p = cameras[cameras.length - 1].indexOf("fps=");
    // Search where the width begins
    int q = cameras[cameras.length - 1].indexOf("size=");
    // Search where the width ends and height begins
    int r = cameras[cameras.length - 1].indexOf("x");
    // Search where the height ends
    int s = cameras[cameras.length - 1].indexOf(",fps");
 
    println("fps= " + cameras[cameras.length - 1].substring(p+4));
    
    camwidth = Integer.parseInt(cameras[cameras.length - 1].substring(q+5, r));
    camheight = Integer.parseInt(cameras[cameras.length - 1].substring(r+1, s));
    
   }
  }
  
  
  void captureEvent(Capture c) {
    c.read();
  }
}