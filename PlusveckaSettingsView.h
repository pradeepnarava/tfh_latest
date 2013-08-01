//
//  PlusveckaSettingsView.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface PlusveckaSettingsView : UIViewController
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic,strong)IBOutlet UIScrollView *scrollVie;
@property (nonatomic,strong)IBOutlet UIButton *oneHour,*twoHour,*threeHour,*fourHour;
@property (nonatomic, strong)NSString *whichHour;
@property (nonatomic, strong) NSMutableDictionary *sub2Settings;
@property (nonatomic, strong) NSMutableArray *sub1EventsArray;
@end
