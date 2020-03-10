//
//  MoveTwinStickView.m
//  RemoteRobot
//
//  Created by roman on 21.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import "MoveTwinStickView.h"
#import "MoveTwinAreaView.h"


@implementation MoveTwinStickView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillEllipseInRect(context, rect);
}

- (void)initWithName:(NSString*)name {
    
    _originCenter = self.center;
    _originAlpha = self.alpha;
    
    _maxValue = CGRectGetMidY(self.areaView.bounds) - MoveTwinAreaViewLineWidth / 2.f;
    
    _name = name;
    
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

- (MoveTwinAreaView*)areaView {

    return (MoveTwinAreaView*)self.superview;
}

- (MoveTwinStickView*)stickView {
    
    return self;
}

- (CGPoint)correctionForLocation:(CGPoint)location {
    
    return CGPointMake(self.originCenter.x, location.y + self.offset.y);
}

- (void)resetCommand {
    
    self.command = [NSString stringWithFormat:@"%@|S|250|100", self.name];
    
    [UIView animateWithDuration:.1f
                     animations:^{
                         self.center = self.originCenter;
                         self.alpha = self.originAlpha;
                     }];
}

- (void)moveToLocation:(CGPoint)location {
    
    // Correction with offset (only Y)
    CGPoint correction = [self correctionForLocation:location];
    
    CGFloat distance = [self distanceBetweenPoint1:self.originCenter andPoint2:correction];
    
    if (distance < self.maxValue) {
        
        //NSLog(@"%@", NSStringFromCGPoint(correction));
        
        [UIView animateWithDuration:.05f
                         animations:^{
                             self.center = correction;
                             self.alpha = .7f;
                         }];
        
        [self commandWithLocation:correction andDistance:distance];
    }
}

- (void)commandWithLocation:(CGPoint)location andDistance:(CGFloat)distance {
    
    // Motor
    NSMutableString* string = [NSMutableString stringWithString:self.name];
    
    // Vector & Delay
    if(location.y > self.maxValue) {
        
        [string appendString:@"|B|250|"];
    } else if (location.y < self.maxValue) {
        
        [string appendString:@"|F|250|"];
    } else {
        // Nothing
        return;
    }
    
    // PWM in percent
    CGFloat duration = 100.f / (self.maxValue / distance);
    if(duration > 90) {
        duration = 100;
    }
    NSString* pwmPercent = [[NSNumber numberWithFloat:duration] stringValue];
    [string appendString:pwmPercent];
    
    self.command = string;
}

- (CGFloat)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    return sqrt(dx * dx + dy * dy);
}

@end
