//
//  DRBSourceCodeManager.h
//  DRobot
//
//  Created by Daniel Bradford on 4/29/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRBSourceCodeManager : NSObject
+(NSString*)getSource;
+(void)saveSource:(NSString*)source;
@end
