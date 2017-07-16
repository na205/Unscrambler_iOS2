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
    alphas = [[NSMutableArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    acronymDicto = [[NSMutableDictionary alloc] initWithCapacity:0];
    usedWords = [[NSMutableArray alloc] initWithCapacity:0];
    acronymWords = [[NSMutableArray alloc] initWithCapacity:0];
    NSString* filePath = @"words";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    NSString* fileCnts = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
    NSArray* allLinedStrings = [fileCnts componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    actualWords = [[NSMutableArray alloc] initWithArray:allLinedStrings];
    for(int i=0;i<[allLinedStrings count];++i) {
        NSString *tempWord = sort_str([allLinedStrings objectAtIndex:i]);
        [acronymDicto setObject:[allLinedStrings objectAtIndex:i] forKey:tempWord];
        [acronymWords addObject:tempWord];
        NSLog(@"sorted %@",tempWord);
    }
    [actualWords shuffle];
    for(int i=0;i<[actualWords count];++i) {
        NSString *keyWord = sort_str([actualWords objectAtIndex:i]);
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
        for(int j=0;j<[acronymWords count];++j) {
            NSString *valueWord = [acronymWords objectAtIndex:j];
            if([keyWord rangeOfString:valueWord].location != NSNotFound) {
                [tempArr addObject:[acronymDicto valueForKey:valueWord]];
            }
        }
        if([tempArr count] > 1) {
            NSLog(@"finished2 %@",keyWord);
            [finalDicto setObject:tempArr forKey:keyWord];
        }
    }
    NSLog(@"finished %@",finalDicto);
}

- (void)runInputMethod {
    ansWords = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0;i<[actualWords count];++i) {
        NSString *keyWord = [actualWords objectAtIndex:i];
        if([keyWord length] == gridC && [usedWords indexOfObject:keyWord] == NSNotFound) {
            if([finalDicto objectForKey:keyWord]) {
                ansString = [[NSString alloc] initWithString:[finalDicto objectForKey:keyWord]];
                int mxId=0, mxCh=0;
                NSMutableArray *tempArr = (NSMutableArray*)[finalDicto objectForKey:keyWord];
                int wcnt[26] = {0};
                for(int j=0;j<[tempArr count];++j) {
                    const char *c = [[tempArr objectAtIndex:j] UTF8String];
                    int ccnt[26]={0};
                    for(int k=0;k<strlen(c);++i) {
                        if(ccnt[c[k]-'a']==0) {
                            ccnt[c[k]-'a']=1;
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
                NSRange range = [ansString rangeOfString:midStr];
                NSString *tempAns = [NSString stringWithFormat:@"%@%@%@",midStr,[ansString substringWithRange:NSMakeRange(0, range.location-1)],[ansString substringWithRange:NSMakeRange(range.location+1, [ansString length])]];
                ansString = [[NSString alloc] initWithString:tempAns];
            }
        }
    }
}

- (NSString*)getAnsString {
    return ansString;
}

int char_compare(const char* a, const char* b) {
    if(*a < *b) {
        return -1;
    } else if(*a > *b) {
        return 1;
    } else {
        return 0;
    }
}

NSString *sort_str(NSString *unsorted) {
    int len = (int)[unsorted length] + 1;
    char *cstr = malloc(len);
    [unsorted getCString:cstr maxLength:len encoding:NSISOLatin1StringEncoding];
    qsort(cstr, len - 1, sizeof(char), char_compare);
    NSString *sorted = [NSString stringWithCString:cstr encoding:NSISOLatin1StringEncoding];
    free(cstr);
    return sorted;
}
@end