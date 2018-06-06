
//
//  CollectionImagesViewController.m
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "CollectionImagesViewController.h"

@interface CollectionImagesViewController (){
    
    NSArray *images ;
}

@end

@implementation CollectionImagesViewController

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
    images=@[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellImage" forIndexPath:indexPath];
    
    UIImageView *img = [cell viewWithTag:1];
    UILabel *label = [cell viewWithTag:2];
    [img setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
    [label setText:[images objectAtIndex:indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_imgName getImgName:[images objectAtIndex:indexPath.row]];
    NSLog(@"%@", [images objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];

}

@end
