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

@interface DinKompass : UIViewController <CPTPlotDataSource, DateSelectingViewControllerDelegate>
{
    NSMutableArray *presentArray;
    NSMutableArray *olderArray;
    NSMutableArray *averageArray;
    NSMutableArray *datesArray;
}

@property (nonatomic, retain) NSString *presentDate;
@property (nonatomic, retain) NSString *oldDate;
@property (nonatomic) BOOL isComparisonGraph;



@end
