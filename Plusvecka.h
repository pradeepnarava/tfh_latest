//
//  Plusvecka.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectRegistreringsveckaViewController.h"
#import "PlusveckaDinaveckar.h"
@interface Plusvecka : UIViewController


-(IBAction)Ilabel:(id)sender;

@property (nonatomic,strong) SelectRegistreringsveckaViewController *selectController;
@property (nonatomic,strong) PlusveckaDinaveckar *dinaveckarController;
@end
