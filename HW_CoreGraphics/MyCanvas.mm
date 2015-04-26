//
//  MyCanvas.m
//  HW_CoreGraphics
//
//  Created by Артур Сагидулин on 22.04.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//
#include <vector>
#import "MyCanvas.h"
#define hCOEFFICIENT 0.66f

using namespace std;

@implementation MyCanvas

static inline float radians(double degrees) { return degrees * M_PI / 180; }

static inline void getTreePoints( vector<CGPoint> &vec,CGPoint startPoint,int depth, int height,double angle,int dAngle, float width){
    
    if (depth<=0) return;
    vec.push_back(startPoint);
    
    CGPoint left = CGPointMake(startPoint.x + cos(radians(angle + dAngle))*height,
                               startPoint.y + sin(radians(angle + dAngle))*height);
    
    vec.push_back(left);
    vec.push_back( CGPointMake(0, width) );
    
    getTreePoints(vec,left,depth-1,height*hCOEFFICIENT, angle + dAngle,dAngle*1.03,width*hCOEFFICIENT);

    vec.push_back(startPoint);
    
    CGPoint right = CGPointMake(startPoint.x + cos(radians(angle - dAngle))*height,
                                startPoint.y + sin(radians(angle - dAngle))*height);
    
    vec.push_back(right);
    vec.push_back( CGPointMake(0, width));
    
    getTreePoints(vec,right,depth-1,height*hCOEFFICIENT,angle - dAngle,dAngle*1.03,width*hCOEFFICIENT);
}

static inline vector<CGPoint> getTreePoints(int depth,float x,float y){
    vector<CGPoint> vec;
    float startLenght = 150;
    float startAngle = -90;
    float angleleBetweenBranches = 20;
    
    vec.push_back(CGPointMake(x, y));
    vec.push_back(CGPointMake(x, y-startLenght));
    vec.push_back(CGPointMake(0,12.f));
    
    CGPoint startPoint = CGPointMake(x, y-startLenght);
    getTreePoints(vec,startPoint,depth,startLenght*hCOEFFICIENT,startAngle,angleleBetweenBranches,6);
    return vec;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    UIColor *backgroundColor = [UIColor colorWithRed:134./255. green:1.0 blue:40./255. alpha:1];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    float startWidth = 12.;
    float medium =self.bounds.size.width/2.;
    float bottom = self.bounds.size.height;
    
    vector<CGPoint> vec = getTreePoints(10,medium,bottom);
    
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, startWidth);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    
    for( int i = 0; i < vec.size(); i+=3){
        CGPoint p = vec[i];
        CGContextMoveToPoint(context, p.x,p.y);
        p = vec[i+1];
        CGContextAddLineToPoint(context, p.x, p.y);
        
        p = vec[i+2];
        startWidth = p.y;
        
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, startWidth);
        
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
    
}

@end


