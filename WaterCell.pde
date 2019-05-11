// Copyright 2019 Brenna Olson. You may download this code for informational purposes only.

class WaterCell {
    float height;
    float velocity;
    
    float totalAdjacentHeight;
    float heightDifference = 0;
    color averageColor = color(0);
    color adjacentCellsColorWeightedAverage = color(0);
    
    PVector momentum;
    
    WaterCell previousCellHorizontal;
    WaterCell previousCellVertical;
    WaterCell nextCellHorizontal;
    WaterCell nextCellVertical;


    WaterCell(float height, float velocity) {
        this.height = height;
        this.velocity = velocity;
    }
    
    void update() {
        float currentHeight = height;

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
