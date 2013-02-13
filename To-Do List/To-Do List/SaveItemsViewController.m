//
//  SaveItemsViewController.m
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import "SaveItemsViewController.h"

@interface SaveItemsViewController ()

@end

@implementation SaveItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    // Extract User Input
    NSString *name = [self.nameTextField text];
    NSString *note = [self.noteTextField text];
    // Notify Delegate
    [self.delegate controller:self didSaveItemWithName:name andNote:note];
    // Dismiss View Controller
    [self dismissViewControllerAnimated:YES completion:nil];}

@end
