//
//  FYFGameViewController.m
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFStartGameViewController.h"
#import "FYFStartGameView.h"

@interface FYFStartGameViewController ()

@end

@implementation FYFStartGameViewController {
    __weak FYFStartGameView *_mainView;
    __weak CountdownView *_countdownView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    FYFStartGameView *__view = [[FYFStartGameView alloc] initWithFrame:CGRectZero];
    _mainView = __view;
    
    CountdownView * countdownView = [[CountdownView alloc] initWithFrame:__view.bounds];
    [countdownView setAnimationDelegate:self];
    [__view addSubview:countdownView];
    
    _countdownView = countdownView;
    self.view = __view;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_countdownView setFrame:self.view.bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [_mainView.readyButton addTarget:self action:@selector(readyAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCountdownMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        [_countdownView startAnimation];
    }];
}

- (void)readyAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CountdownViewDelegate

- (void)countdownViewdidFinishCounting:(CountdownView *)countdownView {
    NSLog(@"move bitch!");
}

@end
