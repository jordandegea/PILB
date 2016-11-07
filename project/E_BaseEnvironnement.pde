
class Environnement{
    public Point cameraSize;
    public Projector projector;
    public BaseExecutor executor;
    public PApplet app;

    public Point positionGuy;

    public int state;
    
    public static final int SETTING_UP = 1;
    public static final int CALIBRINGE_SCENE = 2;
    public static final int CALIBRINGE_USER = 3;
    public static final int RUNINNG = 4;
    
    
    Environnement(){
      state = SETTING_UP;
      cameraSize = new Point(1280, 720);
    }
    
    boolean keyPressed(){
      return true;
    }
    void draw() {
      executor.draw();
    }
  
    void captureEvent(Capture c) {
      executor.captureEvent(c);
    }
}