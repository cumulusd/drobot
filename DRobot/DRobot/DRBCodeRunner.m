//
//  DRBCodeRunner.m
//  DRobot
//
//  Created by Daniel Bradford on 5/3/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBCodeRunner.h"
#import "DRBSourceCodeManager.h"

@interface DRBCodeRunner()
@property (copy, nonatomic) NSArray *codeToRun;
@property (strong, nonatomic) NSTimer *runTimer;
@property (assign, nonatomic) NSInteger index;
@end

@implementation DRBCodeRunner

@synthesize codeToRun = _codeToRun;

-(void)runCode
{
    [self z_parseCode];
    
    if (self.index == 0) {
        if (! [[self.codeToRun objectAtIndex:self.index] isEqualToString:@"begin"]) {
            [self.delegate codeHadSyntaxError];
        }
    }
    
    self.index = 1;
    [self z_timeToRunCode:nil];
    
    __weak id welf = self;
    self.runTimer = [NSTimer scheduledTimerWithTimeInterval:2.1 target:welf selector:@selector(z_timeToRunCode:) userInfo:nil repeats:YES];
    
}

-(void)z_timeToRunCode:(NSTimer*)timer
{
    NSString *currentCommand;
    
    if(self.index == ([self.codeToRun count] - 1))
    {
        [self.runTimer invalidate];
        self.runTimer = nil;

        if (! [[self.codeToRun objectAtIndex:self.index] isEqualToString:@"end"]) {
            [self.delegate codeHadSyntaxError];
        }
        
        [self.delegate didFinishRunning];
    }
    else{
        currentCommand = [self.codeToRun objectAtIndex:self.index];
        currentCommand = [currentCommand stringByReplacingOccurrencesOfString:@"(" withString:@""];
        currentCommand = [currentCommand stringByReplacingOccurrencesOfString:@")" withString:@""];
        if (! [self.delegate performSelectorOnRobot:NSSelectorFromString(currentCommand)])
        {
            [self.runTimer invalidate];
            self.runTimer = nil;
            [self.delegate didFinishRunning];

        }
    }

    self.index += 1;
    
}

-(void)z_parseCode
{
    NSString *source = [DRBSourceCodeManager getSource];
    NSString *localSource = [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *commands = [localSource componentsSeparatedByString:@";"];
    NSMutableArray *commandsToRun = [NSMutableArray array];
    
    [commands enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = (NSString*)obj;
        if ([str length]) {
            [commandsToRun addObject:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
    }];

    
    self.codeToRun = commandsToRun;
}


@end
