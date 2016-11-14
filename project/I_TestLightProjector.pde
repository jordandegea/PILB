class TestLightProjector extends Projector{

  private Point positionCenter;
  private Point move;
  Environnement env;

  TestLightProjector(Environnement pEnv){
    this.env = pEnv;
    positionCenter = new Point(env.cameraSize.x/4,env.cameraSize.y/4);
    move = new Point(0,0);
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
}