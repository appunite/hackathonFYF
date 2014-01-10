//
//  FYFGameListViewController.m
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFGameListViewController.h"
#import "FYFBoardViewController.h"

@interface FYFGameListViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation FYFGameListViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"Select Your Game Room"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];

    // load resources
    UIImage *backgroundImage = [UIImage imageNamed:@"back.jpg"];

    // create backgroundv iew
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    
    // change background view
    [self.tableView setBackgroundView:backgroundView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:@"Room 1"];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FYFBoardViewController *boardGameViewController = [[FYFBoardViewController alloc] init];
    [self.navigationController pushViewController:boardGameViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
