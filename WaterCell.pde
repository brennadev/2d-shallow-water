// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

class WaterCell {
    float height;
    float velocity;
    int velocityXDirection;    // 1 if to the right, -1 if to the left, 0 if none
    int velocityYDirection;    // 1 if to the bottom, -1 if to the top, 0 if none
    
    float totalAdjacentHeight;
    float heightDifference = 0;
    color averageColor = color(0);
    color adjacentCellsColorWeightedAverage = color(0);
    

    
    WaterCell previousCellHorizontal;
    WaterCell previousCellVertical;
    WaterCell nextCellHorizontal;
    WaterCell nextCellVertical;
    
    WaterCell(float height, PVector momentum) {
        this.height = height;
        this.momentum = momentum;
        
        // just so they're initialized to something - will get set properly on the first update call in the draw loop
        midpointHeight = 0;
        midpointMomentum = new PVector(0, 0);
    }
    
    WaterCell(float height, float velocity) {
        this.height = height;
        this.velocity = velocity;
    }
    
    void update() {
        float currentHeight = height;
        /*println(previousCellHorizontal.height);    // null when j = 200
        println(previousCellVertical.height);        // not null when j = 200
        println(nextCellHorizontal.height);            // not null when j = 200
        println(nextCellVertical.height);            // not null when j = 200*/
        velocity += ((previousCellHorizontal.height + previousCellVertical.height + nextCellHorizontal.height + nextCellVertical.height) / 4 - height) * 3;
        velocity *= .2;
        height += velocity;
        
        if (height > 12.75) {
            height = 12.75;
        }
        if (height < 0) {
            height = 0;
        }
        
        heightDifference = height - currentHeight;
    }
}
