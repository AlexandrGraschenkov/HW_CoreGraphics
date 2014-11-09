//
//  TreeView.m
//  TreeGraphicsChanllenge
//
//  Created by Игорь Савельев on 09/11/14.
//  Copyright (c) 2014 Leonspok. All rights reserved.
//

/*#import "TreeView.h"

#define DEPTH 10
#define START_LENGTH 130
#define ANGLE M_PI/11

@implementation TreeView {
    NSArray *treeLayers;
    CALayer *maskLayer;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)buildView {
    CGVector (^rotateVector)(CGVector vector, CGFloat angle) = ^CGVector(CGVector vector, CGFloat angle) {
        CGVector vect = CGVectorMake(vector.dx*cos(angle)-vector.dy*sin(angle), vector.dx*sin(angle)+vector.dy*cos(angle));
        CGFloat vectorLength = sqrt(vect.dx*vect.dx+vect.dy*vect.dy);
        vect.dx /= vectorLength;
        vect.dy /= vectorLength;
        return vect;
    };
    
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:DEPTH];
    for (int i = 0; i < DEPTH; i++) {
        points[i] = [NSMutableArray arrayWithCapacity:(NSInteger)pow(2, i)];
    }
    points[0][0] = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height-START_LENGTH)];
    
    CGVector currentVector = CGVectorMake(0.0f, -1.0f);
    for (int i = 1; i < DEPTH; i++) {
        NSInteger scale = (NSInteger)pow(2, i);
        for (int j = 0; j < scale; j++) {
            if (i >= 2) {
                CGPoint startPoint = [points[i-2][j/4] CGPointValue];
                CGPoint endPoint = [points[i-1][j/2] CGPointValue];
                currentVector = CGVectorMake(endPoint.x-startPoint.x, endPoint.y-startPoint.y);
                BOOL left = (j/2%2 == 0);
                currentVector = rotateVector(currentVector, left? -ANGLE : ANGLE);
            }
            
            BOOL left = (j%2 == 0);
            
            CGFloat currentLength = START_LENGTH/pow(1.4, i);
            CGVector newVector = rotateVector(currentVector, left? -ANGLE : ANGLE);
            
            CGPoint previousPoint = [points[i-1][j/2] CGPointValue];
            CGPoint newPoint = CGPointMake(previousPoint.x+currentLength*newVector.dx, previousPoint.y+currentLength*newVector.dy);
            
            points[i][j] = [NSValue valueWithCGPoint:newPoint];
        }
    }
    
    NSArray *lineWidths = @[@10.0f, @8.0f, @6.0f, @4.0f, @2.5f, @1.5f, @1.0f, @0.5f, @0.25f];
    
    maskLayer = [CALayer layer];
    for (int i = 0; i < (NSInteger)pow(2, DEPTH-1); i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        NSInteger currentIndex = i;
        CGPoint currentPoint = [points[DEPTH-1][currentIndex] CGPointValue];
        
        CGPathMoveToPoint(path, NULL, currentPoint.x, currentPoint.y);
        
        for (int j = DEPTH-2; j >= 0; j--) {
            NSInteger nextIndex = currentIndex/2;
            CGPoint nextPoint = [points[j][nextIndex] CGPointValue];
            
            BOOL left = (currentIndex%2 == 0);
            CGVector sourceVector = CGVectorMake(nextPoint.x-currentPoint.x, nextPoint.y-currentPoint.y);
            CGVector rotatedVector = rotateVector(sourceVector, left? -ANGLE : ANGLE);
            
            CGFloat vectorLength = sqrt(sourceVector.dx*sourceVector.dx+sourceVector.dy*sourceVector.dy)/3;
            CGPoint bezierPoint = CGPointMake(currentPoint.x+vectorLength*rotatedVector.dx, currentPoint.y+vectorLength*rotatedVector.dy);
            
            UIBezierPath *subPath = [UIBezierPath bezierPath];
            [subPath moveToPoint:currentPoint];
            [subPath addQuadCurveToPoint:nextPoint controlPoint:bezierPoint];
            
            CGPathAddPath(path, NULL, CGPathCreateCopyByStrokingPath(subPath.CGPath, NULL, [lineWidths[j] doubleValue]/2, kCGLineCapRound, kCGLineJoinRound, 0.0f));
            
            currentIndex = nextIndex;
            currentPoint = nextPoint;
        }
        UIBezierPath *subPath = [UIBezierPath bezierPath];
        [subPath moveToPoint:currentPoint];
        [subPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height)];
        CGPathAddPath(path, NULL, CGPathCreateCopyByStrokingPath(subPath.CGPath, NULL, [lineWidths[0] doubleValue]/2, kCGLineCapRound, kCGLineJoinRound, 0.0f));
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setPath:path];
        [layer setStrokeColor:[UIColor blackColor].CGColor];
        [maskLayer addSublayer:layer];
    }
    [self.layer setMask:maskLayer];
}

- (void)animate {
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat locations[2] = { 0.0, 1.0 };
    
    NSArray *colors = @[(id)[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
                        (id)[UIColor colorWithRed:0.3f green:0.0f blue:0.7f alpha:1.0f].CGColor];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,(CFArrayRef)colors, locations);
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), rect.size.height);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, rect.size.height, 0);
}

@end*/
