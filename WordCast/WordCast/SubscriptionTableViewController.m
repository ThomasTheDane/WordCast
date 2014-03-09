//
//  SubscriptionTableViewController.m
//  WordCast
//
//  Created by Thomas Nattestad on 2/27/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "SubscriptionTableViewController.h"
#import <Firebase/Firebase.h>
#import "Word.h"

@interface SubscriptionTableViewController ()
    
@end

@implementation SubscriptionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"loaded subscription view");
    
    if([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending){
        self.uniqueId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }else{
        //        NSLog([UIDevice currentDevice].uniqueIdentifier);
    }
    
    self.activitySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activitySpinner setCenter:CGPointMake(320 / 2.0, 25)];
    [self.view addSubview:self.activitySpinner];
    [self.activitySpinner startAnimating];
    [self.activitySpinner setHidesWhenStopped:YES];

    self.subscriptions = [[NSMutableArray alloc] init];
    
    Firebase *subscriptionManagerHeadHead = [[Firebase alloc] initWithUrl:@"https://wordcast.firebaseio.com/superDuperSecretSubscriptionsManagerHopeNoOneEverFindsThisThatWouldBeBadIShouldProbablyAddSomeRandomNumbersAndStuff12404u58298dsfonvo28dl2"];
    Firebase *subscriptionManagerHead = [subscriptionManagerHeadHead childByAppendingPath:self.uniqueId];
    [subscriptionManagerHead observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.activitySpinner stopAnimating];
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
        Word *newWord = [[Word alloc] init];
        newWord.wordName = snapshot.value;
        newWord.wordMessages = [[NSMutableArray alloc] init];
        newWord.wordListener = [[Firebase alloc] initWithUrl:[@"https://wordcast.firebaseio.com/" stringByAppendingString:newWord.wordName]];
        [self.subscriptions addObject:newWord];
        [self.tableView reloadData];
    }];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSLog(@"adding new subscription");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add subscription" message:@"Enter the secret word" delegate:self cancelButtonTitle:@"Never Mind" otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        if(!self.subscriptions){
            self.subscriptions = [[NSMutableArray alloc] init];
        }
        Word *newWord = [[Word alloc] init];
        newWord.wordName = [[alertView textFieldAtIndex:0] text];
        newWord.wordMessages = [[NSMutableArray alloc] init];
        [self.subscriptions addObject:newWord];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        Firebase *subscriptionManagerHeadHead = [[Firebase alloc] initWithUrl:@"https://wordcast.firebaseio.com/superDuperSecretSubscriptionsManagerHopeNoOneEverFindsThisThatWouldBeBadIShouldProbablyAddSomeRandomNumbersAndStuff12404u58298dsfonvo28dl2"];
        Firebase *subscriptionManagerHead = [subscriptionManagerHeadHead childByAppendingPath:self.uniqueId];
        Firebase *subscriptionManager = [subscriptionManagerHead childByAutoId];
        [subscriptionManager setValue:newWord];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.subscriptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.textLabel setText:[self.subscriptions[indexPath.row] wordName]];
    // Configure the cell...
    
    return cell;
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 

@end
