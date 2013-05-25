//
//  Beteendeaktivering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registreringsvecka.h"
#import "Plusvecka.h"
#import "Utvardering.h"
@interface Beteendeaktivering : UIViewController{
    UILabel *titlelabel;
    Registreringsvecka *rs;
    Plusvecka *psc;
    Utvardering *ud;
}
@property (nonatomic, retain)IBOutlet UILabel *titlelabel;
-(IBAction)sub1:(id)sender;
-(IBAction)sub2:(id)sender;
-(IBAction)sub3:(id)sender;
@end
