//
//  MyTree.m
//  HW_CoreGraphics
//
//  Created by Евгений Сергеев on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "MyTree.h"
#import "Points.h"

@implementation MyTree


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    UIColor *backgroundColor = [UIColor greenColor];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    NSMutableArray *widthArr = [[NSMutableArray alloc] init];
    NSMutableArray *heightArr = [[NSMutableArray alloc] init];
    float startWidth = 12;
    float startHeight = 160;

    for(int k = 0; k<9; k++) {
        [widthArr addObject:[NSNumber numberWithFloat:startWidth]];
        [heightArr addObject:[NSNumber numberWithFloat:startHeight]];
        startWidth *= 0.63;
        startHeight *= 0.63;
    }
    
    NSMutableArray *points = [NSMutableArray arrayWithObject:[[Points alloc] initWithPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)) angle:0]];
    NSMutableArray *transferArr = [NSMutableArray new];
    
    
    for (int i = 0; i < 9; i++) {
        for (Points *p in points) {
            /* Start the line at this point */
            CGContextMoveToPoint(context, p.point.x, p.point.y);
            CGPoint vector = CGPointMake(0, -[heightArr[i] floatValue]);
            vector = CGPointApplyAffineTransform(vector, CGAffineTransformMakeRotation(p.angle));
            CGPoint endPoint = CGPointMake(p.point.x + vector.x, p.point.y + vector.y);
            /* And end it at this point */
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            Points *right = [[Points alloc] initWithPoint:endPoint angle:p.angle + 0.41];
            Points *left = [[Points alloc] initWithPoint:endPoint angle:p.angle - 0.41];
            [transferArr addObject:right];
            [transferArr addObject:left];
        }
        points = transferArr;
        transferArr = [NSMutableArray new];
        CGContextSetLineWidth(context, [widthArr[i] floatValue]);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextStrokePath(context);
    }
}

@end
