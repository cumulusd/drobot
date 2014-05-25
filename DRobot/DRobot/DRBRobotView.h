//
//  DRBRobotView.h
//  DRobot
//
//  Created by Daniel Bradford on 4/27/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CompassDirection)
{
    North = 0,
    East = 1,
    South = 2,
    West = 3
};


@interface DRBRobotView : UIView


@property (nonatomic, readonly) CompassDirection currentDirection;
@property (nonatomic, copy, readonly) NSString *currentDirectionString;
@property (nonatomic) float radius;

-(void)turnLeft;
-(void)move;
-(void)resetDirectionEast;

@end
