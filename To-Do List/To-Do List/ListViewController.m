//
//  ListViewController.m
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import "ListViewController.h"
#import "Items.h"
@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Set Title
        self.title = @"To-Do List";
        // Load Items
        [self loadItems];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItems:)];
    NSLog(@"Items > %@", self.items);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.items count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Fetch Item
    Items *item = [self.items objectAtIndex:[indexPath row]];
    // Configure Cell
    //[cell.textLabel setText:[item name]];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 5, 100, 30)];
    [noteLabel setFont:[UIFont fontWithName:@"FontName" size:12.0]];
    [noteLabel setTextColor:[UIColor grayColor]];    
    noteLabel.text = [item note];
    [cell addSubview:noteLabel];
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString: @"http://dzineblog.com/wp-content/uploads/2012/05/09-ancestry-book-ios-icon.png"]];
    
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    
    cell.textLabel.text =[item name];
    
    cell.imageView.image =image;    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete Item from Items
        [self.items removeObjectAtIndex:[indexPath row]];
        // Update Table View
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        // Save Changes to Disk
        [self saveItems];
    }
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Fetch Item
    Items *item = [self.items objectAtIndex:[indexPath row]];
    // Update Item
    [item setInList:![item inList]];
    // Update Cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([item inList]) {
        [cell.imageView setImage:[UIImage imageNamed:@"checkmark"]];
    } else {
        [cell.imageView setImage:[UIImage imageNamed:@"book-ios-icon"]];
    }
    [self saveItems];
    
    //Then you change the properties (label, text, color etc..) in your case, the background color
    cell.contentView.backgroundColor=[UIColor whiteColor];
    cell.textLabel.highlightedTextColor =[UIColor blackColor];
}
- (NSString *)pathForItems {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    return [documents stringByAppendingPathComponent:@"sampleItems.plist"];
}
- (void)loadItems {
    NSString *filePath = [self pathForItems];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        self.items = [NSMutableArray array];
    }
}
- (void)saveItems {
    NSString *filePath = [self pathForItems];
    [NSKeyedArchiver archiveRootObject:self.items toFile:filePath];
}
- (void)addItem:(id)sender {
    NSLog(@"Button was tapped.");
    // Initialize Add Item View Controller
    SaveItemsViewController *addItemViewController = [[SaveItemsViewController alloc] initWithNibName:@"SaveItemsViewController" bundle:nil];
    // Set Delegate
    [addItemViewController setDelegate:self];
    // Present View Controller
    [self presentViewController:addItemViewController animated:YES completion:nil];
}
- (void)controller:(SaveItemsViewController *)controller didSaveItemWithName:(NSString *)name andNote:(NSString *)note{
    // Create Item
    Items *item = [Items createItemWithName:name andNote:note];
    // Add Item to Data Source
    [self.items addObject:item];
    // Add Row to Table View
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.items count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    // Save Items
    [self saveItems];
}
- (void)editItems:(id)sender {
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
}
@end
