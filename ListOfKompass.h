//
//  ListOfKompass.h
//  Välkommen till TFH-appen
//
//  Created by Sai Jithendra Gogineni on 06/06/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListOfKompassDelegate;

@interface ListOfKompass : UITableViewController
{
    NSMutableArray *listexercise7;
   // EditLivskompass *elk;
}

@property (nonatomic, retain) id<ListOfKompassDelegate> delegate;

@end

@protocol ListOfKompassDelegate <NSObject>

- (void)didSelectDate:(NSString *)date;

@end
