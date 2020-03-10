//
//  StickView.h
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>


@class StickAreaView;

@interface StickView : UIView

@property (assign, nonatomic) CGPoint offset;

@property (assign, readonly, nonatomic) CGPoint originCenter;
@property (assign, readonly, nonatomic) CGFloat originAlpha;

@property (assign, readonly, nonatomic) CGFloat maxValue;

@property (assign, readonly, nonatomic) CGFloat areaMidX;
@property (assign, readonly, nonatomic) CGFloat areaMidY;

@property (strong, nonatomic) NSString* command;

- (void)initDefault;

- (void)storeOffsetWithLocation:(CGPoint)location;

- (CGPoint)correctionForLocation:(CGPoint)location;

- (void)resetCommand;

- (void)moveToLocation:(CGPoint)location;

- (void)commandWithLocation:(CGPoint)location andDistance:(CGFloat)distance;

- (StickAreaView*)areaView;
- (StickView*)stickView;

- (CGFloat)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

@end
