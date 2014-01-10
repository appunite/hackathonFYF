//
//  FYFBoardViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Controllers
#import "FYFBoardViewController.h"

//Views
#import "FYFBoardView.h"

//Models
#import "FYFLocationObject.h"

@interface FYFBoardViewController ()

@end

@implementation FYFBoardViewController {
    FYFBoardView *_boardView;
    SRWebSocket *_webSocket;
}

- (void)loadView {
    // get app frame
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    // create and assign view
    FYFBoardView* view = [[FYFBoardView alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
    // save weak referance
    _boardView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _reconnect];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}


#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket; {
    NSLog(@"Websocket Connected");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Websocket Failed With Error %@", error);
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"Received \"%@\"", message);
//    [_messages addObject:[[TCMessage alloc] initWithMessage:message fromMe:NO]];
    
    NSError *error = nil;
    FYFLocationObject *location = [MTLJSONAdapter modelOfClass:[FYFLocationObject class]
                                            fromJSONDictionary:message
                                                         error:&error];
    
    NSLog(@"location: %@", location);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}


#pragma mark -
#pragma mark Private

- (void)_reconnect {

    // close connection
    _webSocket.delegate = nil;
    [_webSocket close];
    
    // init web socket
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.2.6:8080/ws"]]];
    _webSocket.delegate = self;
    
    // open socket
    [_webSocket open];
}

@end
