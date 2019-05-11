// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 3;
final float dy = 3;

final int cellCountHorizontal = 396;
final int cellCountVertical = 558;
//final int cellCountHorizontal = 132;
//final int cellCountVertical = 186;
final float maxHeight = 255;

WaterCell[][] cells = new WaterCell[cellCountHorizontal + 2][cellCountVertical + 2]; 

color test = color(0);

PImage image; 

void setup() {
    size(396, 558, P2D);
    image = loadImage("testLarge.png");
    noStroke();

    // set up a default WaterCell for each cell
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j] = new WaterCell(30, 0);
            //cells[i][j] = new WaterCell(0, 0);
        }
    }

    // the edge cells that always stay 0 for height
    for (int i = 0; i < cellCountHorizontal + 2; i++) {
        cells[i][0] = new WaterCell(0, 0);                       
        cells[i][cellCountVertical + 1] = new WaterCell(0, 0);
    }

    for (int j = 0; j < cellCountVertical + 2; j++) {
        cells[0][j] = new WaterCell(0, 0);
        cells[cellCountHorizontal + 1][j] = new WaterCell(0, 0);
    }

    // previous/next cells
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].nextCellHorizontal = cells[i + 1][j];
        }
    }

    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].previousCellHorizontal = cells[i - 1][j];
        }
    }

    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].nextCellVertical = cells[i][j + 1];
        }
    }

    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].previousCellVertical = cells[i][j - 1];
        }
    }

    /*for(int i = 20; i < 50; i++) {
     for(int j = 25; j < 60; j++) {
     cells[i][j].height = 0;
     }
     }*/
     
     cells[50][50].height = 0.003;
     cells[66][93].height = 0.002;
     cells[100][20].height = 0.002;
     cells[25][120].height = 0.003;
     cells[15][15].height = 0.002;
     cells[60][30].height = 0.002;
     cells[30][45].height = 0.002;
     cells[90][75].height = 0.002;
     cells[105][30].height = 0.002;
     cells[60][120].height = 0.002;
     cells[120][150].height = 0.002;
     cells[105][175].height = 0.002;
     cells[20][60].height = 0.002;
     cells[50][20].height = 0.002;
     cells[70][100].height = 0.002;
     cells[0][0].height = 0.002;
     cells[1][0].height = 0.002;
     cells[350][200].height = 0.002;
     cells[200][200].height = 0.002;
     cells[100][375].height = 0.002;
     cells[100][500].height = 0.002;
     cells[200][150].height = 0.002;
     cells[300][400].height = 0.002;
     cells[0][500].height = 0.002;
     cells[100][20].height = 0.002;
     cells[75][500].height = 0.002;
     

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
    /*cells[100][100].height = .055;
     cells[50][150].height = .055;
     cells[24][40].height = .055;
     cells[15][10].height = .055;*/
    //cells[175][50].height = .55;
    /*cells[25][125].height = .4;
     cells[3][20].height = .35;
     cells[100][50].height = .35;
     cells[40][70].height = .4;
     cells[41][70].height = .4;
     cells[42][70].height = .4;
     cells[101][50].height = .4;
     cells[75][30].height = .5;*/

    /*cells[4][20].height = .55;
     cells[100][51].height = .55;
     cells[40][71].height = .4;
     cells[41][71].height = .55;
     cells[42][71].height = .55;
     cells[101][51].height = .4;
     cells[75][31].height = .4;*/

    /*cells[4][21].height = .8;
     cells[100][52].height = .8;
     cells[40][72].height = .8;
     cells[41][72].height = .8;
     cells[42][72].height = .8;
     cells[101][52].height = .8;
     cells[75][32].height = .8;*/

    /* cells[5][20].height = .8;
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
     cells[79][32].height = .8;*/

    /*cells[130][100].height = .8;
     cells[120][80].height = .55;
     cells[110][75].height = .8;
     cells[80][100].height = .55;
     cells[120][40].height = .55;*/

    loadPixels();
    image.loadPixels();

    for (int i = 0; i < image.width; i++) {
        for (int j = 0; j < image.height; j++) {
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
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            //println(i);
            //println(j);
            cells[i][j].update();
        }
    }

    // get total height around cell
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {

            /*float redTotal = 0;
            float greenTotal = 0;
            float blueTotal = 0;

            for (int k = 0; k < 3; k++) {
                for (int l = 0; l < 3; l++) {
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
            */
            
            cells[i][j].averageColor = pixels[(i - 1) + (j - 1) * width];

            // never is true
            /*if (redTotal <= 0 && greenTotal <= 0 && blueTotal <= 0) {
                println("small color totals");
            }*/

            // TODO: may not want to include the edge cells in the calculation of the color as that'll make the edges get really dark since that color is black 

            if (cells[i + 1][j + 1] == null) {
                println("bottom right null");
            }

            cells[i][j].totalAdjacentHeight = cells[i - 1][j].heightDifference + cells[i + 1][j].heightDifference + 
                                              cells[i][j - 1].heightDifference + cells[i][j + 1].heightDifference +
                                              cells[i - 1][j - 1].heightDifference + cells[i + 1][j + 1].heightDifference +
                                              cells[i - 1][j + 1].heightDifference + cells[i + 1][j - 1].heightDifference;
                                              
        }
    }

    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            float topCellHeightPercentage = cells[i][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomCellHeightPercentage = cells[i][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float leftCellHeightPercentage = cells[i - 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
            float rightCellHeightPercentage = cells[i + 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
            float topLeftCellHeightPercentage = cells[i - 1][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomLeftCellHeightPercentage = cells[i - 1][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float topRightCellHeightPercentage = cells[i + 1][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomRightCellHeightPercentage = cells[i + 1][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;

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
            color topLeftColor = cells[i - 1][j - 1].averageColor;
            color bottomLeftColor = cells[i - 1][j + 1].averageColor;
            color topRightColor = cells[i + 1][j - 1].averageColor;
            color bottomRightColor = cells[i + 1][j + 1].averageColor;

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
            
            float topLeftRed = red(topLeftColor) * topLeftCellHeightPercentage;
            float topLeftGreen = green(topLeftColor) * topLeftCellHeightPercentage;
            float topLeftBlue = blue(topLeftColor) * topLeftCellHeightPercentage;
            
            float bottomLeftRed = red(bottomLeftColor) * bottomLeftCellHeightPercentage;
            float bottomLeftGreen = green(bottomLeftColor) * bottomLeftCellHeightPercentage;
            float bottomLeftBlue = blue(bottomLeftColor) * bottomLeftCellHeightPercentage;
            
            float topRightRed = red(topRightColor) * topRightCellHeightPercentage;
            float topRightGreen = green(topRightColor) * topRightCellHeightPercentage;
            float topRightBlue = blue(topRightColor) * topRightCellHeightPercentage;
            
            float bottomRightRed = red(bottomRightColor) * bottomRightCellHeightPercentage;
            float bottomRightGreen = green(bottomRightColor) * bottomRightCellHeightPercentage;
            float bottomRightBlue = blue(bottomRightColor) * bottomRightCellHeightPercentage;

            // top left
            if (i == 1 && j == 1) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(bottomRed + rightRed + bottomRightRed, 
                                                                      bottomGreen + rightGreen + bottomRightGreen, 
                                                                      bottomBlue + rightBlue + bottomRightBlue);
                if (bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                    println("0 values");
                }
            // bottom left
            } else if (i == 1 && j == cellCountVertical) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + rightRed + topRightRed, 
                                                                      topGreen + rightGreen + topRightGreen, 
                                                                      topBlue + rightBlue + topRightBlue);
                if (topRed == 0 && topGreen == 0 && topBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                    println("0 values");
                }
            // top right  
            } else if (i == cellCountHorizontal && j == 1) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(bottomRed + leftRed + bottomLeftRed, 
                                                                      bottomGreen + leftGreen + bottomLeftGreen, 
                                                                      bottomBlue + leftBlue + bottomLeftBlue);
                if (bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0) {
                    println("0 values");
                }
            // bottom right    
            } else if (i == cellCountHorizontal && j == cellCountVertical) {

                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + leftRed + topLeftRed, 
                                                                      topGreen + leftGreen + topLeftGreen, 
                                                                      topBlue + leftBlue + topLeftBlue);
                if (topRed == 0 && topGreen == 0 && topBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0) {
                    println("0 values");
                }
            // top row
            } else if (i == 1) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(leftRed + rightRed + bottomRed + bottomLeftRed + bottomRightRed,
                                                                      leftGreen + rightGreen + bottomGreen + bottomLeftGreen + bottomRightGreen,
                                                                      leftBlue + rightBlue + bottomBlue + bottomLeftBlue + bottomRightBlue);
            }
            // bottom row
            else if (i == cellCountHorizontal) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(leftRed + rightRed + topRed + topLeftRed + topRightRed,
                                                                      leftGreen + rightGreen + topGreen + topLeftGreen + topRightGreen,
                                                                      leftBlue + rightBlue + topRightBlue + topLeftBlue + topRightBlue);
            }
            
            // left column
            else if (j == 1) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + bottomRed + rightRed + topRightRed + bottomRightRed,
                                                                      topGreen + bottomGreen + rightGreen + topRightGreen + bottomRightGreen,
                                                                      topBlue + bottomBlue + rightBlue + topRightBlue + bottomRightBlue);
            }
            
            // right column
            else if (j == cellCountVertical) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + bottomRed + leftRed + topLeftRed + bottomLeftRed,
                                                                      topGreen + bottomGreen + leftGreen + topLeftGreen + bottomLeftGreen,
                                                                      topBlue + bottomBlue + leftBlue + topLeftBlue + bottomLeftBlue);
            // everything in the middle
            } else {
                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + bottomRed + leftRed + rightRed + topLeftRed + topRightRed + bottomLeftRed + bottomRightRed, 
                                                                      topGreen + bottomGreen + leftGreen + rightGreen + topLeftGreen + topRightGreen + bottomLeftGreen + bottomRightGreen, 
                                                                      topBlue + bottomBlue + leftBlue + rightBlue + topLeftBlue + topRightBlue + bottomLeftBlue + bottomRightBlue);


                if (topRed == 0 && topGreen == 0 && topBlue == 0 || leftRed == 0 && leftGreen == 0 && leftBlue == 0
                    || bottomRed == 0 && bottomGreen == 0 && bottomBlue == 0 || rightRed == 0 && rightGreen == 0 && rightBlue == 0) {
                    //println("0 values");

                    // most of the 0 values are coming from this
                    //return;
                }
            }

            //println(red(cells[i][j].adjacentCellsColorWeightedAverage));
            color interpolated = lerpColor(cells[i][j].adjacentCellsColorWeightedAverage, cells[i][j].averageColor, 0.8);

            cells[i][j].averageColor = interpolated;
        }
    }


    for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
            int pixelLocation = i + j * width;

            float red = red(pixels[pixelLocation]);
            float green = green(pixels[pixelLocation]);
            float blue = blue(pixels[pixelLocation]);

            
            //color cellColor = cells[i / 3 + 1][j / 3 + 1].averageColor;
            color cellColor = cells[i + 1][j + 1].averageColor;

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
