//
//  Points.h
//  Tree
//
//  Created by Айдар on 13.11.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Points : NSObject

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) float angle;

- (id)initWithPoint:(CGPoint)point angle:(float)angle;

@end
