//
//  DinKompass.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/15/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "TUTSimpleScatterPlot.h"
@interface DinKompass : UIViewController{
    IBOutlet CPTGraphHostingView *_graphHostingView;
    TUTSimpleScatterPlot *_scatterPlot;
}

@property (nonatomic, retain) TUTSimpleScatterPlot *scatterPlot;


@end
