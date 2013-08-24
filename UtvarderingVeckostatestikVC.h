//
//  UtvärderingVeckostatestikVC.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPopupWindow.h"
@interface UtvarderingVeckostatestikVC : UIViewController<UITextViewDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic, strong) IBOutlet UIView *firstView,*secondView,*thirdView,*fourthView,*fifthView,*desView,*bottomView;
@property (nonatomic, strong) IBOutlet UILabel *firstLabel,*firstTotal,*secondLabel,*secondTotal,*thirdLabel,*thirdTotal,*fourthLabel,*fourthTotal,*fifthLabel,*fifthTotal,*firstPlus,*secondPlus,*thirdPlus,*fourthPlus,*fifthPlus;
@property (nonatomic, strong) IBOutlet UITextView *descriptionView;
@property (nonatomic, strong) NSMutableArray *selectedArray,*sub1EventsArray,*totalArray,*sub1TotalArray,*sub2EventsArray;
@property (nonatomic, strong) IBOutlet UIScrollView *scrView;
@end
