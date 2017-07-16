//
//  TestView.m
//  
//
//  Created by Naveen on 4/29/17.
//
//

#import "TestView.h"

@interface TestView () {
    CGFloat startAngle;
    CGFloat endAngle;
}

@end

@implementation TestView
@synthesize percent;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        // Determine our start and stop angles for the arc (in radians)
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Display our percentage as a string
    NSString* textContent = [NSString stringWithFormat:@"%d", percent];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    NSLog(@" %f %f",rect.size.width / 2, rect.size.height / 2);
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:20
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (percent / 100.0) + startAngle
                       clockwise:YES];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 20;
    [[UIColor redColor] setStroke];
    [bezierPath stroke];
    
    // Text Drawing
    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 71/2.0, (rect.size.height / 2.0) - 45/2.0, 25, 25);
    [[UIColor blackColor] setFill];
//    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 42.5] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
//    [textContent dr]
    UIFont *font2 = [UIFont fontWithName:@"Helvetica-Bold" size: 42.5];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys: font2, NSFontAttributeName, [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    [textContent drawAtPoint:CGPointMake(textRect.origin.x, textRect.origin.y) withAttributes:attrsDictionary];
}
@end