
TestClass1 testClass1;
Point cameraSize = new Point(640, 400);
Environnement env = new Environnement();

void settings(){
    size(env.cameraSize.x, env.cameraSize.y); 
}

void setup() {
  testClass1 = new TestClass1(env, this);
}

void draw() {
  testClass1.draw();
}

void captureEvent(Capture c) {
  testClass1.captureEvent(c);
}