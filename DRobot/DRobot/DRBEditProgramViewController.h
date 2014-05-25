//
//  DRBEditProgramViewController.h
//  DRobot
//
//  Created by Daniel Bradford on 4/22/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DRBEditProgramViewControllerDelegate <NSObject>

-(void)didFinishEditingSource;

@end


@interface DRBEditProgramViewController : UIViewController
@property (weak, nonatomic) id <DRBEditProgramViewControllerDelegate> delegate;
@end
