//
//  StickAreaView.m
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "StickAreaView.h"


@implementation StickAreaView

const CGFloat StickAreaViewPadding = 10.f;

const NSInteger StickAreaViewSections = 10;

- (void)drawRect:(CGRect)rect {
    
    CGFloat paddingMiddle = StickAreaViewPadding / 2.f;
    
    CGFloat width  = CGRectGetMaxX(rect);
    CGFloat height = CGRectGetMaxY(rect);
    
    CGFloat midWidth  = width / 2.f;
    CGFloat midHeight = height / 2.f;
    
    CGFloat sizeSection = width / (CGFloat)StickAreaViewSections;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
  
    // Sections
    for(int i = 0; i < StickAreaViewSections; i++) {
        
        CGFloat offset = i * sizeSection;
        CGFloat center = offset / 2.f + paddingMiddle;
        
        CGRect circleRect = CGRectMake(center,
                                       center,
                                       width - offset - StickAreaViewPadding,
                                       height - offset - StickAreaViewPadding);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextStrokeEllipseInRect(context, circleRect);
    }
    
    CGContextSetLineWidth(context, 15.f);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetAlpha(context, .3f);
    
    //Vertical line
    CGContextMoveToPoint(context, midWidth, 0.f);
    CGContextAddLineToPoint(context, midWidth, height);
    CGContextDrawPath(context, kCGPathStroke);
    
    //Horizonal line
    CGContextMoveToPoint(context, 0.f, midHeight);
    CGContextAddLineToPoint(context, width, midHeight);
    CGContextDrawPath(context, kCGPathStroke);
}

- (StickAreaView*)areaView {
    
    return self;
}

- (StickView*)stickView {
    
    return (StickView*)[self.subviews firstObject];
}

@end
