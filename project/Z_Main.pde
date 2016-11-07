
TestClass1 testClass1;
Environnement env = new Environnement();


void settings(){
    env.projector = new Projector();
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