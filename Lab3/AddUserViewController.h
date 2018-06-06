//
//  AddUserViewController.h
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SqlLite.h"
#import "HomeViewController.h"
#import "ImgNameProtocol.h"
#import "CollectionImagesViewController.h"
#import "User.h"


@interface AddUserViewController : UIViewController <UIAlertViewDelegate, ImgNameProtocol>

@property User *user;

// true to  add
// false to edit
@property BOOL isAdd ;
    

@property (strong, nonatomic) IBOutlet UITextField *labelName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentGender;
- (IBAction)switchToGallery:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *labelImgName;
- (IBAction)btnSaveAndSwitchHome:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSaveName;

@end
