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
    self.view = __view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [_mainView.readyButton addTarget:self action:@selector(readyAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)readyAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
