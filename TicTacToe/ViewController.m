//
//  ViewController.m
//  TicTacToe
//
//  Created by Charles Northup on 3/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *myLabelOne;
    IBOutlet UILabel *myLabelTwo;
    IBOutlet UILabel *myLabelThree;
    IBOutlet UILabel *myLabelFour;
    IBOutlet UILabel *myLabelFive;
    IBOutlet UILabel *myLabelSix;
    IBOutlet UILabel *myLabelSeven;
    IBOutlet UILabel *myLabelEight;
    IBOutlet UILabel *myLabelNine;
    IBOutlet UILabel *whichPlayerLabel;
    CGPoint findLabelTapped;
    bool whichPlayer;
    NSMutableArray *labels;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    labels =[[NSMutableArray alloc] initWithObjects:myLabelOne, myLabelTwo, myLabelThree, myLabelFour, myLabelFive, myLabelSix, myLabelSeven, myLabelEight, myLabelNine, nil];
    whichPlayerLabel.text = @"Player 1";
    whichPlayerLabel.backgroundColor = [UIColor redColor];
    [whichPlayerLabel sizeToFit];
    whichPlayer = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)writeLabel:(UILabel *)label
{
    if (whichPlayer == YES) {
        label.text = @"O";
        label.backgroundColor = [UIColor redColor];
    }else{
        label.text = @"X";
        label.backgroundColor = [UIColor blueColor];
    }
}



- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecongizer
{
    UILabel *removeLabel;
    findLabelTapped = [tapGestureRecongizer locationInView:self.view];
    for (UILabel* foundLabel in labels) {
        if (CGRectContainsPoint(foundLabel.frame, findLabelTapped)) {
            [self writeLabel:foundLabel];
            removeLabel = foundLabel;
        }
    }
    [labels removeObject:removeLabel];
    whichPlayer = !whichPlayer;
    if (whichPlayer) {
        whichPlayerLabel.text = @"Player2";
        whichPlayerLabel.backgroundColor = [UIColor blueColor];
    }
    else{
        whichPlayerLabel.text = @"Player1";
        whichPlayerLabel.backgroundColor = [UIColor redColor];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
