class Row{
  HashMap<String, Float> rowPos;
  int rowIndex;
  
  Row(int tempIndex){
    rowIndex = tempIndex;
    rowPos = new HashMap();
  }
  
  
  void insertPos(String colName, float ypos){
    rowPos.put(colName, ypos);
  }
  
  
  



}