//
//  HomeViewController.m
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "HomeViewController.h"

static int toolBarType=1;

@interface HomeViewController (){
    
    // 1 home to all
    // 2 girls
    // 3 boy
    // 4 fav
    
    SqlLite *sql;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setNeedsDisplay];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_userTabel setDataSource:self];
    [_userTabel setDelegate:self];
    
    sql=[SqlLite new];
    self.navigationItem.hidesBackButton=YES;
    //// to add custom right button
    UIImage* image3 = [UIImage imageNamed:@"add.png"];
    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(switchToAddUser)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *addbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=addbutton;
   
    switch (toolBarType) {
        case 1:
            self.title =@"All Friends";
            _Friends = [sql getAllContacts];
           break;
        case 2:
              self.title =@"Female";
            _Friends = [sql getContactWithGender:@"female"];

            break;
        case 3:
              self.title =@"Male";
            _Friends = [sql getContactWithGender:@"male"];
            break;
        case 4:
              self.title =@"My Favourite";
            _Friends = [sql getContactWithFav:@"true"];
            break;
            
            }
}

-(void)switchToAddUser{
    AddUserViewController *addUser =[[self storyboard]instantiateViewControllerWithIdentifier:@"addUser"];
    addUser.isAdd= true;
    [self.navigationController pushViewController:addUser animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeAction:(id)sender {
    toolBarType=1;
    self.title =@"All Friends";
    [self switchToHomeWithToolBarType:toolBarType];
}

- (IBAction)girlAction:(id)sender {
    toolBarType=2;
    self.title =@"Female";
    [self switchToHomeWithToolBarType:toolBarType];
}

- (IBAction)boyAction:(id)sender {
    toolBarType=3;
    self.title =@"Male";
    [self switchToHomeWithToolBarType:toolBarType];
}

- (IBAction)favAction:(id)sender {
    toolBarType=4;
    self.title =@"My Favourite";
    [self switchToHomeWithToolBarType:toolBarType];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _Friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellUser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UIButton *editImg =[cell viewWithTag:5];
    
   // editImg.tag = indexPath.row;
    ///[editImg  action:@selector(editAction) ];

    //[editImg setUserInteractionEnabled:YES];
    editImg.tag=indexPath.row;
    [editImg addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];

    

    UIButton *deleteImg =[cell viewWithTag:4];
    deleteImg.tag=indexPath.row;
    [deleteImg addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

   /// DeleteImg.tag = indexPath.row;

    
    UIButton *favImg =[cell viewWithTag:6];
    if (_Friends!=nil) {
    if ([[[_Friends objectAtIndex:indexPath.row]isfav]isEqual:@"true"]) {
         [favImg setImage:[UIImage imageNamed:@"love.png"] forState:UIControlStateNormal];
    }else{
[favImg setImage:[UIImage imageNamed:@"disLove.png"] forState:UIControlStateNormal];
    }
        
        favImg.tag=indexPath.row;
        [favImg addTarget:self action:@selector(favBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    UIImageView *userImg =[cell viewWithTag:1];
    [userImg setImage:[UIImage imageNamed:[[_Friends objectAtIndex:indexPath.row]image]]];

    UILabel *nameLabel =[cell viewWithTag:2];
    [nameLabel setText:[[_Friends objectAtIndex:indexPath.row]name]];
        NSLog(@"num %d",indexPath.row);
    UILabel *phoneLabel =[cell viewWithTag:3];
    [phoneLabel setText:[[_Friends objectAtIndex:indexPath.row]phone]];
    
    }
    return cell;
}

-(void)deleteAction:(UIButton*)sender
{
    [sql deleteUser:[[_Friends objectAtIndex:sender.tag]name]];
    NSLog(@"string %@",[[_Friends objectAtIndex:sender.tag]name]);
    [self switchToHomeWithToolBarType:toolBarType];
}

-(void)favBtn:(UIButton*)sender
{
    NSLog(@"FAV");
    if ([[[_Friends objectAtIndex:sender.tag]isfav]isEqual:@"true"])  {
        [sql updateFavUser:@"false" withSetName:[[_Friends objectAtIndex:sender.tag]name]];
        [self switchToHomeWithToolBarType:toolBarType];
    }else{
        [sql updateFavUser:@"true" withSetName:[[_Friends objectAtIndex:sender.tag]name]];
        [self switchToHomeWithToolBarType:toolBarType];
    }
    
}

-(void)editAction:(UIButton*)sender
{
    AddUserViewController *editUser =[[self storyboard]instantiateViewControllerWithIdentifier:@"addUser"];
    editUser.isAdd= false;
    editUser.user=[_Friends objectAtIndex:sender.tag];
    [self.navigationController pushViewController:editUser animated:YES];
    NSLog(@"string %@",[[_Friends objectAtIndex:sender.tag]name]);
}

- (void) switchToHomeWithToolBarType:(int) type{
    HomeViewController *home =[[self storyboard]instantiateViewControllerWithIdentifier:@"home"];
    toolBarType =type;
    [self.navigationController pushViewController:home animated:NO];
    
}
@end
