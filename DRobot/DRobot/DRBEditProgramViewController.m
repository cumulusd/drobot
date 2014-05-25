//
//  DRBEditProgramViewController.m
//  DRobot
//
//  Created by Daniel Bradford on 4/22/14.
//  Copyright (c) 2014 Daniel Bradford. All rights reserved.
//

#import "DRBEditProgramViewController.h"
#import "DRBSourceCodeManager.h"

@interface DRBEditProgramViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonDone;
@property (weak, nonatomic) IBOutlet UITextView *txtSource;

@end

@implementation DRBEditProgramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txtSource.text = [DRBSourceCodeManager getSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Events

- (IBAction)didPressDoneButton:(UIBarButtonItem *)sender
{
    [DRBSourceCodeManager saveSource:self.txtSource.text];
    
    [self.delegate didFinishEditingSource];
}

-(void)testing:(NSString*)source
{
    NSString *localSource = [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray *commands = [[localSource componentsSeparatedByString:@";"] mutableCopy];
    
    [commands enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = (NSString*)obj;
        [commands setObject:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndexedSubscript:idx] ;
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
