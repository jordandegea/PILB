
import gab.opencv.*;
import processing.video.*;
import java.awt.*;


class TestClass1{
  Capture video;
  OpenCV opencv;

  TestClass1(Environnement env, PApplet parent){
    video = new Capture(parent, env.cameraSize.x/2, env.cameraSize.y/2);
    opencv = new OpenCV(parent, env.cameraSize.x/2, env.cameraSize.y/2);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
    video.start();
  }
  
  void draw() {
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
  
  void captureEvent(Capture c) {
    c.read();
  }
}