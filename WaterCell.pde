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
    
    PVector momentum;
    float midpointHeight;
    PVector midpointMomentum;
    
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
        
        // TODO: remove these eventually; it's just so they're initialized to something
        midpointHeight = 0;
        midpointMomentum = new PVector(0, 0);
    }
    
    void update() {
        float currentHeight = height;
        /*println(previousCellHorizontal.height);    // null when j = 200
        println(previousCellVertical.height);        // not null when j = 200
        println(nextCellHorizontal.height);            // not null when j = 200
        println(nextCellVertical.height);            // not null when j = 200*/
        velocity += ((previousCellHorizontal.height + previousCellVertical.height + nextCellHorizontal.height + nextCellVertical.height) / 4 - height) / 8;
        velocity *= .99;
        height += velocity;
        
        if (height > 12.75) {
            height = 12.75;
        }
        if (height < 0) {
            height = 0;
        }
        
        heightDifference = height - currentHeight;
    }
    
    void updateHalfStep(float dt) {
        // I'm guessing this is what needs to be done since it's an average - but there are 2 heights to average from
        // the only change that might be needed is the average of the 2 next cells might need to be averaged separately and then averaged with the current cell height
        //midpointHeight = (height + nextCellHorizontal.height + nextCellVertical.height) / 3;
        midpointHeight = (height + ((nextCellHorizontal.height + nextCellVertical.height) / 2)) / 2;
        midpointHeight += -(dt / 2) * ((momentum.x - nextCellHorizontal.momentum.x) / dx) * ((momentum.y - nextCellVertical.momentum.y) / dy);
        
        midpointMomentum.x = (momentum.x + nextCellHorizontal.momentum.x) / 2 - (dt / 2) * (pow(nextCellHorizontal.momentum.x, 2) / nextCellHorizontal.height + .5
        * 9.8 * pow(nextCellHorizontal.height, 2) - pow(height, 2) / height - .5 * 9.8 * pow(height, 2)) / dx;
        midpointMomentum.y = (momentum.y + nextCellVertical.momentum.y) / 2 - (dt / 2) * (pow(nextCellVertical.momentum.y, 2) / nextCellVertical.height + .5
        * 9.8 * pow(nextCellVertical.height, 2) - pow(height, 2) / height - .5 * 9.8 * pow(height, 2)) / dx;
    }
    
    void updateFullStep(float dt) {
        // height, then momentum
        
        
        
        // TODO: not sure if the next cell piece is correct for each - I'm assuming so as this is the most logical thing
        height -= dt * ((midpointMomentum.x - previousCellHorizontal.midpointMomentum.x) / dx + (midpointMomentum.y - previousCellHorizontal.midpointMomentum.y) / dy);
        
        if (height < 0) {
            height = 0;
        }
        momentum.x -= dt * (pow(midpointMomentum.x, 2) / height + .5 * 9.8 * pow(midpointHeight, 2) - pow(previousCellHorizontal.midpointMomentum.x, 2) 
        / previousCellHorizontal.height - .5 * 9.8 * pow(previousCellHorizontal.height, 2)) / dx;
        momentum.y -= dt * (pow(midpointMomentum.y, 2) / height + .5 * 9.8 * pow(midpointHeight, 2) - pow(previousCellVertical.midpointMomentum.y, 2)
        / previousCellVertical.height - .5 * 9.8 * pow(previousCellVertical.height, 2)) / dx;
        
        
    }
}
