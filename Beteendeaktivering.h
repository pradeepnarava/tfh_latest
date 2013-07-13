//
//  Beteendeaktivering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Registreringsvecka;
@class Plusvecka;
@class Utvardering;


@interface Beteendeaktivering : UIViewController {

}

@property (nonatomic, retain) Registreringsvecka *rs;
@property (nonatomic, retain) Plusvecka *psc;
@property (nonatomic, retain) Utvardering *ud;
@property (nonatomic, retain) IBOutlet UILabel *titlelabel;

-(IBAction)sub1:(id)sender;
-(IBAction)sub2:(id)sender;
-(IBAction)sub3:(id)sender;


@end
