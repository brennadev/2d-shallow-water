// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 2;
final float dy = 2;

final int cellCount = 200;
final float maxHeight = 255;
final float gravity = 3;

WaterCell[][] cells = new WaterCell[cellCount][cellCount]; 

color test = color(0);

void setup() {
    size(400, 400, P2D);
    noStroke();
    
    // set up a default WaterCell for each cell
    for(int i = 0; i < cellCount; i++) {
        for(int j = 0; j < cellCount; j++) {
            cells[i][j] = new WaterCell(0.5, new PVector(1, 1));
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
            cells[i][j].previousCellVertical = cells[i][j - 1];
        }
    }
    
    //cells[50][50].height = 0.6;
    /*cells[60][60].height = 0.7;
    cells[80][80].height = 0.8;
    cells[81][81].height = 0.9;
    cells[80][81].height = 0.8;
    cells[81][80].height = 0.6;*/
    
    for(int i = 100; i < 120; i++) {
        for(int j = 140; j < 160; j++) {
            //cells[i][j].height = 80 + (i / 1.5) + (j / 1.5);
            cells[i][j].height = .6;
        }
    }
}


void draw() {
    fill(0, 220, 255);
    
    for(int k = 0; k < 60; k++) {
    //println("halfstep");
    for(int i = 0; i < cellCount - 1; i++) {
        for(int j = 0; j < cellCount - 1; j++) {
            //println(i);
            //println(j);
            //println();
            
            cells[i][j].updateHalfStep(.002);
        }
    }
    
    //println("fullstep");
    for(int i = 1; i < cellCount - 1; i++) {
        for(int j = 1; j < cellCount - 1; j++) {
            //println(i);
            //println(j);
            //println();
            
            cells[i][j].updateFullStep(.002);
            
            if (cells[i][j].height < 0) {
                println("height < 0");
            }
        }
    }
    }
    
    for(int i = 0; i < cellCount; i++) {
        for(int j = 0; j < cellCount; j++) {
        //rect(i * (dx / 5), maxHeight - (cells[i][j].height * 5), (dx / 5), cells[i][j].height * 5);
            //translate(i * (200 / dx), 0, j * (200 / dy));
            //box(dx, cells[i][j].height, dy);
            fill(cells[i][j].height * 100);
            rect(i * dx, j * dy, dx, dy);
        }
    }
    
    //println(cells[50][50].height);
}
