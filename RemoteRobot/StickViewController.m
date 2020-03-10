//
//  StickViewController.m
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "StickViewController.h"
#import "StickAreaView.h"
#import "StickView.h"


@interface StickViewController ()

@end


@implementation StickViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.stickView initDefault];
    
    self.udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                                   delegateQueue:dispatch_get_main_queue()];
    
    self.status = false;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.status = false;
}

#pragma mark - Actions

- (IBAction)actionToggleButton:(id)sender forEvent:(UIEvent *)event {
    
    self.status = !self.status;
}

#pragma mark - Private

- (void)commandSender {
    
    @autoreleasepool {
        
        NSInteger i = 0;
        
        NSString* ip = self.ipTextFiled.text;
        NSInteger port = [self.portTextField.text integerValue];
        
        while(self.status) {
            
            @autoreleasepool {
                
                NSData *data = [self.stickView.command dataUsingEncoding:NSUTF8StringEncoding];
                
                NSLog(@"%ld - %@", (long)++i, self.stickView.command);
                
                [self.udpSocket sendData:data toHost:ip port:port withTimeout:-1 tag:1];
                
                [NSThread sleepForTimeInterval:.05f];
            }
        }
    }
}

- (void)setStatus:(BOOL)status {
    
    _status = status;
    
    self.ipTextFiled.enabled = !self.status;
    self.portTextField.enabled = !self.status;
    
    if(self.status) {
        
        [self performSelectorInBackground:@selector(commandSender) withObject:nil];
        
        [self.toggleButton setTitle:@"Connected. Press for Stop" forState:UIControlStateNormal];
        
    } else {
        
        [self.stickView resetCommand];
        
        [self.toggleButton setTitle:@"Not connecion. Press for Start" forState:UIControlStateNormal];
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    
    // Toucheched stick
    if([touch.view isKindOfClass:[StickView class]]){
        
        StickView* stickView = (StickView*)touch.view;
        
        CGPoint location = [touch locationInView:stickView];
        if ([stickView pointInside:location withEvent:event]) {
            
            //Offset of center stick
            [stickView storeOffsetWithLocation:location];
        }
        
        return;
    }
    
    // Touched circle
    if([touch.view isKindOfClass:[StickAreaView class]]){
        
        StickAreaView* areaView = (StickAreaView*)touch.view;
        StickView* stickView = areaView.stickView;
        
        CGPoint location = [touch locationInView:areaView];
        if ([areaView pointInside:location withEvent:event]) {
            
            //Offset of center (zero)
            [stickView storeOffsetWithLocation:CGPointZero];
            
            [stickView moveToLocation:location];
        }
        
        return;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    
    if([touch.view isKindOfClass:[StickView class]] ||
       [touch.view isKindOfClass:[StickAreaView class]]){
        
        StickView* view = (StickView*)touch.view;
        
        CGPoint location = [touch locationInView:[view areaView]];
        
        [[view stickView] moveToLocation:location];
        
        return;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    
    if([touch.view isKindOfClass:[StickView class]] ||
       [touch.view isKindOfClass:[StickAreaView class]]){
        
        StickView* view = (StickView*)touch.view;
        
        [[view stickView] resetCommand];
    }
}

@end
