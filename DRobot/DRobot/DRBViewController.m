//
//  DRBViewController.m
//  DRobot
//
//  Created by Daniel Bradford on 4/14/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBViewController.h"
#import "DRBBoardView.h"
#import "DRBRobotView.h"
#import "DRBEditProgramViewController.h"
#import "DRBCodeRunner.h"


@interface DRBViewController () <UINavigationBarDelegate, UIGestureRecognizerDelegate, DRBEditProgramViewControllerDelegate, DRBCodeRunnerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonEditProgram;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonRunProgram;
@property (weak, nonatomic) IBOutlet DRBBoardView *boardView;

@property (strong, nonatomic) DRBRobotView *robotView;

@property (strong, nonatomic, readonly) DRBCodeRunner *codeRunner;

@end

@implementation DRBViewController

NSString * const strTurnLeft = @"turnLeft";

float const kStartingPositionX = 84;
float const kStartingPositionY = 94;
float const kVerticalSpacing = 150;
float const kHorizontalSpacing = 100;
float const kRobotRadius = 15;

@synthesize robotView = _robotView;
@synthesize codeRunner = _codeRunner;

-(DRBCodeRunner*)codeRunner
{
    if(! _codeRunner)
        _codeRunner = [[DRBCodeRunner alloc] init];
    return _codeRunner;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navBar.delegate = self;
    self.codeRunner.delegate = self;
    
 
    self.boardView.startingPosition = CGPointMake(kStartingPositionX, kStartingPositionY);
    self.boardView.verticalSpacing = kVerticalSpacing;
    self.boardView.horizontalSpacing = kHorizontalSpacing;
   
    
    //self.robotView = [[DRBRobotView alloc] initWithFrame:CGRectMake(605, 640, kVerticalSpacing, kHorizontalSpacing)];
    self.robotView = [[DRBRobotView alloc] initWithFrame:CGRectMake(kStartingPositionX, kStartingPositionY, kVerticalSpacing, kHorizontalSpacing)];
    self.robotView.translatesAutoresizingMaskIntoConstraints = NO;
    self.robotView.radius = kRobotRadius;
    
    [self.boardView addSubview:self.robotView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DRBEditProgramViewController class]]) {
        DRBEditProgramViewController *vc = (DRBEditProgramViewController*) segue.destinationViewController;
        vc.delegate = self;
    }
}


#pragma mark - UI control events



- (IBAction)runProgram:(UIBarButtonItem *)sender {

    self.navItem.title = [self.navItem.title stringByAppendingString:@" - Running"];
    [self.codeRunner runCode];
}

- (IBAction)editProgram:(UIBarButtonItem *)sender {
}

#pragma mark - UINavigationBarDelegate
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

#pragma mark - DRBEditProgramViewControllerDelegate
-(void)didFinishEditingSource
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DRBCodeRunnerDelegate
-(bool)performSelectorOnRobot:(SEL)theSelector
{
    BOOL didCrash = NO;
    [self.robotView performSelector:theSelector];
    
    if (self.robotView.center.x < kStartingPositionX || self.robotView.center.x > 609) {
        didCrash = YES;
    }
    else if(self.robotView.center.y < kStartingPositionY || self.robotView.center.y > 644)
    {
        didCrash = YES;
    }
    
    if (didCrash) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Crash" message:@"Your program has crashed!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [self resetRobot];
        [av show];
    }
    
    return !didCrash;
}

-(void)codeHadSyntaxError
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Syntax Error" message:@"Your program has a syntax error!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self resetRobot];
    [av show];

}

-(void)didFinishRunning
{
    self.navItem.title = @"DRobot - Finished!";
    [UIView animateWithDuration:1.5 delay:5.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self resetRobot];
    } completion:^(BOOL finished) {
        self.navItem.title = @"DRobot";
    }];
}

-(void)resetRobot
{
    self.robotView.frame = CGRectMake(kStartingPositionX, kStartingPositionY, kVerticalSpacing, kHorizontalSpacing);
    [self.robotView resetDirectionEast];
}


@end
