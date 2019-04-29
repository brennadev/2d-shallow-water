// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 5;
final float dy = 5;

final int cellCount = 200;
final float maxHeight = 100;
final float gravity = 3;

WaterCell[][] cells = new WaterCell[cellCount][cellCount]; 

void setup() {
    size(400, 400, P3D);
    noStroke();
    
    // set up a default WaterCell for each cell
    for(int i = 0; i < cellCount; i++) {
        for(int j = 0; j < cellCount; j++) {
            cells[i][j] = new WaterCell(3, new PVector(1, 1));
        }
    }
    
    // previous/next cells
    for(int i = 0; i < cellCount - 1; i++) {
        for(int j = 0; j < cellCount; j++) {
            cells[i][j].nextCellHorizontal = cells[i + 1][j];
        }
    }
    
    for(int i = 1; i < cellCount; i++) {
        for(int j = 0; j < cellCount; j++) {
            cells[i][j].previousCellHorizontal = cells[i - 1][j];
        }
    }
    
    for(int i = 0; i < cellCount; i++) {
        for(int j = 0; j < cellCount - 1; j++) {
            cells[i][j].nextCellVertical = cells[i][j + 1];
        }
    }
    
    for(int i = 0; i < cellCount; i++) {
        for(int j = 1; j < cellCount; j++) {
            cells[i][j].nextCellVertical = cells[i][j - 1];
        }
    }
}


void draw() {
    
}
