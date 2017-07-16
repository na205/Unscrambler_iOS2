//
//  NSMutableArray+Shuffling.m
//  
//
//  Created by Naveen on 7/16/17.
//
//

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle {
    NSUInteger count = [self count];
    for (uint i = 0; i < count - 1; ++i) {
        int nElements = (int)count - i;
        int n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}
@end