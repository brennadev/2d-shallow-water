// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

final float dx = 3;
final float dy = 3;

final int cellCountHorizontal = 396;
final int cellCountVertical = 558;
//final float maxHeight = 255;

WaterCell[][] cells = new WaterCell[cellCountHorizontal + 2][cellCountVertical + 2]; 

color test = color(0);

PImage image; 

void setup() {
    size(396, 558, P2D);
    image = loadImage("test4.png");
    noStroke();

    // set up a default WaterCell for each cell
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j] = new WaterCell(30, 0);
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

     // make the heights of some cells much less than the rest; these vales are just what worked well
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
     cells[110][50].height = 0.002;
     cells[40][75].height = 0.002;
     cells[390][500].height = 0.002;
     cells[390][550].height = 0.002;
     cells[300][420].height = 0.002;
     cells[300][300].height = 0.002;
     cells[350][400].height = 0.002;
     cells[0][100].height = 0.002;
     cells[0][50].height = 0.002;
     cells[0][400].height = 0.002;
     cells[0][250].height = 0.002;
     cells[250][0].height = 0.002;
     cells[300][0].height = 0.002;
     cells[100][10].height = 0.002;
     cells[200][10].height = 0.002;
     cells[150][15].height = 0.002;
     cells[200][20].height = 0.002;
     cells[100][20].height = 0.002;
     cells[300][50].height = 0.002;
     
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
    for(int i = 0; i < 4; i++) {
        updateWater();
    }
}


// make it easy to do multiple updates per frame
void updateWater() {
    
    loadPixels();


    // update heights of cells
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            cells[i][j].update();
        }
    }

    // get total height around cell
    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            
            cells[i][j].averageColor = pixels[(i - 1) + (j - 1) * width];

            cells[i][j].totalAdjacentHeight = cells[i - 1][j].heightDifference + cells[i + 1][j].heightDifference + 
                                              cells[i][j - 1].heightDifference + cells[i][j + 1].heightDifference +
                                              cells[i - 1][j - 1].heightDifference + cells[i + 1][j + 1].heightDifference +
                                              cells[i - 1][j + 1].heightDifference + cells[i + 1][j - 1].heightDifference;     
        }
    }

    for (int i = 1; i < cellCountHorizontal + 1; i++) {
        for (int j = 1; j < cellCountVertical + 1; j++) {
            
            // prevent division by 0 (as the program will keep running even with division by 0)
            if (cells[i][j].totalAdjacentHeight == 0) {
                continue;
            }
            
            float topCellHeightPercentage = cells[i][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomCellHeightPercentage = cells[i][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float leftCellHeightPercentage = cells[i - 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
            float rightCellHeightPercentage = cells[i + 1][j].heightDifference / cells[i][j].totalAdjacentHeight;
            float topLeftCellHeightPercentage = cells[i - 1][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomLeftCellHeightPercentage = cells[i - 1][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float topRightCellHeightPercentage = cells[i + 1][j - 1].heightDifference / cells[i][j].totalAdjacentHeight;
            float bottomRightCellHeightPercentage = cells[i + 1][j + 1].heightDifference / cells[i][j].totalAdjacentHeight;


            color topColor = cells[i][j - 1].averageColor;
            color bottomColor = cells[i][j + 1].averageColor;
            color leftColor = cells[i - 1][j].averageColor;
            color rightColor = cells[i + 1][j].averageColor;
            color topLeftColor = cells[i - 1][j - 1].averageColor;
            color bottomLeftColor = cells[i - 1][j + 1].averageColor;
            color topRightColor = cells[i + 1][j - 1].averageColor;
            color bottomRightColor = cells[i + 1][j + 1].averageColor;

            // multiply out the components
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

            // bottom left
            } else if (i == 1 && j == cellCountVertical) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + rightRed + topRightRed, 
                                                                      topGreen + rightGreen + topRightGreen, 
                                                                      topBlue + rightBlue + topRightBlue);

            // top right  
            } else if (i == cellCountHorizontal && j == 1) {
                cells[i][j].adjacentCellsColorWeightedAverage = color(bottomRed + leftRed + bottomLeftRed, 
                                                                      bottomGreen + leftGreen + bottomLeftGreen, 
                                                                      bottomBlue + leftBlue + bottomLeftBlue);
  
            // bottom right    
            } else if (i == cellCountHorizontal && j == cellCountVertical) {

                cells[i][j].adjacentCellsColorWeightedAverage = color(topRed + leftRed + topLeftRed, 
                                                                      topGreen + leftGreen + topLeftGreen, 
                                                                      topBlue + leftBlue + topLeftBlue);

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
            }

            color interpolated = lerpColor(cells[i][j].adjacentCellsColorWeightedAverage, cells[i][j].averageColor, 0.85);

            cells[i][j].averageColor = interpolated;
        }
    }


    for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
            int pixelLocation = i + j * width;

            color cellColor = cells[i + 1][j + 1].averageColor;

            float cellColorRed = red(cellColor);
            float cellColorGreen = green(cellColor);
            float cellColorBlue = blue(cellColor);

            pixels[pixelLocation] = color(cellColorRed, cellColorGreen, cellColorBlue);
        }
    }

    updatePixels();
}
