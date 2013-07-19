//
//  SettingsData.m
//  Välkommen till TFH-appen
//
//  Created by Pradeep on 19/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "SettingsData.h"

@implementation SettingsData
@synthesize filePath;

static SettingsData *sharedData = nil;


-(NSString *)docDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+(SettingsData*)sharedData {
    
    if (!sharedData) {
        sharedData = [[SettingsData alloc] init];
    }
    
    return sharedData;
}

-(id)init {
    
    if (self = [super init]) {
        
        /*filePath = [[self docDir] stringByAppendingPathExtension:@"Settings.plist"];
        
        if (!([[NSFileManager defaultManager] fileExistsAtPath:filePath])) {
            [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"] toPath:filePath error:nil];
        }*/
        
        self = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
        
        NSLog(@"inilization %i",[self count]);
    }
    return self;
}






@end
