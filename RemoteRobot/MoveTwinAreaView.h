//
//  MoveTwinAreaView.h
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MoveTwinStickView;


@interface MoveTwinAreaView : UIView

extern const CGFloat MoveTwinAreaViewLineWidth;
extern const CGFloat MoveTwinAreaViewAlpha;

- (MoveTwinAreaView*)areaView;
- (MoveTwinStickView*)stickView;

@end
