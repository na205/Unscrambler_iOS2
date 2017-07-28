//
//  NSString+SortExtension.m
//  
//
//  Created by Naveen on 7/16/17.
//
//

#import "NSString+SortExtension.h"

@implementation NSString (SortExtension)

- (NSString *)sorted {
    NSUInteger length = [self length];
    unichar *chars = (unichar *)malloc(sizeof(unichar) * length);
    [self getCharacters:chars range:NSMakeRange(0, length)];
    qsort_b(chars, length, sizeof(unichar), ^(const void *l, const void *r) {
        unichar left = *(unichar *)l;
        unichar right = *(unichar *)r;
        return (int)(left - right);
    });
    NSString *sorted = [NSString stringWithCharacters:chars length:length];
    return sorted;
}
+ (NSString *)scrambleString:(NSString *)toScramble {
    for (int i = 0; i < [toScramble length] * 15; i ++) {
        int pos = arc4random() % [toScramble length];
        int pos2 = arc4random() % ([toScramble length] - 1);
        char ch = [toScramble characterAtIndex:pos];
        NSString *before = [toScramble substringToIndex:pos];
        NSString *after = [toScramble substringFromIndex:pos + 1];
        NSString *temp = [before stringByAppendingString:after];
        before = [temp substringToIndex:pos2];
        after = [temp substringFromIndex:pos2];
        toScramble = [before stringByAppendingFormat:@"%c%@", ch, after];
    }
    return toScramble;
}
@end