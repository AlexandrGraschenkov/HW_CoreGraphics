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
    NSArray *arr;
    
    float const width = self.bounds.size.width;
    float const height = self.bounds.size.height;
    float const thumbRadius = 10;
    float const valueWidth = 300;
    float xCenter = (width - valueWidth) / 2.0 + valueWidth * 1;
    
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
        for (Points *p in points1) {
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
        
        if (i == 2) arr = points2;
        
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, nowWidth);
        CGContextStrokePath(context);
        
        points1 = points2;
        points2 = [NSMutableArray new];
        i--;
    
    }
    
    int c = 0;
    for (Points *s in arr) {
        if (c % 50 == 0) {
            [self addApple:&context xCenter:s.point.x yCenter:s.point.y];
        }
        c++;
    }
    [self addApple:&context xCenter:xCenter - thumbRadius yCenter:height / 2.0 - thumbRadius];
    
}

-(void)addApple: (CGContextRef *)context xCenter: (float)xCenter yCenter: (float)yCenter
{
    CGContextSetFillColorWithColor(*context, [UIColor yellowColor].CGColor);
    CGContextFillEllipseInRect(*context, CGRectMake(xCenter, yCenter, 24, 24));
    
}

@end
