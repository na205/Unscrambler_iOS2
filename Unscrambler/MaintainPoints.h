//
//  MaintainPoints.h
//  
//
//  Created by Naveen on 7/15/17.
//
//

#import <UIKit/UIKit.h>

@interface MaintainPoints : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic) int gridC;
@property (nonatomic) NSMutableArray *usedWords;
@property (nonatomic) NSMutableArray *acronymWords;
@property (nonatomic) NSMutableDictionary *acronymDicto;
@property (nonatomic) NSMutableDictionary *finalDicto;
@property (nonatomic) NSMutableArray *actualWords;
@property (nonatomic) NSMutableArray *alphas;
@property (nonatomic) NSMutableArray *ansWords;
@property (nonatomic) NSMutableArray *shuffWords;
@property (nonatomic) NSString *midStr;
@property (nonatomic) NSString *ansString;
- (void)setGridCnt:(int)cnt;
- (int)getGridCnt;
- (NSString*)getAnsString;
- (void)addlatestWord:(NSString*)string;
- (void)runFirstMethod;
- (void)runInputMethod;
- (NSMutableArray*)getAnsWordArray;
@end

