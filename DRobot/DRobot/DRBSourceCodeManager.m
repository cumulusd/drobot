//
//  DRBSourceCodeManager.m
//  DRobot
//
//  Created by Daniel Bradford on 4/29/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBSourceCodeManager.h"

@implementation DRBSourceCodeManager

NSString * const SOURCE_FILE_NAME = @"source.txt";

+(NSString*)getSource
{
    NSString *sourcePath = [self z_getPathToFile];
    return [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
}

+(void)saveSource:(NSString*)source
{
    NSError *error;
    BOOL result = [source writeToFile:[self z_getPathToFile] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (! result) {
        result = result;
    }
}

+(NSString*)z_getPathToFile
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    return [path stringByAppendingPathComponent:SOURCE_FILE_NAME];
}

@end
