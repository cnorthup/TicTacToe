//
//  ViewController.m
//  TicTacToe
//
//  Created by Charles Northup on 3/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate, UIAlertViewDelegate>

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
    UILabel *removeLabel;

    CGPoint originPointOfPlayerLabelToBeDragged;
    IBOutlet UILabel *labelToBeDraggedByCurrentPlayer;
}
@property NSMutableArray *winCombos;


@end

@implementation ViewController

- (void)viewDidLoad
{
    originPointOfPlayerLabelToBeDragged = labelToBeDraggedByCurrentPlayer.center;
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

- (void)detectWhichLabel
{
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
    whichPlayer = !whichPlayer;
}


- (IBAction)onDrag:(UIPanGestureRecognizer *)panGesutreRecongizer{
    
    CGPoint dragCenterOfLabel = [panGesutreRecongizer translationInView:self.view];
    labelToBeDraggedByCurrentPlayer.transform = CGAffineTransformMakeTranslation(dragCenterOfLabel.x, dragCenterOfLabel.y);
    dragCenterOfLabel.y += labelToBeDraggedByCurrentPlayer.center.y;
    dragCenterOfLabel.x += labelToBeDraggedByCurrentPlayer.center.x;
    
//        if (panGesutreRecongizer.state == UIGestureRecognizerStateBegan && CGRectContainsPoint(labelToBeDraggedByCurrentPlayer.frame, dragCenterOfLabel)) {
            if (panGesutreRecongizer.state == UIGestureRecognizerStateEnded) {
                findLabelTapped = [panGesutreRecongizer locationInView:self.view];
                [self detectWhichLabel];
                labelToBeDraggedByCurrentPlayer.transform = CGAffineTransformMakeTranslation(0, 0);
                [panGesutreRecongizer setTranslation:CGPointMake(0, 0) inView:self.view];
                if (whichPlayer != YES) {
                    labelToBeDraggedByCurrentPlayer.text = @"X";
                    labelToBeDraggedByCurrentPlayer.backgroundColor = [UIColor blueColor];
                }else {
                labelToBeDraggedByCurrentPlayer.text = @"O";
                labelToBeDraggedByCurrentPlayer.backgroundColor = [UIColor redColor];
                }
            }
}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecongizer
{
    findLabelTapped = [tapGestureRecongizer locationInView:self.view];
    [self detectWhichLabel];
}

-(void)whoWon{
    NSString *winnerP;
    NSString *youSuck;
    if (whichPlayer) {
        winnerP = @"Player 1 WON";
        youSuck = @"Player 2 SUCKS";
    }
    else{
        winnerP = @"Player 2 WON";
        youSuck = @"Player 1 SUCKS";
    }
    UIAlertView *gameWon = [[UIAlertView alloc] initWithTitle:winnerP message:youSuck delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Replay", nil];
    [gameWon show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 || buttonIndex == 0) {
        [self viewDidLoad];
        for (UILabel *resetColorAndText in labels) {
            resetColorAndText.text = nil;
            resetColorAndText.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(void)checkIndex:(int)index
{
    if (index != 3) {
        gameIndex = 0;
    }
    if (gameIndex == 3) {
        [self whoWon];
    }
}


- (void)forLoop
{
    if (whichPlayer) {
        for (NSMutableArray* arrayTwo in _winCombos) {
            for (UILabel* label in arrayTwo) {
                if ([playerOneLabels containsObject:label]) {
                    gameIndex++;
                }
            
            }
            [self checkIndex:gameIndex];
            NSLog(@"player 1, %d",gameIndex);
            //if([playerOneLabels containsObject:didWin]){
            // NSLog(@"WIN");
        }
    }
        else{
            for (NSMutableArray* arrayTwo in _winCombos) {
                for (UILabel* label in arrayTwo) {
                    if ([playerTwoLabels containsObject:label]) {
                        gameIndex++;
                    }
                }
                [self checkIndex:gameIndex];
                NSLog(@"player 2, %d",gameIndex);
            }
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
