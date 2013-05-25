//
//  ListOfKompass.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/13/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditLivskompass.h"
@interface ListOfKompass : UIViewController{
UITableView *table;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    NSMutableArray *listexercise7;
    EditLivskompass *elk;
}
@property(nonatomic,retain)IBOutlet UITableView *table;
@end
