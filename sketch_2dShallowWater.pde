// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 2;
final float dy = 2;

final int cellCount = 200;
final float maxHeight = 100;
final float gravity = 3;

WaterCell[][] cells = new WaterCell[cellCount][cellCount]; 

void setup() {
    size(400, 400, P2D);
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
    
    cells[50][50].height = 100;
    cells[60][60].height = 200;
    cells[80][80].height = 150;
}


void draw() {
    fill(0, 220, 255);
    for(int i = 0; i < cellCount; i++) {
        for(int j = 0; j < cellCount; j++) {
        //rect(i * (dx / 5), maxHeight - (cells[i][j].height * 5), (dx / 5), cells[i][j].height * 5);
            //translate(i * (200 / dx), 0, j * (200 / dy));
            //box(dx, cells[i][j].height, dy);
            fill(cells[i][j].height);
            rect(i * dx, j * dy, dx, dy);
        }
    }
}
