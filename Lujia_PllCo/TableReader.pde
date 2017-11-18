class TableReader{
  Table table;
  
  TableRow typeRow;
  TableRow nameRow;
  int rowCount;
  String[] colNames;
  String[] colTypes;
  
  
  TableReader(String fileName){
    table = loadTable(fileName);
  }
   
  
  String[] getColTypes(){
    String[] colTypes = new String[table.getColumnCount()];
    typeRow = table.getRow(1);
    for (int i = 0; i < table.getColumnCount(); i++){
      colTypes[i] = typeRow.getString(i);
    }
    return colTypes;
   }
   
   
  String[] getColNames(){
    String[] colNames = new String[table.getColumnCount()];
    nameRow = table.getRow(0);
    for (int i = 0; i < table.getColumnCount();i++){
      colNames [i] = nameRow.getString(i);
    }
    return colNames;  
  }
  
  
  
  
  
  
}