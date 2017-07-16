//
//  ViewController.h
//  Unscrambler
//
//  Created by Naveen on 5/1/17.
//  Copyright (c) 2017 Naveen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"
#import "OptionsController.h"

@interface ViewController : UIViewController
@property (strong) NSMutableArray *listWords;
@property (weak, nonatomic) IBOutlet TestView *testView;
@property (weak, nonatomic) IBOutlet UITextField *ansLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet UIButton *ansBtn;
@property (nonatomic) int gridCnt;
@property (nonatomic) NSString *ridCnt;
@property (weak, nonatomic) IBOutlet UICollectionView *wordCollection;
- (IBAction)stopBtnPressed:(id)sender;
- (IBAction)ansBtnPressed:(id)sender;
- (void)fillCircle;
- (void)resetCorrectBtn;
- (void)resetWrongBtn;

@end