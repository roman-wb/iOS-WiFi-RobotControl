//
//  StickView.m
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "StickView.h"
#import "StickAreaView.h"


@implementation StickView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillEllipseInRect(context, rect);
}

- (void)initDefault {
    
    _originCenter = self.center;
    _originAlpha = self.alpha;
    
    _areaMidX = CGRectGetMidX(self.areaView.bounds);
    _areaMidY = CGRectGetMidY(self.areaView.bounds);
    
    _maxValue = CGRectGetMidY(self.areaView.bounds);
    
    [self resetCommand];
}

- (void)storeOffsetWithLocation:(CGPoint)location {
    
    if(location.x > 0 || location.y > 0) {
        
        self.offset = CGPointMake(CGRectGetMidX(self.bounds) - location.x,
                                  CGRectGetMidY(self.bounds) - location.y);
    } else {
        
        self.offset = location;
    }
}

- (void)resetCommand {
    
    self.command =  @"L|S|250|100;R|S|250|100";
    
    [UIView animateWithDuration:.1f
                     animations:^{
                         self.center = self.originCenter;
                         self.alpha = self.originAlpha;
                     }];
}

- (CGPoint)correctionForLocation:(CGPoint)location {
    
    return CGPointMake(location.x + self.offset.x, location.y + self.offset.y);
}

- (void)moveToLocation:(CGPoint)location {
    
    // Correction with offset (only Y)
    CGPoint correction = [self correctionForLocation:location];
    
    //NSLog(@"OLD %@", NSStringFromCGPoint(correction));
    
    CGFloat distance = [self distanceBetweenPoint1:self.originCenter andPoint2:correction];
    
    if (distance > self.maxValue) {
        
        // CGFloat margin = distance - self.maxValue;
        
        // NSLog(@"Distance %f Margin %f", distance, margin);
        
        return;
    }
    
    [UIView animateWithDuration:.05f
                     animations:^{
                         self.center = correction;
                         self.alpha = .7f;
                     }];
    
    [self commandWithLocation:correction andDistance:distance];
}

- (void)commandWithLocation:(CGPoint)location andDistance:(CGFloat)distance {
   
    // Convert the customary coordinate system
    // invert with respect to X and minus 45 degrees
    CGFloat degrees = -GLKMathRadiansToDegrees(atan2(location.y - self.areaMidY,
                                                     location.x - self.areaMidX)) - 45;
    if(degrees < 0) {
        degrees = 360 - fabs(degrees);
    }

    //NSLog(@"Fixed Degrees: %f", degrees);

    if(degrees >= 0 && degrees <= 90) {
        self.command = @"L|F|250|100;R|F|250|100";
        return;
    }

    if(degrees >= 180 && degrees <= 270) {
        self.command = @"L|B|250|100;R|B|250|100";
        return;
    }

    if(degrees > 90 && degrees < 180) {
        self.command = @"L|B|250|100;R|F|250|100";
        return;
    }

    if(degrees > 270 && degrees < 360) {
        self.command = @"L|F|250|100;R|B|250|100";
        return;
    }
}


- (StickAreaView*)areaView {
    
    return (StickAreaView*)self.superview;
}

- (StickView*)stickView {
    
    return self;
}

- (CGFloat)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    return sqrt(dx * dx + dy * dy);
}

@end
