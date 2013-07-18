//
//  PlusveckaCalander.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlusveckaCalenderViewController : UIViewController
@property (nonatomic,copy) NSDate *week;
@property (nonatomic,strong) NSMutableArray *dateArray,*weekdays;
@property (nonatomic,strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@end
