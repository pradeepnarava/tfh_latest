//
//  DinKompass.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/15/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "DateSelectingViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DinUtvardering : UIViewController <CPTPlotDataSource, DateSelectingViewControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    NSMutableArray *presentArray;
    NSMutableArray *olderArray;
    NSMutableArray *averageArray;
    NSMutableArray *datesArray;
}
@property (nonatomic, strong) NSMutableArray *datesArray,*averageArray;
@property (nonatomic, retain) NSString *presentDate;
@property (nonatomic, retain) NSString *oldDate;
@property (nonatomic) BOOL isComparisonGraph;



@end
