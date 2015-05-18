//
//  Points.h
//  Tree
//
//  Created by Михаил on 01.05.14.
//  Copyright (c) 2014 Михаил. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Points : NSObject

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) float angle;

- (id)initWithPoint:(CGPoint)point angle:(float)angle;

@end
