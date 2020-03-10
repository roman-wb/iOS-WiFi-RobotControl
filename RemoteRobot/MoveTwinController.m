//
//  MoveTwinController.m
//  RemoteRobot
//
//  Created by roman on 17.08.17.
//  Copyright © 2017 Roman Dobynda. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "MoveTwinController.h"
#import "MoveTwinAreaView.h"
#import "MoveTwinStickView.h"



@interface MoveTwinController ()

@end


@implementation MoveTwinController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.leftStickView initWithName:@"L"];
    [self.rightStickView initWithName:@"R"];
    
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

- (NSString*)stateCommand {
    
    return [NSString stringWithFormat:@"%@;%@", self.leftStickView.command,
                                                self.rightStickView.command];
}

- (void)commandSender {
    
    @autoreleasepool {
        
        NSInteger i = 0;
        
        NSString* ip = self.ipTextFiled.text;
        NSInteger port = [self.portTextField.text integerValue];
        
        while(self.status) {
            
            @autoreleasepool {
                
                NSData *data = [self.stateCommand dataUsingEncoding:NSUTF8StringEncoding];
                
                NSLog(@"%ld - %@", (long)++i, self.stateCommand);
                
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
        
        [self.leftStickView resetCommand];
        [self.rightStickView resetCommand];
        
        [self.toggleButton setTitle:@"Not connecion. Press for Start" forState:UIControlStateNormal];
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    for(UITouch* touch in touches) {
        
        // Touched stick
        if([touch.view isKindOfClass:[MoveTwinStickView class]]){
            
            MoveTwinStickView* stickView = (MoveTwinStickView*)touch.view;
            
            CGPoint location = [touch locationInView:stickView];
            if ([stickView pointInside:location withEvent:event]) {
                
                //Offset of center stick
                [stickView storeOffsetWithLocation:location];
            }
            
            continue;
        }
        
        // Touched line
        if([touch.view isKindOfClass:[MoveTwinAreaView class]]){
            
            MoveTwinAreaView* areaView = (MoveTwinAreaView*)touch.view;
            MoveTwinStickView* stickView = areaView.stickView;
            
            CGPoint location = [touch locationInView:areaView];
            if ([areaView pointInside:location withEvent:event]) {
                
                //Offset of center (zero)
                [stickView storeOffsetWithLocation:CGPointZero];
                
                [stickView moveToLocation:location];
            }
            
            continue;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    for(UITouch* touch in touches) {
        
        if([touch.view isKindOfClass:[MoveTwinStickView class]] ||
           [touch.view isKindOfClass:[MoveTwinAreaView class]]){
            
            MoveTwinStickView* view = (MoveTwinStickView*)touch.view;
            
            CGPoint location = [touch locationInView:[view areaView]];
            
            [[view stickView] moveToLocation:location];
            
            continue;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    for(UITouch* touch in touches) {
        
        if([touch.view isKindOfClass:[MoveTwinStickView class]] ||
           [touch.view isKindOfClass:[MoveTwinAreaView class]]){
            
            MoveTwinStickView* view = (MoveTwinStickView*)touch.view;
            
            [[view stickView] resetCommand];
        }
    }
}

@end
