//
//  PlusveckaForslagViewController.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 8/16/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TidigeraCell.h"
@interface PlusveckaForslagViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) IBOutlet UITableView *table;
@end
