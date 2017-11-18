TableReader reader;
Table dataTable;
String[] dataTypes;
String[] colNames;
Axis[] axises;
Row[] rows;
float BGWidth = 1000;
float BGHeight = 600;
float axisX1 = BGWidth/8;
float axisY1 = 200;
float axisX2 = axisX1;
float axisY2 = 700;
float axisGap = 110;
int[] selectedPos = {100, 100};


void setup(){
  size(2000,800);
  pixelDensity(displayDensity());
  loadData();
}

void loadData(){
  reader = new TableReader("cars-cleaned.tsv");
  dataTable = reader.table;
  dataTypes = reader.getColTypes();
  colNames = reader.getColNames();
  
  
  axises = new Axis[colNames.length];
  
  for (int i = 0; i < colNames.length; i++){
    String label = colNames[i];
    String type = dataTypes[i];
    float tempX1 = axisX1 + i*axisGap;
    float tempY1 = axisY1;
    float tempX2 = axisX2 + i*axisGap;
    float tempY2 = axisY2;
    axises[i] = new Axis(label, type, tempX1,tempY1, tempX2, tempY2);
  }
 

  // store column data for each Axis
  for (int i = 2; i < dataTable.getRowCount(); i++){
    TableRow row = dataTable.getRow(i);
    for (int j = 0; j < axises.length; j++){
      String type = axises[j].type;
      String label = axises[j].label;
      if (type.equals("string")){
        Object data = (Object) row.getString(j);
        axises[j].insertColData(i, data);
      }else if (type.equals("integer")){
        Object data = (Object) row.getInt(j);
        axises[j].insertColData(i, data);
      }else if(type.equals("float")){
        Object data = (Object) row.getFloat(j);
        axises[j].insertColData(i, data);
      }
    }
  }
  
  
  getRows();
  
}


void draw(){
  background(250);
  for (int i = 0; i < colNames.length; i++){
    axises[i].display();
  }
  
  // connect data points on each row
  for (int i = 2; i < rows.length; i++){
    for(int j = 1; j < axises.length; j++){
      String tempLabel1 = axises[j-1].label;
      float tempX1 = axises[j-1].x1;
      float tempY1 = rows[i].rowPos.get(tempLabel1);
      String tempLabel2 = axises[j].label;
      float tempX2 = axises[j].x1;
      float tempY2 = rows[i].rowPos.get(tempLabel2);
      stroke(152, 34, 66,70);
      strokeWeight(1);
      noFill();
      line(tempX1,tempY1, tempX2, tempY2);      
    }
  
  }
    
}

// swap two axises
void updateAxises(){
  for (int i = 0; i < axises.length; i++){ //<>//
    if (axises[i].selected == true){ //<>//
      if(selectedPos[0] == 100){ //<>//
        selectedPos[0] = i; //<>//
      }else{ //<>//
        selectedPos[1] = i; //<>//
      }
    }
  }
  if (selectedPos[0]!=100 && selectedPos[1]!=100){
    
    Axis oldAxis_1 = axises[selectedPos[1]];
    Axis oldAxis_0 = axises[selectedPos[0]];

    String axis1_tempLabel = oldAxis_1.label; //<>//
    String axis1_tempType = oldAxis_1.type; //<>//
    HashMap axis1_tempColData = new HashMap<Integer, Object>(oldAxis_1.colData); //<>//
    
    String axis0_tempLabel = oldAxis_0.label; //<>//
    String axis0_tempType = oldAxis_0.type; //<>//
    HashMap axis0_tempColData = new HashMap<Integer, Object>(oldAxis_0.colData); //<>//
    
    oldAxis_0.label = axis1_tempLabel; //<>//
    oldAxis_0.type = axis1_tempType; //<>//
    oldAxis_0.updateColDataMap(axis1_tempColData); //<>//
    oldAxis_1.label = axis0_tempLabel; //<>//
    oldAxis_1.type = axis0_tempType; //<>//
    oldAxis_1.updateColDataMap(axis0_tempColData); //<>//

  
    axises[selectedPos[1]].selected = false;
    axises[selectedPos[0]].selected = false;
    
    selectedPos[0] = selectedPos[1] = 100;
  }

}




// get the min value of a float axis
float getFloatMin(Axis axis){
  float min = (float)axis.colData.get(2);
  for(int i = 3; i < (axis.colData.size()+2); i++){
    float tempValue = (float) axis.colData.get(i);
    if (tempValue < min){
      min = tempValue;
    }
  }
  return min;
}


// get the min value of a float axis
float getFloatMax(Axis axis){
  float max = (float)axis.colData.get(2);
  for(int i = 3; i < (axis.colData.size()+2); i++){
    float tempValue = (float)axis.colData.get(i);
    if (tempValue > max){
      max = tempValue;
    }
  }
  return max;
}

// get the min value of a integer axis
int getIntMin(Axis axis){
  int min = (int)axis.colData.get(2);
  for(int i = 3; i < (axis.colData.size()+2); i++){
    int tempValue = (int) axis.colData.get(i);
    if (tempValue < min){
      min = tempValue;
    }
  }
  return min;
}


// get the min value of a integer axis
int getIntMax(Axis axis){
  int max = (int)axis.colData.get(2);
  for(int i = 3; i < (axis.colData.size()+2); i++){
    int tempValue = (int)axis.colData.get(i);
    if (tempValue > max){
      max = tempValue;
    }
  }
  return max;
}


//construct array rows
Row[] getRows(){
  int numOfRow = dataTable.getRowCount(); //<>//
  int numOfCol = axises.length; //<>//
  rows = new Row[numOfRow]; //create an empty array rows //<>//
  for (int i = 0; i<numOfRow; i++){
    rows[i] = new Row(i);
  }
  for (int i = 0; i < numOfCol; i++){ //<>//
    String type = axises[i].type;
    String label = axises[i].label;
    HashMap<Integer, Object> colDataMap = axises[i].colData;
    
    // if it is a float axis
    if (type.equals("float")){ //<>//
      float min = getFloatMin(axises[i]);
      float max = getFloatMax(axises[i]);
      float dataRange = max-min;
      float scaleRange = axises[i].y2 - axises[i].y1;
      for (int j = 2; j < numOfRow; j++ ){ //<>// //<>//
        float data = (float)colDataMap.get(j); //<>//
        float pos = axises[i].y1+(data-min)/dataRange*scaleRange;
        rows[j].insertPos(label, pos);
      }
    // if it is an integer axis
    }else if(type.equals("integer")){ //<>//
      float min = (float)getIntMin(axises[i]);
      float max = (float)getIntMax(axises[i]);
      float dataRange = (float)max - (float)min;
      float scaleRange = axises[i].y2 - axises[i].y1;
      for (int j = 2; j < numOfRow; j++ ){ //<>// //<>//
        int data = (Integer) colDataMap.get(j); //<>//
        float pos = axises[i].y1+(data-min)/dataRange*scaleRange;
        rows[j].insertPos(label, pos);
      }
    // if it is a string axis
    }else if(type.equals("string")){ //<>//
      float unitLength = (axises[i].y2 - axises[i].y1)/(numOfRow-1);
      for (int j = 2; j < numOfRow; j++){
        float pos = axises[i].y1 + j*unitLength;
        rows[j].insertPos(label, pos);
      }
    
    }

  }
  return rows;

}

void mousePressed(){
  for (int i = 0; i < axises.length; i++){
    axises[i].updateSelected(mouseX, mouseY); //<>//
  }
  updateAxises();
  getRows();
  
}