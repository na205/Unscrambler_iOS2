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
@end