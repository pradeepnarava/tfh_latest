//
//  OveningarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registreratankar.h"
#import "TankefallorViewController.h"
#import "Utmanatankar.h"
#import "BeteendeexperimentController.h"
#import "Beteendeaktivering.h"
#import "Interoceptivexponering.h"
#import "Livskompassen.h"
@interface OveningarViewController : UIViewController{
    Registreratankar *rt;
    TankefallorViewController *tfvc;
    Utmanatankar *ut;
    BeteendeexperimentController *bec;
    Beteendeaktivering *ba;
    Interoceptivexponering *ice;
    Livskompassen *lsp;
    
    IBOutlet UIScrollView *scroll;
}
-(IBAction)exercise1:(id)sender;
-(IBAction)exercise2:(id)sender;
-(IBAction)exercise3:(id)sender;
-(IBAction)exercise4:(id)sender;
-(IBAction)exercise5:(id)sender;
-(IBAction)exercise6:(id)sender;
-(IBAction)exercise7:(id)sender;
@end
