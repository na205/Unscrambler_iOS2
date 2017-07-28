//
//  MaintainPoints.m
//  
//
//  Created by Naveen on 7/15/17.
//
//

#import "MaintainPoints.h"
#import "NSMutableArray+Shuffling.h"
#import "NSString+SortExtension.h"

@interface MaintainPoints()
@end

@implementation MaintainPoints
@synthesize gridC;
@synthesize usedWords;
@synthesize acronymWords;
@synthesize actualWords;
@synthesize acronymDicto;
@synthesize finalDicto;
@synthesize alphas;
@synthesize midStr;
@synthesize ansWords;
@synthesize ansString;
@synthesize shuffWords;
+ (instancetype)sharedInstance {
    static MaintainPoints *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MaintainPoints alloc] init];
    });
    return sharedInstance;
}
- (void)setGridCnt:(int)cnt {
    gridC = cnt;
}
- (int)getGridCnt {
    return gridC;
}
- (void)addlatestWord:(NSString*)string {
    if(usedWords == nil)
        usedWords = [[NSMutableArray alloc] initWithCapacity:0];
    [usedWords addObject:string];
}

- (void)runFirstMethod {
    NSLog(@"runFirstMethod");
    alphas = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    finalDicto = [[NSMutableDictionary alloc] initWithCapacity:0];
    usedWords = [[NSMutableArray alloc] initWithCapacity:0];
    shuffWords = [[NSMutableArray alloc] initWithCapacity:0];
    NSString* filePath = @"answers";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    NSString* fileCnts = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
    NSArray* allLinedStrings = [fileCnts componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    actualWords = [[NSMutableArray alloc] initWithArray:allLinedStrings];
    NSLog(@"count is %lu",(unsigned long)[allLinedStrings count]);
    for(int i=0;i<[allLinedStrings count];++i) {
        NSArray* myArray = [[allLinedStrings objectAtIndex:i] componentsSeparatedByString:@" "];
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:myArray];
        [tempArr removeLastObject];
        [finalDicto setObject:tempArr forKey:[myArray objectAtIndex:0]];
        [shuffWords addObject:[myArray objectAtIndex:0]];
    }
}

- (void)runInputMethod {
    ansWords = [[NSMutableArray alloc] initWithCapacity:0];
    [shuffWords shuffle];
    for(id keyWord in shuffWords) {
        if([keyWord length] == gridC && [usedWords indexOfObject:keyWord] == NSNotFound) {
            ansString = [[NSString alloc] initWithString:keyWord];
            int mxId=0, mxCh=0;
            NSMutableArray *tempArr = (NSMutableArray*)[finalDicto objectForKey:keyWord];
            int wcnt[26] = {0};
            for(int j=0;j<[tempArr count];++j) {
                const char *c = [[tempArr objectAtIndex:j] UTF8String];
                int ccnt[26]={0};
                for(int k=0;k<strlen(c);++k) {
                    if(ccnt[c[k]-'A'] == 0) {
                        ccnt[c[k]-'A']=1;
                    }
                }
                for(int k=0;k<26;++k) {
                    wcnt[k]+=ccnt[k];
                }
            }
            for(int j=0;j<26;++j) {
                if(wcnt[j] > mxCh) {
                    mxCh = wcnt[j];
                    mxId = j;
                }
            }
            midStr = [[NSString alloc] initWithString:[alphas objectAtIndex:mxId]];
            for(int j=0;j<[tempArr count];++j) {
                NSString *keyWord = [tempArr objectAtIndex:j];
                if([keyWord rangeOfString:midStr].location != NSNotFound) {
                    [ansWords addObject:keyWord];
                }
            }
            [usedWords addObject:ansString];
            NSRange range = [ansString rangeOfString:midStr];
            NSString *tempStr = [NSString stringWithFormat:@"%@%@",[ansString substringWithRange:NSMakeRange(0, range.location)],[ansString substringWithRange:NSMakeRange(range.location+1, [ansString length]-range.location-1)]];
            NSString *scrambled = [NSString scrambleString:tempStr];
            NSString *tempAns = [NSString stringWithFormat:@"%@%@",midStr,scrambled];
            ansString = [[NSString alloc] initWithString:tempAns];
            break;
        }
    }
}
- (NSMutableArray*)getAnsWordArray {
    return ansWords;
}
- (NSString*)getAnsString {
    return ansString;
}

@end