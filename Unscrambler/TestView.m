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
@synthesize gridCnt;
@synthesize rectArray;

- (void)drawRect:(CGRect)rect {
    
    gridCnt = [[MaintainPoints sharedInstance] getGridCnt];
    NSLog(@"hello %d",gridCnt);
    rectArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGFloat orgx = rect.size.width/2;
    CGFloat orgy = rect.size.height/2;
    CGFloat radO = 120;
    CGFloat radI = 40;
    CGFloat radM = 85;
    CGFloat labWidth = 30;
    CGFloat labHeight = 30;
    CGFloat ang = (2.0/gridCnt)*M_PI;
    CGFloat ang_temp = ang;
    CGFloat ang_mid = ang/2.0;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(orgx, orgy)
                          radius:radO
                      startAngle:(1.5*M_PI)
                        endAngle:(3.5*M_PI)
                       clockwise:YES];
    bezierPath.lineWidth = 2;
    [[UIColor blackColor] setStroke];
    [bezierPath stroke];
    
    UIBezierPath* bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 addArcWithCenter:CGPointMake(orgx, orgy)
                          radius:radI
                      startAngle:(1.5*M_PI)
                        endAngle:(3.5*M_PI)
                       clockwise:YES];
    bezierPath2.lineWidth = 2;
    [[UIColor blackColor] setStroke];
    [bezierPath2 stroke];
    [rectArray addObject:[NSValue valueWithCGRect:CGRectMake(orgx-9, orgy-14, labWidth, labHeight)]];
    for(int i=1;i<=gridCnt;++i) {
        ang = i*ang_temp;
        CGFloat oxU = orgx+radO*sin(ang);
        CGFloat oyU = orgx+radO*cos(ang);
        
        CGFloat oxI = orgx+radI*sin(ang);
        CGFloat oyI = orgx+radI*cos(ang);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(oxU, oyU)];
        [path addLineToPoint:CGPointMake(oxI, oyI)];
        path.lineWidth = 2;
        [[UIColor blackColor] setStroke];
        [path stroke];
        CGFloat oxM = orgx+radM*sin(ang+ang_mid);
        CGFloat oyM = orgx+radM*cos(ang+ang_mid);
        [rectArray addObject:[NSValue valueWithCGRect:CGRectMake(oxM-10, oyM-10, labWidth, labHeight)]];
    }
}
@end