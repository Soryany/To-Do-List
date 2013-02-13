//
//  ListViewController.h
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveItemsViewController.h"
@interface ListViewController : UITableViewController<SaveItemsViewControllerDelegate>
@property NSMutableArray *items;
@end
