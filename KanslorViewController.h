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
    IBOutlet UIButton *b1,*b2,*b3,*b4,*b5,*b6,*b7,*b8,*b9,*b10,*b11,*b12,*b13,*b14,*b15,*b16,*b17,*b18,*b19,*b20,*b21,*b22,*b23,*b24,*b25,*b26,*b27,*b28,*b29,*b30,*b31,*b32,*b33,*b34,*b35,*b36,*b37,*b38,*b39,*b40,*b41,*b42,*b43,*b44,*b45,*b46,*b47,*b48,*b49,*b50,*b51,*b52,*b53,*b54;
}

@property(nonatomic,retain)NSMutableString *firstString;
@property(nonatomic,retain)NSString *allstrings;

@property(nonatomic,retain)NSString *selectedstrings;
@end
