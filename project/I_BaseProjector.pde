class Projector{

  private Point position;
  
  Projector(){
    position = new Point(0,0);
  }
  
  public boolean moveTo(Point dest){
    return true; 
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