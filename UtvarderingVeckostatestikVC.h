//
//  UtvärderingVeckostatestikVC.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPopupWindow.h"
#import "ListOfUtvardering.h"
#import <MessageUI/MessageUI.h>
#import "DinUtvardering.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface UtvarderingVeckostatestikVC : UIViewController<UITextViewDelegate,ListOfUtvarderingDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
    ListOfUtvardering *lok;
    UIImageView *tableImageView;
    UIButton *closeButton;
    NSString *dateOfCurrentItem;
}
@property (nonatomic, strong) DinUtvardering *utvarderingController;
@property (nonatomic, strong) IBOutlet UIButton *raderaButton,*skickaButton,*plusButton,*totalButton;
@property (nonatomic, strong) IBOutlet UIView *firstView,*secondView,*thirdView,*fourthView,*fifthView,*desView,*bottomView;
@property (nonatomic, strong) IBOutlet UILabel *firstLabel,*firstTotal,*secondLabel,*secondTotal,*thirdLabel,*thirdTotal,*fourthLabel,*fourthTotal,*fifthLabel,*fifthTotal,*firstPlus,*secondPlus,*thirdPlus,*fourthPlus,*fifthPlus;
@property (nonatomic, strong) IBOutlet UITextView *descriptionView;
@property (nonatomic, strong) NSMutableArray *selectedArray,*sub1EventsArray,*totalArray,*sub1TotalArray,*sub2EventsArray,*valuesArray,*selectedValuesArray;
@property (nonatomic, strong) IBOutlet UIScrollView *scrView;
@end
