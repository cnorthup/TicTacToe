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
    NSMutableArray *playerOneLabels;
    NSMutableArray *playerTwoLabels;
    NSMutableArray *winCombination1;
    NSMutableArray *winCombination2;
    NSMutableArray *winCombination3;
    NSMutableArray *winCombination4;
    NSMutableArray *winCombination5;
    NSMutableArray *winCombination6;
    NSMutableArray *winCombination7;
    NSMutableArray *winCombination8;
    int gameIndex;
}
@property NSMutableArray *winCombos;


@end

@implementation ViewController

- (void)viewDidLoad
{
    gameIndex = 0;
    winCombination1 = [[NSMutableArray alloc] initWithObjects:myLabelOne, myLabelTwo, myLabelThree, nil];
    winCombination2 = [[NSMutableArray alloc] initWithObjects:myLabelOne, myLabelFour, myLabelSeven, nil];
    winCombination3 = [[NSMutableArray alloc] initWithObjects:myLabelOne, myLabelFive, myLabelNine, nil];
    winCombination4 = [[NSMutableArray alloc] initWithObjects:myLabelTwo, myLabelFive, myLabelEight, nil];
    winCombination5 = [[NSMutableArray alloc] initWithObjects:myLabelThree, myLabelSix, myLabelNine, nil];
    winCombination6 = [[NSMutableArray alloc] initWithObjects:myLabelThree, myLabelFive, myLabelSeven, nil];
    winCombination7 = [[NSMutableArray alloc] initWithObjects:myLabelFour, myLabelFive, myLabelSix, nil];
    winCombination8 = [[NSMutableArray alloc] initWithObjects:myLabelSeven, myLabelEight, myLabelNine, nil];
    _winCombos = [[NSMutableArray alloc] initWithObjects:winCombination8, winCombination7, winCombination6, winCombination5, winCombination4, winCombination3, winCombination2, winCombination1, nil];
    
    labels =[[NSMutableArray alloc] initWithObjects:myLabelOne, myLabelTwo, myLabelThree, myLabelFour, myLabelFive, myLabelSix, myLabelSeven, myLabelEight, myLabelNine, nil];
    playerOneLabels = [[NSMutableArray alloc] initWithObjects: nil];
    playerTwoLabels = [[NSMutableArray alloc] initWithObjects: nil];
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
    if (whichPlayer) {
        whichPlayerLabel.text = @"Player2";
        whichPlayerLabel.backgroundColor = [UIColor blueColor];
        [playerOneLabels addObject:removeLabel];
        [labels removeObject:removeLabel];
        
    }
    else{
        whichPlayerLabel.text = @"Player1";
        whichPlayerLabel.backgroundColor = [UIColor redColor];
        [playerTwoLabels addObject:removeLabel];
        [labels removeObject:removeLabel];
    }
    [self forLoop];
    //NSLog(@"%@", _winCombos);
    //NSLog(@"%@", playerOneLabels);
    //SLog(@"%@", playerTwoLabels);
   // NSLog(@"%@", labels);
    
    whichPlayer = !whichPlayer;
    
}

-(void)checkIndex:(int)index
{
    if (index != 3) {
        gameIndex = 0;
    }
}


- (void)forLoop
{
    for (NSMutableArray* arrayTwo in _winCombos) {
        for (UILabel* label in arrayTwo) {
            if ([playerOneLabels containsObject:label]) {
                gameIndex++;
            }
            if ([playerTwoLabels containsObject:label]) {
                gameIndex++;
            }
        }
        [self checkIndex:gameIndex];
         NSLog(@"%d",gameIndex);
        //if([playerOneLabels containsObject:didWin]){
        // NSLog(@"WIN");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
