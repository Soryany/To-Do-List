//
//  Items.h
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items : NSObject
@property NSString *name;
@property NSString *note;
@property BOOL inList;
+ (Items *)createItemWithName:(NSString *)name andNote:(NSString *)note;
@end
