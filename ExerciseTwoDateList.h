//
//  ExerciseTwoDateList.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditExerciseTwo.h"
@interface ExerciseTwoDateList : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableView;
    NSMutableArray *listexercise2;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    EditExerciseTwo *eet;
}
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *listexercise2;
@end
