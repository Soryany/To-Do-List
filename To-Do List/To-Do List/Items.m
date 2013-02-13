//
//  Items.m
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import "Items.h"

@implementation Items
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.note forKey:@"note"];
    [coder encodeBool:self.inList forKey:@"inList"];
}
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        [self setName:[decoder decodeObjectForKey:@"name"]];
        [self setNote:[decoder decodeObjectForKey:@"note"]];
        [self setInList:[decoder decodeBoolForKey:@"inList"]];
    }
    return self;
}
+ (Items *)createItemWithName:(NSString *)name andNote:(NSString *)note{
    // Initialize Item
    Items *item = [[Items alloc] init];
    // Configure Item
    [item setName:name];
    [item setNote:note];
    [item setInList:NO];
    return item;
}
@end
