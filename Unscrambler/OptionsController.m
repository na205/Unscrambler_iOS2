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
    BOOL instrFlag;
    int swCounter;
}

@end

@implementation OptionsController
@synthesize sliderBtn;
@synthesize scoreLabel;
@synthesize instrLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    swCounter = 0;
    [sliderBtn setHidden:YES];
    [instrLabel setHidden:YES];
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
    gc+=5;
    [[MaintainPoints sharedInstance] setGridCnt:gc];
    [self presentViewController:objViewController animated:YES completion:nil];
}

- (IBAction)scoreBtnPressed:(id)sender {
    [instrLabel setHidden:YES];
    [sliderBtn setHidden:YES];
    if(swCounter != 1) {
        swCounter = 1;
        [scoreLabel setHidden:NO];
    } else {
        swCounter = 0;
        [scoreLabel setHidden:YES];
    }
    int highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Unscrambler_Score"] intValue];
    [scoreLabel setText:[NSString stringWithFormat:@"%d",highScore]];
}

- (IBAction)levelBtnPressed:(id)sender {
    [scoreLabel setHidden:YES];
    [instrLabel setHidden:YES];
    if(swCounter != 2) {
        swCounter = 2;
        [sliderBtn setHidden:NO];
    } else {
        swCounter = 0;
        [sliderBtn setHidden:YES];
    }
}

- (IBAction)instructPressed:(id)sender {
    [scoreLabel setHidden:YES];
    [sliderBtn setHidden:YES];
    if(swCounter != 3) {
        swCounter = 3;
        [instrLabel setHidden:NO];
    } else {
        swCounter = 0;
        [instrLabel setHidden:YES];
    }
}

- (IBAction)exitBtnPressed:(id)sender {
    exit(0);
}

- (IBAction)sliderChanged:(id)sender {
    long sliderValue;
    sliderValue = lroundf(sliderBtn.value);
    [sliderBtn setValue:sliderValue animated:YES];
}
@end
