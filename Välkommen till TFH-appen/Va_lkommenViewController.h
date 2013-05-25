//
//  Va_lkommenViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OveningarViewController.h"
@interface Va_lkommenViewController : UIViewController{
    OveningarViewController *ovc;
}
-(IBAction)introduktion:(id)sender;
-(IBAction)om:(id)sender;
-(IBAction)lashorna:(id)sender;
-(IBAction)oveningarbutton:(id)sender;
@end
