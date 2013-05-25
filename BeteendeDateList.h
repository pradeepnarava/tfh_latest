//
//  BeteendeDateList.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "BeteendeEditForm.h"
@interface BeteendeDateList : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listexercise4;
        
    sqlite3 *exerciseDB;
    NSString *databasePath;
    UITableView *tableview;
    BeteendeEditForm *bef;
}
@property(nonatomic,retain)IBOutlet UITableView *tableview;

@property(nonatomic,retain)NSMutableArray *listexercise4;


@end
