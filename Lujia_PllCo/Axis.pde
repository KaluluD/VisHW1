class Axis{
  float x1, x2, y1, y2;
  String label, type;
  HashMap <Integer, Object> colData;
  
  boolean selected = false;
  
  
  Axis(String tempLabel, String tempType, float tempx1, float tempy1, float tempx2, float tempy2){
    label = tempLabel;
    type = tempType;
    x1 = tempx1;
    x2 = tempx2;
    y1 = tempy1;
    y2 = tempy2;
    colData = new HashMap<Integer, Object>();
    
  }
  
  void display(){
    //Todo: display label
    stroke(0);
    strokeWeight(2);
    if (selected == true){
      stroke(255, 176, 0, 90);
    }
    line(x1,y1, x2, y2);
    text(label, x1-20, y1-10);
    fill(0);
  }

  void updateSelected(float px, float py) {
    if (px == x1 && py >= y1 && py <= y2) {
      selected = true; 
    } else {
      selected = false;
    }
  }
  
  void insertColData(int rowIndex, Object data){
    colData.put(rowIndex, data);
  }
  
  void updateColDataMap(HashMap<Integer, Object> inputMap){
    for(Integer key: inputMap.keySet()){
      Object value = inputMap.get(key);
      colData.replace(key, value);
    }
  }
  
}