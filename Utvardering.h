//
//  Utvardering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Veckostatistik.h"
@interface Utvardering : UIViewController{
    BOOL checkboxSelected;
    NSString *selected_checkbox;
   NSString *selected_checkbox1;
   NSString *selected_checkbox2;
    UILabel *checkBoxLabel,*checkBoxLabel1,*checkBoxLabel2,*mainlabel;
    Veckostatistik *vss;
  
}

@property(nonatomic, retain)IBOutlet UIButton *checkBox;
@property(nonatomic, retain)IBOutlet UILabel *checkBoxLabel;
@property(nonatomic, retain)IBOutlet UIButton *checkBox1;
@property(nonatomic, retain)IBOutlet UILabel *checkBoxLabel1;
@property(nonatomic, retain)IBOutlet UIButton *checkBox2;
@property(nonatomic, retain)IBOutlet UILabel *checkBoxLabel2;
@property(nonatomic, retain)IBOutlet UILabel *mainlabel;

-(IBAction)checkBoxSelect:(id)sender;
-(IBAction)checkBoxSelect2:(id)sender;

-(IBAction)checkBoxSelect1:(id)sender;
-(IBAction)PageB:(id)sender;
@end
