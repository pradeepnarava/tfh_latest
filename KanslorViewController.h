//
//  KanslorViewController.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 5/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KanslorViewController : UIViewController{
      IBOutlet UIScrollView *scroll;
    NSMutableString *firstString;

    NSString *allstrings;
    NSString *selectedstrings;
    IBOutlet UIButton *first;
}
@property(nonatomic,retain)NSMutableString *firstString;
@property(nonatomic,retain)NSString *allstrings;

@property(nonatomic,retain)NSString *selectedstrings;
@end
