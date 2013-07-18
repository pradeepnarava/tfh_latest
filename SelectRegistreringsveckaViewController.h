//
//  SelectRegistreringsveckaViewController.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlusveckaCalenderViewController.h"
@interface SelectRegistreringsveckaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) PlusveckaCalenderViewController *calanderView;
@end
