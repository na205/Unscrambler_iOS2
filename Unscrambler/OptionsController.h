//
//  OptionsController.h
//  
//
//  Created by Naveen on 7/15/17.
//
//

#import "ViewController.h"

@interface OptionsController : UIViewController
- (IBAction)gameBtnPressed:(id)sender;
- (IBAction)scoreBtnPressed:(id)sender;
- (IBAction)levelBtnPressed:(id)sender;
- (IBAction)exitBtnPressed:(id)sender;
- (IBAction)instructPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *instrLabel;

- (IBAction)sliderChanged:(id)sender;
@end
