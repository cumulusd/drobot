//
//  DRBRobotView.m
//  DRobot
//
//  Created by Daniel Bradford on 4/27/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBRobotView.h"

@interface DRBRobotView()
@property (nonatomic) enum CompassDirection currentDirection;
@property (nonatomic) CGPoint currentPosition;
@end

@implementation DRBRobotView

float const kVertSpacing = 150;
float const kHorizSpacing = 100;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        self.currentDirection = East;
    }
    return self;
}

@synthesize currentDirection = _currentDirection;
@synthesize currentDirectionString = _currentDirectionString;

-(void)setCurrentDirection:(CompassDirection)currentDirection
{
    _currentDirection = currentDirection;
    [self setNeedsDisplay];
}

-(NSString*)currentDirectionString
{
    if (_currentDirection == North) {
        return @"North";
    }
    else if(_currentDirection == South)
    {
        return @"South";
    }
    else if(_currentDirection == East)
    {
        return @"East";
    }
    else
    {
        return @"West";
    }
}

-(id)init
{
    self = [super init];
    if(self)
    {
        self.currentDirection = South;
    }
    return self;
}

-(void)turnLeft
{
    int current = self.currentDirection;
    current -= 1;
    if (current < 0) {
        current = 3;
    }
    self.currentDirection = current;
}

-(void)resetDirectionEast
{
    self.currentDirection = East;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint currentPosition =  CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    float xModifier = 0, yModifier = 0;
    int facingDirection = self.currentDirection;
    
    [[UIColor redColor] set];
    
    if (facingDirection == 0) {
        yModifier = -40;
    }
    else if(facingDirection == 1)
    {
        xModifier = 40;
    }
    else if (facingDirection == 2)
    {
        yModifier = 40;
    }
    else if (facingDirection == 3)
    {
        xModifier = -40;
    }
    
    path2.lineWidth = 5.0;
    
    [path moveToPoint:currentPosition];
    [path addArcWithCenter:currentPosition radius:self.radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    [path2 moveToPoint:currentPosition];
    [path2 addLineToPoint:CGPointMake(currentPosition.x + xModifier, currentPosition.y + yModifier)];
    
    
    [path fill];
    
    [path stroke];
    [path2 stroke];

}

-(void)move
{
    float xMove = 0, yMove = 0;
    
    if (self.currentDirection == North || self.currentDirection == South) {
        yMove = kHorizSpacing;
        if (self.currentDirection == North) {
            yMove *= -1;
        }
    }
    else{
        xMove = kVertSpacing;
        if (self.currentDirection == West) {
            xMove *= -1;
        }
    }
    
    [UIView animateWithDuration:2.0 animations:^{
        self.frame = CGRectMake(self.frame.origin.x  + xMove, self.frame.origin.y + yMove, self.frame.size.width, self.frame.size.height);
    }];

}


@end
