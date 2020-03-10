//
//  MoveTwinAreaView.m
//  RemoteRobot
//
//  Created by roman on 21.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import "MoveTwinAreaView.h"
#import "MoveTwinStickView.h"


@implementation MoveTwinAreaView

const CGFloat MoveTwinAreaViewLineWidth = 10.f;
const CGFloat MoveTwinAreaViewAlpha = .5f;

- (void)drawRect:(CGRect)rect {
    
    CGFloat width  = CGRectGetMaxX(rect);
    CGFloat height = CGRectGetMaxY(rect);
    
    CGFloat midWidth = width / 2.f;
    CGFloat midHeight = height / 2.f;
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
 
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:.4980f green:.4980f blue:.4980f alpha:1].CGColor);
    CGContextSetLineWidth(context, MoveTwinAreaViewLineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //Horizontal line
    CGContextMoveToPoint(context, midWidth, 0.f + MoveTwinAreaViewLineWidth);
    CGContextAddLineToPoint(context, midWidth, height - MoveTwinAreaViewLineWidth);
    CGContextDrawPath(context, kCGPathStroke);
    
    //Vertical line
    CGContextSetLineWidth(context, MoveTwinAreaViewLineWidth / 2.f);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextMoveToPoint(context, midWidth - MoveTwinAreaViewLineWidth, midHeight);
    CGContextAddLineToPoint(context, midWidth + MoveTwinAreaViewLineWidth, midHeight);
    CGContextDrawPath(context, kCGPathStroke);
}

- (MoveTwinAreaView*)areaView {
    
    return self;
}

- (MoveTwinStickView*)stickView {
    
    return (MoveTwinStickView*)[self.subviews firstObject];
}

@end
