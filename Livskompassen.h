//
//  Livskompassen.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/10/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dinaomraden.h"
#import "DinKompass.h"

@interface Livskompassen : UIViewController{
    UIScrollView *scrollView;
    Dinaomraden *dr;
    DinKompass *dk;
      
}
-(IBAction)pageB:(id)sender;
-(IBAction)pageC:(id)sender;
-(IBAction)iLabel:(id)sender;
@end
