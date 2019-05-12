// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

// Once shallow water cell
class WaterCell {
    float height;
    float velocity;
    
    // used in color calculations
    float totalAdjacentHeightDifference;
    float heightDifference = 0;
    color averageColor = color(0);
    color adjacentCellsColorWeightedAverage = color(0);
    
    // how to access nearby cells
    WaterCell previousCellHorizontal;
    WaterCell previousCellVertical;
    WaterCell nextCellHorizontal;
    WaterCell nextCellVertical;


    WaterCell(float height, float velocity) {
        this.height = height;
        this.velocity = velocity;
    }
    
    // Where the "hacky" shallow water algorithm happens
    void update() {
        float currentHeight = height;

        // the * 3 is to help it move faster and what looked good - just some additional tuning
        velocity += ((previousCellHorizontal.height + previousCellVertical.height + nextCellHorizontal.height + nextCellVertical.height) / 4 - height) * 3;
        
        // it's .2 because of tuning for the specific use of the algorithm
        velocity *= .2;
        height += velocity;
        
        // these height ranges are to match a range that can scale to what one RGB component can hold
        if (height > 12.75) {
            height = 12.75;
        }
        if (height < 0) {
            height = 0;
        }
        
        heightDifference = height - currentHeight;
    }
}
