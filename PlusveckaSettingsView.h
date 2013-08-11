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
@property (nonatomic, strong) IBOutlet UIImageView *background;
@property (nonatomic, strong) IBOutlet UIDatePicker *eventPicker,*totalPicker;
@property (nonatomic, strong) IBOutlet UIView *eventView,*totalView,*totalView1;
@property (nonatomic,strong)IBOutlet UIScrollView *scrollVie;
@property (nonatomic,strong)IBOutlet UIButton *klarButton;
@property (nonatomic, strong)NSString *whichHour,*totalHour;
@property (nonatomic, strong) NSMutableDictionary *sub2Settings;
@property (nonatomic, strong) NSMutableArray *sub1EventsArray;

-(IBAction)eventOnOff:(id)sender;
-(IBAction)totalOnOff:(id)sender;
@end
