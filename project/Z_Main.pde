
import http.requests.*;

 
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import java.io.*;
import java.net.*;


TestClass1 testClass1;
Environnement env = new Environnement();


void settings(){
    TestLightProjector light = new TestLightProjector(env);
    env.projector = light;
    light.sendCommand(1);
    light.sendCommand(2);
    light.sendCommand(3);
    env.app = this;
    size(env.cameraSize.x, env.cameraSize.y);
    
}

void setup() {
    env.executor = new TestClass1(env);
}

void draw() {
  env.draw();
}

void captureEvent(Capture c) {
  env.captureEvent(c);
}


int rectWidth;
void keyPressed() {
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