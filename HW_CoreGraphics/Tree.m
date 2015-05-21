//
//  Tree.m
//  HW_CoreGraphics
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "Tree.h"
#import "Points.h"

@implementation Tree

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int i = 10;
    double nowWidth;
    double nowHeight;
    
    nowHeight = self.bounds.size.height / 3.95 * 1.7;
    nowWidth = self.bounds.size.width / 34 * 1.5;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    NSMutableArray *points1 = [NSMutableArray arrayWithObject:[[Points alloc] initWithPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)) angle:0]];
    NSMutableArray *points2 = [NSMutableArray new];
    
    while (i > 0) {
        nowWidth /= 1.6;
        nowHeight /= 1.6;
        int k =0;
        for (Points *p in points1) {
            
            NSLog(@"%d", k);
            k++;
            CGContextMoveToPoint(context, p.point.x, p.point.y);
            
            CGPoint vector = CGPointMake(0, -nowHeight);
            vector = CGPointApplyAffineTransform(vector, CGAffineTransformMakeRotation(p.angle));
            CGPoint endPoint = CGPointMake(p.point.x + vector.x, p.point.y + vector.y);
            
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            
            Points *np1 = [[Points alloc] initWithPoint:endPoint angle:p.angle + 0.35];
            Points *np2 = [[Points alloc] initWithPoint:endPoint angle:p.angle - 0.35];
            
            [points2 addObject:np1];
            [points2 addObject:np2];
        
        }
        
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, nowWidth);
        CGContextStrokePath(context);
        
        points1 = points2;
        points2 = [NSMutableArray new];
        i--;
        
    }
}

@end
