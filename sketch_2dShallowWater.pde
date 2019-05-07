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
    cells[100][100].height = .55;
    cells[50][150].height = .55;
    cells[24][40].height = .55;
    cells[15][10].height = .55;
    //cells[175][50].height = .55;
    cells[25][125].height = .55;
}


void draw() {
    
    
    // I think the actual image stuff can go in setup since then after that, I don't want to be working off the original image
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
            //color colorTotal = color(0, 0, 0);
            
            float redTotal = 0;
            float greenTotal = 0;
            float blueTotal = 0;
            
            for(int k = 0; k < 3; k++) {
                for(int l = 0; l < 3; l++) {
                    int pixel = pixels[(i - 1) * 3 + k +((j - 1) * 3 + l) * width];
                    redTotal += red(pixel);
                    greenTotal += green(pixel);
                    blueTotal += blue(pixel);
                    //colorTotal += color(red(pixel), green(pixel), blue(pixel));
                    //println(red(colorTotal));
                }
            }
            
            color colorTotal = color(redTotal, greenTotal, blueTotal);
            color cellAverageColor = colorTotal / 9;
            /*if (red(colorTotal) > 255) {
                println("red greater than 255");
            }*/
            
            cells[i][j].totalAdjacentHeight = cells[i - 1][j].height + cells[i + 1][j].height + cells[i][j - 1].height + cells[i][j + 1].height;
        }
    }
    
    for(int i = 0; i < width; i++) {
        for(int j = 0; j < height; j++) {
            int pixelLocation = i + j * width;
            
            float red = red(pixels[pixelLocation]);
            float green = green(pixels[pixelLocation]);
            float blue = blue(pixels[pixelLocation]);
            
            
            
            pixels[pixelLocation] = color(red, green, blue);
        }
    }

    updatePixels();
    
    
    
    for(int i = 1; i < cellCountHorizontal + 1; i++) {
        for(int j = 1; j < cellCountVertical + 1; j++) {
        //rect(i * (dx / 5), maxHeight - (cells[i][j].height * 5), (dx / 5), cells[i][j].height * 5);
            //translate(i * (200 / dx), 0, j * (200 / dy));
            //box(dx, cells[i][j].height, dy);
            
            /*if (cells[i][j].height > 2.55) {
                println(cells[i][j].height);
            }*/
            
            /*if (cells[i][j].height < 0) {
                println(cells[i][j].height);
            }*/
            fill(cells[i][j].height * 100, 100);
            rect((i - 1) * dx, (j - 1) * dy, dx, dy);
        }
    }
    
    //println(cells[50][50].height);
}
