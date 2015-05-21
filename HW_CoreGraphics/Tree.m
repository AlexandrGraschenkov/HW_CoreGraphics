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
{
    double width;
    double height;
    
}


- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    height = 256;
    width = 20;
    int red = 255;
    int green = 0;
    int blue = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableArray *branch = [NSMutableArray arrayWithObject:[[Points alloc] initWithPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)) angle:0]];
    NSMutableArray *branch2 = [NSMutableArray new];
    
    for (int count=0; count < 10; count++) {
        width /= 1.59;
        height /= 1.59;
        
        for (Points *p in branch) {
            CGContextMoveToPoint(context, p.point.x, p.point.y);
            
            CGPoint vector = CGPointMake(0, -height);
            vector = CGPointApplyAffineTransform(vector, CGAffineTransformMakeRotation(p.angle));
            CGPoint endPoint = CGPointMake(p.point.x + vector.x, p.point.y + vector.y);
            
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            
            Points *np1 = [[Points alloc] initWithPoint:endPoint angle:p.angle + 0.35];
            Points *np2 = [[Points alloc] initWithPoint:endPoint angle:p.angle - 0.35];
            
            [branch2 addObject:np1];
            [branch2 addObject:np2];
            
        }
        
        UIColor *textColor= [UIColor colorWithRed:(red) green:(green) blue:(blue) alpha:1] ;
        red -=50;
        
        CGContextSetStrokeColorWithColor(context, textColor.CGColor);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
        branch = branch2;
        branch2 = [NSMutableArray new];
    }
    
}
//позже попробую доделать
//- (void)addApple:(NSArray*)points{
//    UIImage *apple = [UIImage imageNamed:@"apple"];
//}
@end
