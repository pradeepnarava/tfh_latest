//
//  SettingRegistViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingRegistViewController : UIViewController

@property (nonatomic, strong)IBOutlet UIScrollView *popupScrollView;


-(IBAction)onoffButtonClicked:(id)sender;
-(IBAction)hourSelected:(id)sender;
-(IBAction)startTimeButton:(id)sender;
-(IBAction)endTimeButton:(id)sender;

-(void)sampleData;

@end
