//
//  OptionsController.m
//  
//
//  Created by Naveen on 7/15/17.
//
//

#import "OptionsController.h"
#import "MaintainPoints.h"

@interface OptionsController () {
    BOOL scoreFlag;
    BOOL levelFlag;
}

@end

@implementation OptionsController
@synthesize sliderBtn;
@synthesize scoreLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    scoreFlag = false;
    levelFlag = false;
    [sliderBtn setHidden:YES];
    [scoreLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gameBtnPressed:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *objViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    int gc = (int)[sliderBtn value];
    gc+=4;
    [[MaintainPoints sharedInstance] setGridCnt:gc];
    [self presentViewController:objViewController animated:YES completion:nil];
}

- (IBAction)scoreBtnPressed:(id)sender {
    [sliderBtn setHidden:YES];
    scoreFlag = !scoreFlag;
    if(scoreFlag)
        [scoreLabel setHidden:NO];
    else
        [scoreLabel setHidden:YES];
    
    int highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Unscrambler_Score"] intValue];
    [scoreLabel setText:[NSString stringWithFormat:@"%d",highScore]];
}

- (IBAction)levelBtnPressed:(id)sender {
    [scoreLabel setHidden:YES];
    levelFlag = !levelFlag;
    if(levelFlag)
        [sliderBtn setHidden:NO];
    else
        [sliderBtn setHidden:YES];
}

- (IBAction)exitBtnPressed:(id)sender {
}

- (IBAction)sliderChanged:(id)sender {
    long sliderValue;
    sliderValue = lroundf(sliderBtn.value);
    [sliderBtn setValue:sliderValue animated:YES];
}
@end
