//
//  HomeViewController.h
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SqlLite.h"
#import "AddUserViewController.h"

@interface HomeViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>
- (IBAction)homeAction:(id)sender;
- (IBAction)girlAction:(id)sender;
- (IBAction)boyAction:(id)sender;
- (IBAction)favAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *userTabel;
@property  NSMutableArray *Friends;

@property (strong, nonatomic) IBOutlet UIButton *favBtn;
@property (strong, nonatomic) IBOutlet UIButton *edtAction;

@property (strong, nonatomic) IBOutlet UIButton *deleteAction;

@end
