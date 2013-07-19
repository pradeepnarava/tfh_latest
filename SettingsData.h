//
//  SettingsData.h
//  Välkommen till TFH-appen
//
//  Created by Pradeep on 19/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsData : NSArray

@property (nonatomic, strong) NSString *filePath;


-(id)init;
+(SettingsData*)sharedData;


@end
