//
//  SaveItemsViewController.h
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SaveItemsViewControllerDelegate;
@interface SaveItemsViewController : UIViewController
@property (weak) id<SaveItemsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@end
@protocol SaveItemsViewControllerDelegate <NSObject>
- (void)controller:(SaveItemsViewController *)controller didSaveItemWithName:(NSString *)name andNote:(NSString *)note;
@end