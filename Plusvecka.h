//
//  Plusvecka.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectRegistreringsveckaViewController.h"
#import "PlusveckaDinaveckar.h"
#import <sqlite3.h>
@interface Plusvecka : UIViewController
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

-(IBAction)Ilabel:(id)sender;
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic,strong) SelectRegistreringsveckaViewController *selectController;
@property (nonatomic,strong) PlusveckaDinaveckar *dinaveckarController;
@end
