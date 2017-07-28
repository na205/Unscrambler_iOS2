//
//  ViewController.m
//  Unscrambler
//
//  Created by Naveen on 5/1/17.
//  Copyright (c) 2017 Naveen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UIAlertViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    NSTimer *mytimer;
    NSString *ansHold;
    NSInteger myScore;
    BOOL firstVis;
    int fixedCount;
}

@end

@implementation ViewController
@synthesize testView;
@synthesize listWords;
@synthesize ansWords;
@synthesize labelArr;
@synthesize scoreLabel;
@synthesize possLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    firstVis = false;
    _gridCnt = [[MaintainPoints sharedInstance] getGridCnt];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textField.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.5)
                             range:NSMakeRange(0, textField.text.length)];
    textField.attributedText = attributedString;
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self fillCircle];
}

- (void)targetMethod {
    int secTime = [[_secLabel text] intValue];
    int minTime = [[_minLabel text] intValue];
    secTime+=1;
    if(secTime <= 9) {
        [_secLabel setText:[NSString stringWithFormat:@"0%d",secTime]];
    } else if(secTime > 59) {
        [_secLabel setText:@"00"];
        minTime+=1;
        if(minTime <= 9)
            [_minLabel setText:[NSString stringWithFormat:@"0%d",minTime]];
        else if(minTime > 59)
            [_minLabel setText:@"00"];
        else
            [_minLabel setText:[NSString stringWithFormat:@"%d",minTime]];
    } else {
        [_secLabel setText:[NSString stringWithFormat:@"%d",secTime]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fillCircle {
    NSLog(@"fillCircle");
//    [testView setNeedsDisplay];
    [[MaintainPoints sharedInstance] runInputMethod];
    ansWords = [[NSMutableArray alloc] initWithArray:[[MaintainPoints sharedInstance] getAnsWordArray]];
    fixedCount = 0;
    if([ansWords count] > 15) {
        fixedCount = 15;
    } else {
        fixedCount = (int)[ansWords count];
    }
    listWords = [[NSMutableArray alloc] initWithCapacity:0];
    [_wordCollection reloadData];
    [possLabel setText:[NSString stringWithFormat:@"%d",fixedCount]];
    NSString *tempAns = [[MaintainPoints sharedInstance] getAnsString];
    NSLog(@"answords2 %@",ansWords);
    [_secLabel setText:@"00"];
    [_minLabel setText:@"00"];
    [scoreLabel setText:@"0"];
    [_ansLabel setText:@""];
    mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(targetMethod)
                                             userInfo:nil
                                              repeats:YES];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[testView rectArray]];
    NSLog(@"input is %@",tempAns);
    for(int i=0;i<[array count];++i) {
        CGRect rect = [[array objectAtIndex:i] CGRectValue];
        UILabel *gridLabel = [[UILabel alloc] initWithFrame:rect];
        gridLabel.text = [tempAns substringWithRange:NSMakeRange(i,1)];
        gridLabel.font=[UIFont systemFontOfSize:25.0];
        gridLabel.textColor=[UIColor blackColor];
        gridLabel.textAlignment=NSTextAlignmentCenter;
        gridLabel.backgroundColor=[UIColor clearColor];
        [testView addSubview:gridLabel];
    }
}

- (IBAction)stopBtnPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"No network connection %d",0]
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:self
                                          cancelButtonTitle:@"NEXT GAME"
                                          otherButtonTitles:@"MAIN MENU",nil];
    [alert show];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [listWords count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//        NSLog(@"collectionView2");
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"wordCell" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    label.text = [listWords objectAtIndex:[indexPath row]];
    [label setFont: [label.font fontWithSize:12]];
    [cell.contentView addSubview:label];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 30);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [mytimer invalidate];
    mytimer = nil;
    if(buttonIndex == [alertView cancelButtonIndex]) {
        for(UILabel *view in testView.subviews) {
            [view removeFromSuperview];
        }
        [self fillCircle];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:(int)myScore] forKey:@"Unscrambler_Score"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *objOptionsController = [mainStoryboard instantiateViewControllerWithIdentifier:@"OptionsController"];
        [self presentViewController:objOptionsController animated:YES completion:nil];
    }
}

- (void)resetCorrectBtn {
    sleep(1);
    if([listWords indexOfObject:ansHold] == NSNotFound) {
        [listWords addObject:ansHold];
        int val = (int)[ansHold length];
        if(val == _gridCnt) {
            myScore += 100;
        } else {
            int diff = (_gridCnt - val)*10;
            myScore += (80-diff);
        }
        [scoreLabel setText:[NSString stringWithFormat:@"%ld",(long)myScore]];
    }
    UIImage *btnImage = [UIImage imageNamed:@"proceed2.jpeg"];
    [_ansBtn setImage:btnImage forState:UIControlStateNormal];
    [self performSelectorOnMainThread:@selector(resetAnsLabel) withObject:self waitUntilDone:YES];
}

- (void)resetAnsLabel {
    [_wordCollection reloadData];
    [_ansLabel setText:@""];
    if([listWords count] >= fixedCount) {
        for(UILabel *view in testView.subviews) {
            [view removeFromSuperview];
        }
        [self fillCircle];
    }
}

- (void)resetWrongBtn {
    sleep(1);
    UIImage *btnImage = [UIImage imageNamed:@"proceed2.jpeg"];
    [_ansBtn setImage:btnImage forState:UIControlStateNormal];
}

- (IBAction)ansBtnPressed:(id)sender {
    ansHold = [[NSString alloc] initWithString:[[_ansLabel text] uppercaseString]];
    if([ansWords indexOfObject:ansHold] != NSNotFound) {
        [NSThread detachNewThreadSelector:@selector(resetCorrectBtn) toTarget:self withObject:nil];
        UIImage *btnImage = [UIImage imageNamed:@"correct.jpeg"];
        [_ansBtn setImage:btnImage forState:UIControlStateNormal];
    } else {
        UIImage *btnImage = [UIImage imageNamed:@"wrong.jpeg"];
        [_ansBtn setImage:btnImage forState:UIControlStateNormal];
        [NSThread detachNewThreadSelector:@selector(resetWrongBtn) toTarget:self withObject:nil];
    }
}
@end