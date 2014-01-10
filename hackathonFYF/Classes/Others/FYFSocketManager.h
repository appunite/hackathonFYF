//
//  FYFSocketManager.h
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Frameworks
#import <Foundation/Foundation.h>

//Socket
#import "SRWebSocket.h"

@interface FYFSocketManager : NSObject <SRWebSocketDelegate>

/**
 *  Shared socket manager instance
 *
 *  @return `FYFSocketManager` object.
 */
+ (FYFSocketManager *)sharedManager;

/**
 *  Socket instance
 */
@property (nonatomic, strong) SRWebSocket *webSocket;

//
- (void)reconnect;
- (void)disconnect;

//
- (BOOL)isConnected;

@end

@interface FYFSocketManager (ApiPostMessages)
- (void)announcePresenceOfBeaconWithMinor:(NSNumber *)minor;
@end

// Socket state notifications
extern NSString * const FYFSocketManagerDidOpen;
extern NSString * const FYFSocketManagerDidClose;
extern NSString * const FYFSocketManagerDidFail;

// Socket message notification
extern NSString * const FYFSocketManagerCountdownMessageNotification;
extern NSString * const FYFSocketManagerStartedMessageNotification;
extern NSString * const FYFSocketManagerOccupatedMessageNotification;
extern NSString * const FYFSocketManagerCapturedMessageNotification;
extern NSString * const FYFSocketManagerFinishedMessageNotification;
extern NSString * const FYFSocketManagerWaitingMessageNotification;
