//
//  StickViewController.h
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncUdpSocket.h"


@class StickAreaView, StickView;


@interface StickViewController : UIViewController <GCDAsyncUdpSocketDelegate>

@property (strong, nonatomic) IBOutlet UITextField *ipTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;

- (IBAction)actionToggleButton:(id)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) IBOutlet StickAreaView *areaView;
@property (strong, nonatomic) IBOutlet StickView *stickView;

@property (strong, nonatomic) GCDAsyncUdpSocket* udpSocket;

@property (strong, nonatomic) NSThread* threadSender;

@property (assign, nonatomic) BOOL status;

@end

