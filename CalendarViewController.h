//
//  CalendarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SettingRegistViewController;

@interface CalendarViewController : UIViewController


@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) SettingRegistViewController *settingRegViewCntrl;



@end
