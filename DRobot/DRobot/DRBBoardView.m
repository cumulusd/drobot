//
//  DRBBoardView.m
//  DRobot
//
//  Created by Daniel Bradford on 4/27/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBBoardView.h"

@implementation DRBBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self z_drawLinesWithStartingPosition:self.startingPosition.x andDistanceBetweenLines:self.verticalSpacing inVerticalDirection:YES withOppositeDirectionRestrainingValue:self.startingPosition.y];
    [self z_drawLinesWithStartingPosition:self.startingPosition.y andDistanceBetweenLines:self.horizontalSpacing inVerticalDirection:NO withOppositeDirectionRestrainingValue:self.startingPosition.x];
    
//    CGPoint center;
//    center.x = self.startingPosition.x + (self.verticalSpacing / 2);
//    center.y = self.startingPosition.y + (self.horizontalSpacing / 2);
//    [self z_drawStartingPointAtPosition:center];
}

-(void)z_drawLinesWithStartingPosition:(float)starting andDistanceBetweenLines:(float)distanceBetween inVerticalDirection:(BOOL)verticalDirection withOppositeDirectionRestrainingValue:(float)oppositePositionRestrainingValue
{
    float restrainingValue = 0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGSize viewsize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapSquare;
    
    [[UIColor blackColor] set];
    
    if (verticalDirection)
        restrainingValue = viewsize.width;
    else
        restrainingValue = viewsize.height;
    
    
    float currentPosition = 0;
    for (currentPosition = starting; (starting) <= (restrainingValue -  currentPosition); currentPosition += distanceBetween) {
        if (verticalDirection) {
            [path moveToPoint:CGPointMake(currentPosition, oppositePositionRestrainingValue)];
            [path addLineToPoint:CGPointMake(currentPosition, viewsize.height - oppositePositionRestrainingValue)];
        }
        else
        {
            [path moveToPoint:CGPointMake(oppositePositionRestrainingValue, currentPosition)];
            [path addLineToPoint:CGPointMake(viewsize.width - oppositePositionRestrainingValue, currentPosition)];
        }
    }
    
    [path stroke];

}


@end
