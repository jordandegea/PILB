import java.io.*;
import java.net.*;

class TestLightProjector extends Projector{

  private Point positionCenter;
  private Point move;
  Environnement env;

  TestLightProjector(Environnement pEnv){
    this.env = pEnv;
    positionCenter = new Point(env.cameraSize.x/4,env.cameraSize.y/4);
    move = new Point(0,0);
  
    init();
  }

  public void init(){

  }
  
  public boolean updateMove(Point positionGuy){
    move.x = positionGuy.x - positionCenter.x;
    move.y = positionGuy.y - positionCenter.y;
    //afficher direction déplacement
    if(move.x>0)
      println("->" + move.x,positionGuy.x, positionCenter.x);
    else
      println("<-" + move.x,positionGuy.x, positionCenter.x);


    //stroke(0, 255, 0);
    //text("Hello Strings!",10,100);   // STEP 5 Display Text
    //rect(positionCenter.x, positionCenter.y, 50, 50);
    //stroke(255, 0, 0);
    //ellipse(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2 , 4, 4);


    return true; 
  }
  
  public Point getMove(){
    return move;
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


  public final static int OBJ_LYRE_PAN = 1;
  public final static int OBJ_LYRE_TILT = 2;
  public final static int OBJ_LYRE_COLOR = 3;

  private String STATE_LYRE_PAN = "50" ;
  private String STATE_LYRE_TILT = "50" ;
  private String STATE_LYRE_COLOR = "0,0,100" ;


  public void sendCommand(int obj){

    try {
      String url = "http://192.168.0.85:8080/CMD?";
      switch(obj){
        case OBJ_LYRE_PAN: url += "LYRE_PAN="+STATE_LYRE_PAN ; break;
        case OBJ_LYRE_TILT: url += "LYRE_TILT="+STATE_LYRE_TILT ; break;
        case OBJ_LYRE_COLOR: url += "LYRE_COLOR=" + STATE_LYRE_COLOR ; break;
        default: break;
      }
     GetRequest get = new GetRequest(url);
      get.send();
      println("Reponse Content: " + get.getContent());
      println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));

    } catch( Exception e ) { 
      e.printStackTrace(); 
    }
  }
}