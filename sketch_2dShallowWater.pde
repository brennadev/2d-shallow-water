// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 3;
final float dy = 3;

final int cellCountHorizontal = 132;
final int cellCountVertical = 186;
final float maxHeight = 255;
final float gravity = 3;

WaterCell[][] cells = new WaterCell[cellCountHorizontal + 2][cellCountVertical + 2]; 

color test = color(0);

PImage image; 

void setup() {
    size(396, 558, P2D);
    image = loadImage("testLarge.png");
    noStroke();
    
    // set up a default WaterCell for each cell
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j] = new WaterCell(0.5, 0);
        }
    }
    
    // the edge cells that always stay 0 for height
    /*for(int i = 0; i < cellCountHorizontal + 1; i++) {
        cells[i][0] = new WaterCell(0, 0);                // topmost row
        cells[0][i] = new WaterCell(0, 0);                // leftmost column
        cells[cellCount + 1][i] = new WaterCell(0, 0);    // bottommost row
        cells[i][cellCount + 1] = new WaterCell(0, 0);    // rightmost column
    }*/
    
    for(int i = 0; i < cellCountHorizontal + 1; i++) {
        cells[i][0] = new WaterCell(0, 0);                       
        cells[i][cellCountVertical + 1] = new WaterCell(0, 0);    
    }
    
    for(int j = 0; j < cellCountVertical + 1; j++) {
        cells[0][j] = new WaterCell(0, 0);
        cells[cellCountHorizontal + 1][j] = new WaterCell(0, 0);
    }
    
    // previous/next cells
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].nextCellHorizontal = cells[i + 1][j];
        }
    }
    
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].previousCellHorizontal = cells[i - 1][j];
        }
    }
    
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].nextCellVertical = cells[i][j + 1];
        }
    }
    
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].previousCellVertical = cells[i][j - 1];
        }
    }
    
    //cells[50][50].height = 0.6;
    /*cells[60][60].height = 0.7;
    cells[80][80].height = 0.8;
    cells[81][81].height = 0.9;
    cells[80][81].height = 0.8;
    cells[81][80].height = 0.6;*/
    
    /*for(int i = 100; i < 115; i++) {
        for(int j = 140; j < 150; j++) {
            //cells[i][j].height = 80 + (i / 1.5) + (j / 1.5);
            cells[i][j].height = .6;
        }
    }*/
    cells[100][100].height = .6;
    cells[50][150].height = .7;
    cells[24][40].height = .7;
    cells[15][10].height = .8;
    //cells[175][50].height = .55;
    cells[25][125].height = .8;
    cells[3][20].height = .8;
    cells[100][50].height = .8;
    cells[40][70].height = .8;
    cells[41][70].height = .8;
    cells[42][70].height = .8;
    cells[101][50].height = .8;
    cells[75][30].height = .8;
    
    cells[4][20].height = .8;
    cells[100][51].height = .8;
    cells[40][71].height = .8;
    cells[41][71].height = .8;
    cells[42][71].height = .8;
    cells[101][51].height = .8;
    cells[75][31].height = .8;
    
    cells[4][21].height = .8;
    cells[100][52].height = .8;
    cells[40][72].height = .8;
    cells[41][72].height = .8;
    cells[42][72].height = .8;
    cells[101][52].height = .8;
    cells[75][32].height = .8;
    
    cells[5][20].height = .8;
    cells[99][51].height = .8;
    cells[43][71].height = .8;
    cells[43][71].height = .8;
    cells[43][71].height = .8;
    cells[102][51].height = .8;
    cells[76][31].height = .8;
    
    cells[42][21].height = .8;
    cells[10][52].height = .8;
    cells[48][72].height = .8;
    cells[46][72].height = .8;
    cells[49][72].height = .8;
    cells[107][52].height = .8;
    cells[79][32].height = .8;
    
    cells[130][100].height = .8;
    cells[120][80].height = .8;
    cells[110][75].height = .8;
    cells[80][100].height = .8;
    cells[120][40].height = .8;
    
    loadPixels();
    image.loadPixels();
    
    for(int i = 0; i < image.width; i++) {
        for(int j = 0; j < image.height; j++) {
            int pixelLocation = i + j * width;
            
            float red = red(image.pixels[pixelLocation]);
            float green = green(image.pixels[pixelLocation]);
            float blue = blue(image.pixels[pixelLocation]);
            
            pixels[pixelLocation] = color(red, green, blue);
        }
    }
    updatePixels();
}


void draw() {
    
    
    // I think the actual image stuff can go in setup since then after that, I don't want to be working off the original image
    loadPixels();
    
    
    // update heights of cells
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            //println(i);
            //println(j);
            cells[i][j].update();
        }
    }
    
    // get total height around cell
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
            
            float redTotal = 0;
            float greenTotal = 0;
            float blueTotal = 0;
            
            for(int k = 0; k < 3; k++) {
                for(int l = 0; l < 3; l++) {
                    int pixel = pixels[(i - 1) * 3 + k +((j - 1) * 3 + l) * width];
                    redTotal += red(pixel);
                    greenTotal += green(pixel);
                    blueTotal += blue(pixel);
                }
            }
            
            
            redTotal /= 9;
            greenTotal /= 9;
            blueTotal /= 9;
            color colorTotal = color(redTotal, greenTotal, blueTotal);
            cells[i][j].averageColor = colorTotal;
            
            // never is true
            if (redTotal <= 0 && greenTotal <= 0 && blueTotal <= 0) {
                println("small color totals");
            }
            
            // TODO: may not want to include the edge cells in the calculation of the color as that'll make the edges get really dark since that color is black 

            cells[i][j].totalAdjacentHeight = cells[i - 1][j].heightDifference + cells[i + 1][j].heightDifference + cells[i][j - 1].heightDifference + cells[i][j + 1].heightDifference;
        }
    }
    
        for(int i = 1; i < cellCountHorizontal + 1; i++) {
            for(int j = 1; j < cellCountVertical + 1; j++) {
                float topCellHeightPercentage = cells[i][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
                float bottomCellHeightPercentage = cells[i][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;
                float leftCellHeightPercentage = cells[i - 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
                float rightCellHeightPercentage = cells[i + 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
                
                if (cells[i][j].totalAdjacentHeight == 0) {
                    continue;
                }
                
                // never true
                /*if (topCellHeightPercentage + bottomCellHeightPercentage + leftCellHeightPercentage + rightCellHeightPercentage <= .95) {
                    println("height total too low");
                }*/
                
                // lots of NaN values
                //println(topCellHeightPercentage + bottomCellHeightPercentage + leftCellHeightPercentage + rightCellHeightPercentage);
                
                color topColor = cells[i][j - 1].averageColor;
                color bottomColor = cells[i][j + 1].averageColor;
                color leftColor = cells[i - 1][j].averageColor;
                color rightColor = cells[i + 1][j].averageColor;
                
                float topRed = red(topColor) * topCellHeightPercentage;
                float topGreen = green(topColor) * topCellHeightPercentage;
                float topBlue = blue(topColor) * topCellHeightPercentage;
                
                float bottomRed = red(bottomColor) * bottomCellHeightPercentage;
                float bottomGreen = green(bottomColor) * bottomCellHeightPercentage;
                float bottomBlue = blue(bottomColor) * bottomCellHeightPercentage;
                
                float leftRed = red(leftColor) * leftCellHeightPercentage;
                float leftGreen = green(leftColor) * leftCellHeightPercentage;
                float leftBlue = blue(leftColor) * leftCellHeightPercentage;
                
                float rightRed = red(rightColor) * rightCellHeightPercentage;
                float rightGreen = green(rightColor) * rightCellHeightPercentage;
                float rightBlue = blue(rightColor) * rightCellHeightPercentage;
                
                if (i == 1 && j == 1) {
                    cells[i][j].adjacentCellsColorWeightedAverage = color(bottomRed + rightRed,
                                                                          bottomGreen + rightGreen,
                                                                          bottomBlue + rightBlue);
                    if (bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                        println("0 values");
                    }
                } else if (i == 1 && j == cellCountVertical) {
                    cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + rightRed,
                                                                          topGreen + rightGreen,
                                                                          topBlue + rightBlue);
                    if (topRed == 0 && topGreen == 0 && topBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                        println("0 values");
                    }
                } else if (i == cellCountHorizontal && j == 1) {
                    cells[i][j].adjacentCellsColorWeightedAverage = color(bottomRed + leftRed,
                                                                          bottomGreen + leftGreen,
                                                                          bottomBlue + leftBlue);
                    if (bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0) {
                        println("0 values");
                    }
                } else if (i == cellCountHorizontal && j == cellCountVertical) {
                    
                    cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + leftRed,
                                                                          topGreen + leftGreen,
                                                                          topBlue + leftBlue);
                    if (topRed == 0 && topGreen == 0 && topBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0) {
                        println("0 values");
                    }
                } else {
                    cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + bottomRed + leftRed + rightRed,
                                                                          topGreen + bottomGreen + leftGreen + rightGreen,
                                                                          topBlue + bottomBlue + leftBlue + rightBlue);
                    /*if (topRed == 0 && topGreen == 0 && topBlue == 0) {
                        println("top 0");
                    }
                    
                    if (leftRed == 0 && leftGreen == 0 && leftBlue == 0) {
                        println("left 0");
                    }*/
                    
                    /*if (bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0) {
                        println("bottom 0");
                    }
                    
                    if (rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                        println("right 0");
                    }*/
                    
                    if (topRed == 0 && topGreen == 0 && topBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0
                     || bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                         //println("0 values");
                         
                         // most of the 0 values are coming from this
                         //return;
                    }
                }
                                                                
                //println(red(cells[i][j].adjacentCellsColorWeightedAverage));
                color interpolated = lerpColor(cells[i][j].adjacentCellsColorWeightedAverage, cells[i][j].averageColor, 0.5);
                
                cells[i][j].averageColor = interpolated;
            }
        }
    
    
    for(int i = 0; i < width; i++) {
        for(int j = 0; j < height; j++) {
            int pixelLocation = i + j * width;
            
            float red = red(pixels[pixelLocation]);
            float green = green(pixels[pixelLocation]);
            float blue = blue(pixels[pixelLocation]);
            
            color cellColor = cells[i / 3 + 1][j / 3 + 1].averageColor;
            
            float cellColorRed = red(cellColor);
            float cellColorGreen = green(cellColor);
            float cellColorBlue = blue(cellColor);
            
            
            
            pixels[pixelLocation] = color(cellColorRed, cellColorGreen, cellColorBlue);
        }
    }

    updatePixels();
    
    
    
    /*for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
        //rect(i * (dx / 5), maxHeight - (cells[i][j].height * 5), (dx / 5), cells[i][j].height * 5);
            //translate(i * (200 / dx), 0, j * (200 / dy));
            //box(dx, cells[i][j].height, dy);

            fill(cells[i][j].height * 100, 100);
            //rect((i - 1) * dx, (j - 1) * dy, dx, dy);
        }
    }*/
    
    //println(cells[50][50].height);
}
