//
//  ListOfKompass.h
//  Välkommen till TFH-appen
//
//  Created by Sai Jithendra Gogineni on 06/06/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListOfUtvarderingDelegate;

@interface ListOfUtvardering : UITableViewController
{
    NSMutableArray *listexercise7;
   // EditLivskompass *elk;
}

@property (nonatomic, retain) id<ListOfUtvarderingDelegate> delegate;

@end

@protocol ListOfUtvarderingDelegate <NSObject>

- (void)didSelectDate:(NSString *)date;

@end
