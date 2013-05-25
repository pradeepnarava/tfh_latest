//
//  Interoceptiv exponering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Interoceptiv_exponering : UIViewController<UITableViewDataSource,UITableViewDelegate>{

IBOutlet UITableView *tblView;
int noOfSection;
}
-(IBAction)switchStateChanged:(id)sender;
@end
