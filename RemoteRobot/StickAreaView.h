//
//  StickAreaView.h
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StickView;


@interface StickAreaView : UIView

extern const CGFloat StickAreaViewPadding;

extern const NSInteger StickAreaViewSections;

- (StickAreaView*)areaView;
- (StickView*)stickView;

@end
