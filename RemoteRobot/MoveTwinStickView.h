//
//  MoveTwinStickView.h
//  RemoteRobot
//
//  Created by roman on 21.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MoveTwinAreaView;


@interface MoveTwinStickView : UIView

@property (assign, nonatomic) CGPoint offset;
@property (assign, readonly, nonatomic) CGPoint originCenter;
@property (assign, readonly, nonatomic) CGFloat originAlpha;
@property (assign, readonly, nonatomic) CGFloat maxValue;

@property (strong, readonly, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* command;

- (void)initWithName:(NSString*)name;

- (void)storeOffsetWithLocation:(CGPoint)location;

- (MoveTwinAreaView*)areaView;
- (MoveTwinStickView*)stickView;

- (CGPoint)correctionForLocation:(CGPoint)location;

- (void)resetCommand;

- (void)moveToLocation:(CGPoint)location;

- (void)commandWithLocation:(CGPoint)location andDistance:(CGFloat)distance;

- (CGFloat)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

@end
