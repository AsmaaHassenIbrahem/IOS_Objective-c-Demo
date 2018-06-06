//
//  SqlLite.m
//  Lab3
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "SqlLite.h"

@implementation SqlLite
- (id)init
{
    self = [super init];
    if (self) {
        NSString *docsDir;
        NSArray *dirPaths;
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSLog(@"TTTTTTTT");
        docsDir = dirPaths[0];
        
        // Build the path to the database file
        _databasePath = [[NSString alloc]
                         initWithString: [docsDir stringByAppendingPathComponent:
                                          @"contacts.db"]];
        
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE TEXT, PHONE TEXT , GENDER TEXT, IMAGE TEXT , ISFAV TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_contactDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    return self;
}


-(BOOL)saveDataWithUser:(User*) user{
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    NSLog(@"OK");
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSLog(@"OK1");

        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, age, phone,gender ,image,isfav) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\" ,\"%@\" ,\"%@\")",
                               user.name,user.age,user.phone,user.gender,user.image,user.isfav];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"OK2");

            return true;
           NSLog( @"Contact added");
                    } else {
                        NSLog(@"OK3");

            return false;
           NSLog( @"Failed to add contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
        NSLog(@"OK4");

    }
    NSLog( @"//////Failed to add contact");

    return false;
    
}

-(NSMutableArray*)getContactWithGender:(NSString*)gender{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *allFriends =[NSMutableArray new];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, age, phone,image,isfav,gender FROM contacts WHERE gender=\"%@\"",
                              gender];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                User *user = [User new];
                user.name = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 0)];
               // _address.text = addressField;
                user.age = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                
                user.phone = [[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 2)];
                user.image = [[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 3)];
                user.isfav = [[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 4)];
                
                user.gender = [[NSString alloc]
                               initWithUTF8String:(const char *)
                               sqlite3_column_text(statement, 5)];
                
                [allFriends addObject:user];
            }
//            sqlite3_finalize(statement);
            sqlite3_reset(statement);

        }
        sqlite3_close(_contactDB);
    }
    return allFriends;
}

-(NSMutableArray*)getContactWithFav:(NSString*)fav{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *allFriends =[NSMutableArray new];

    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, age, phone,image,isfav,gender FROM contacts WHERE isfav=\"%@\"",
                              fav];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                 User *user = [User new];
                user.name = [[NSString alloc]
                             initWithUTF8String:
                             (const char *) sqlite3_column_text(
                                                                statement, 0)];
                // _address.text = addressField;
                user.age = [[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 1)];
                
                user.phone = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 2)];
                user.image = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 3)];
                user.isfav = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 4)];
                
                user.gender = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 5)];
                

                
                [allFriends addObject:user];
            }
            //            sqlite3_finalize(statement);
            sqlite3_reset(statement);
            
        }
        sqlite3_close(_contactDB);
    }
    return allFriends;
}


- (NSMutableArray*)getAllContacts{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *allFriends =[NSMutableArray new];
    NSLog(@"first %d", allFriends.count);
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, age, phone,image,isfav,gender FROM contacts"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                User *user = [User new];

                user.name = [[NSString alloc]
                             initWithUTF8String:
                             (const char *) sqlite3_column_text(
                                                                statement, 0)];
                NSLog(@"testD %@",user.name);

                // _address.text = addressField;
                user.age = [[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 1)];
                
                user.phone = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 2)];
                user.image = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 3)];
                user.isfav = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 4)];
                
                user.gender = [[NSString alloc]
                               initWithUTF8String:(const char *)
                               sqlite3_column_text(statement, 5)];
                NSLog(@"gender sql==> %@",user.gender);
                [allFriends addObject:user];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    NSLog(@"final %d", allFriends.count);
    for (int i=0; i<allFriends.count; i++) {
        NSLog(@"to %@",[[allFriends objectAtIndex:i]name]);
    }
    return allFriends;
}

- (BOOL)updateUser:(User *)user withSetName:(NSString*)uName {
   const char *utf8Dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement = NULL;
    if (sqlite3_open(utf8Dbpath, &_contactDB) == SQLITE_OK) {
        
        NSString *updateQuery = [NSString stringWithFormat:@"update contacts set name='%@', age='%@', phone='%@', gender='%@', image='%@', isfav='%@' WHERE name='%@'", user.name, user.age, user.phone ,user.gender,user.image,user.isfav,uName];
        
        const char *utf8UpdateQuery = [updateQuery UTF8String];
        
        sqlite3_prepare_v2(_contactDB,
                           utf8UpdateQuery, -1, &statement, NULL);
       // sqlite3_prepare_v2(_contactDB, utf8UpdateQuery, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Edit");
            sqlite3_reset(statement);
            return true;
        } else {
        
            NSLog(@"sqlite3_step != SQLITE_DONE");
            sqlite3_reset(statement);
            return false;
        }
    } else {
        NSLog(@" Fail to open DB");
        sqlite3_reset(statement);
        return false;
    }
}

- (BOOL)updateFavUser:(NSString *)isFav withSetName:(NSString*)uName {
    const char *utf8Dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement = NULL;
    if (sqlite3_open(utf8Dbpath, &_contactDB) == SQLITE_OK) {
        
        NSString *updateQuery = [NSString stringWithFormat:@"update contacts set isfav='%@' WHERE name='%@'", isFav,uName];
        
        const char *utf8UpdateQuery = [updateQuery UTF8String];
        
        sqlite3_prepare_v2(_contactDB,
                           utf8UpdateQuery, -1, &statement, NULL);
        // sqlite3_prepare_v2(_contactDB, utf8UpdateQuery, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"EditUP");
            sqlite3_reset(statement);
            return true;
        } else {
            
            NSLog(@"sqlite3_step != SQLITE_DONE");
            sqlite3_reset(statement);
            return false;
        }
    } else {
        NSLog(@" Fail to open DB");
        sqlite3_reset(statement);
        return false;
    }
}


- (BOOL)deleteUser:(NSString *)name {
    const char *utf8Dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement = NULL;
    
    if (sqlite3_open(utf8Dbpath, &_contactDB) == SQLITE_OK) {
        
        NSString *deleteQuery = [NSString stringWithFormat:@"delete from contacts where name='%@'", name];
        
        const char *utf8DeleteQuery = [deleteQuery UTF8String];
        
        sqlite3_prepare_v2(_contactDB, utf8DeleteQuery, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            sqlite3_reset(statement);
            return YES;
        } else {
                NSLog(@"sqlite3_step != SQLITE_DONE");
            sqlite3_reset(statement);
            return NO;
        }
    } else {
        
            NSLog(@"Fail to open DB");
        sqlite3_reset(statement);
        return NO;
    }
}


@end
