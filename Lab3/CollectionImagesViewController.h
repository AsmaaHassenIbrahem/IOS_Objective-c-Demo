//
//  CollectionImagesViewController.h
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgNameProtocol.h"
@interface CollectionImagesViewController : UICollectionViewController

@property id<ImgNameProtocol>imgName;
@end
