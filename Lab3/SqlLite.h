//
//  SqlLite.h
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"

@interface SqlLite : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

- (BOOL)saveDataWithUser:(User*) user;
- (NSMutableArray*)getContactWithGender:(NSString*)gender;
- (NSMutableArray*)getAllContacts;
- (BOOL)updateUser:(User *)user withSetName:(NSString*)uName;
- (BOOL)updateFavUser:(NSString *)isFav withSetName:(NSString*)uName;
- (BOOL)deleteUser:(NSString *)name;
-(NSMutableArray*)getContactWithFav:(NSString*)fav;
@end
