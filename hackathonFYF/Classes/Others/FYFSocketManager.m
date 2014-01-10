//
//  FYFSocketManager.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFSocketManager.h"

//Models
#import "FYFLocationObject.h"

NSString * const FYFSocketManagerDidOpen = @"FYFSocketManager.Notification.State.Open";
NSString * const FYFSocketManagerDidClose = @"FYFSocketManager.Notification.State.Close";
NSString * const FYFSocketManagerDidFail = @"FYFSocketManager.Notification.State.Fail";

NSString * const FYFSocketManagerCountdownMessageNotification = @"FYFSocketManager.Notification.Message.Countdown";
NSString * const FYFSocketManagerStartedMessageNotification = @"FYFSocketManager.Notification.Message.Started";
NSString * const FYFSocketManagerOccupatedMessageNotification = @"FYFSocketManager.Notification.Message.Occupated";
NSString * const FYFSocketManagerCapturedMessageNotification = @"FYFSocketManager.Notification.Message.Captured";

@implementation FYFSocketManager

#pragma mark - 
#pragma mark Class methods

+ (FYFSocketManager *)sharedManager {
    static FYFSocketManager* __sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    
    return __sharedInstance;
}

- (void)reconnect {
    // close connection
    _webSocket.delegate = nil;
    [_webSocket close];
    
    //
    NSURL *url = [NSURL URLWithString:@"ws://192.168.2.6:8080/ws"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // init web socket
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
    
    // open socket
    [_webSocket open];
}

- (void)disconnect {
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}

- (BOOL)isConnected {
    return [_webSocket readyState] == SR_OPEN;
}

#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
    NSError *error = nil;
    // pars message response
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:message
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    // get message type
    NSString *messageType = json[@"type"];

    if ([messageType isEqualToString:@"countdown"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerCountdownMessageNotification
                                                            object:self
                                                          userInfo:message];
    }

    else if ([message isEqualToString:@"started"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerStartedMessageNotification
                                                            object:self
                                                          userInfo:message];
    }

    else if ([message isEqualToString:@"beacon_occupated"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerOccupatedMessageNotification
                                                            object:self
                                                          userInfo:message];
    }

    else if ([message isEqualToString:@"beacon_got"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerCapturedMessageNotification
                                                            object:self
                                                          userInfo:message];
    }
    
    else {
        NSLog(@"Received \"%@\"", message);
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    // post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerDidOpen
                                                        object:self];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    _webSocket = nil;

    // post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerDidFail
                                                        object:self
                                                      userInfo:@{@"error": error}];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    _webSocket = nil;

    // post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:FYFSocketManagerDidFail
                                                        object:self];
}

@end
