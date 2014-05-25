//
//  DRBCodeRunner.h
//  DRobot
//
//  Created by Daniel Bradford on 5/3/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRBCodeRunnerDelegate <NSObject>

-(bool)performSelectorOnRobot:(SEL)theSelector;
-(void)codeHadSyntaxError;
-(void)didFinishRunning;

@end

@interface DRBCodeRunner : NSObject
@property (weak, nonatomic) id <DRBCodeRunnerDelegate> delegate;

-(void)runCode;

@end
