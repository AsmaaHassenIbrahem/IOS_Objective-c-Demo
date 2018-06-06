//
//  AddUserViewController.m
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController (){
    User *user;
    SqlLite *sql;
    HomeViewController *home;
}



@end

@implementation AddUserViewController{
    NSString *userName;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    user=[User new];
    sql=[SqlLite new];
   home =[HomeViewController new];
    
    if (_isAdd) {

        ///Add
        [_btnSaveName setTitle:@"Save" forState:UIControlStateNormal];
    }else{
        //edit
        [_btnSaveName setTitle:@"Edit" forState:UIControlStateNormal];
        userName =_user.name;
        [_labelImgName setText:_user.image];
        [_txtAge setText:_user.age];
        [_labelName setText:_user.name];
        [_txtPhone setText:_user.phone];
        NSLog(@"gender==> %@",_user.gender);
        if ([_user.gender isEqual:@"female"]) {
            _segmentGender.selectedSegmentIndex=0;
        }else{
            _segmentGender.selectedSegmentIndex=1;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)switchToGallery:(id)sender {
    
    CollectionImagesViewController *gallery =[[self storyboard]instantiateViewControllerWithIdentifier:@"gallery"];
    [self.navigationController pushViewController:gallery animated:YES];
    gallery.imgName=self;
    
}
- (IBAction)btnSaveAndSwitchHome:(id)sender {
    if (_isAdd) {
        //Add
    user.name =[_labelName text];
    user.age =[_txtAge text];
    user.phone=[_txtPhone text];
    user.isfav=@"false";
    if (_segmentGender.selectedSegmentIndex==0) {
        user.gender=@"female";
    }else{
        user.gender=@"male";
    }
    user.image=_labelImgName.text;
    if (![[_labelImgName text] isEqual:@"Empty"]&&![[_labelName text] isEqual:@""] &&![[_txtAge text] isEqual:@""]&&![[_txtPhone text] isEqual:@""]) {
        if ([sql saveDataWithUser:user]) {
            
            //[home.Friends addObject:user];
            [self switchToHome];

            
        }else{
            
            //Alert

                    }
    }
    else{
        //Alert empty
        [self emptyAlert];
    }
    }else{
//        edit
        if (![[_labelImgName text] isEqual:@"Empty"]&&![[_labelName text] isEqual:@""] &&![[_txtAge text] isEqual:@""]&&![[_txtPhone text] isEqual:@""]) {
        User *editUser =[User new ];
        
        editUser.name =[_labelName text];
        editUser.age =[_txtAge text];
        editUser.phone=[_txtPhone text];
        editUser.isfav=_user.isfav;
    if (_segmentGender.selectedSegmentIndex==0) {
            editUser.gender=@"female";
        }else{
            editUser.gender=@"male";
        }
        editUser.image=_labelImgName.text;
        if([sql updateUser:editUser withSetName:userName]){
            //Toast Alert View with Time Dissmis Only
           
            NSLog(@"edit Done");
            [self switchToHome];
        }else{
            
        }
        }else{
            [self emptyAlert];
        }
    }
}
- (void) getImgName:(NSString*)name{
    [_labelImgName setText:name];
}

- (void) emptyAlert{
    //Alert empty
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"warning" message:@"plz enter all fields" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert  show];

}

- (void) switchToHome{
    
    HomeViewController *home =[[self storyboard]instantiateViewControllerWithIdentifier:@"home"];
    [self.navigationController pushViewController:home animated:YES];

}
@end
