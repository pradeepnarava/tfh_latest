//
//  EditExerciseViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseOneEditController.h"
#import <sqlite3.h>
@interface EditExerciseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listexercise1;
    NSString *Selectedrow;
    ExerciseOneEditController *eoec;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    UITableView *tableView;
}
@property(nonatomic,retain)IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSMutableArray *listexercise1;
@property(nonatomic,retain) NSString *Selectedrow;

@end
