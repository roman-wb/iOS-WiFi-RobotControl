//
//  MoveTwinController.h
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncUdpSocket.h"


@class MoveTwinAreaView, MoveTwinStickView;


@interface MoveTwinController : UIViewController <GCDAsyncUdpSocketDelegate>

@property (strong, nonatomic) IBOutlet UITextField *ipTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;

- (IBAction)actionToggleButton:(id)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) IBOutlet MoveTwinAreaView* leftAreaView;
@property (strong, nonatomic) IBOutlet MoveTwinAreaView* rightAreaView;

@property (strong, nonatomic) IBOutlet MoveTwinStickView* leftStickView;
@property (strong, nonatomic) IBOutlet MoveTwinStickView* rightStickView;

@property (strong, nonatomic) GCDAsyncUdpSocket* udpSocket;

@property (strong, nonatomic) NSThread* threadSender;

@property (assign, nonatomic) BOOL status;

@end
