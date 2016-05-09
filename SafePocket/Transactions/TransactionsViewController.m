//
//  TableViewController.m
//  SafePocket
//
//  Created by Lucian Todorovici on 18/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "TransactionsViewController.h"
#import "TransactionsManager.h"
#define CELL_ID @"transactions_cell"

@interface TransactionsViewController ()
@property (strong,nonatomic) NSMutableArray *transactionsArray;
@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _transactionsArray = [TransactionsManager sharedInstance].transactions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _transactionsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Transaction %li",indexPath.row];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *selectedIndexDictionary = _transactionsArray[indexPath.row];
    
    UIViewController *controller = [UIViewController new];
    
     //add a background image
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"background.jpg"];
    [controller.view addSubview:imageView];
    
    CGRect frame = CGRectMake(30, 50, controller.view.frame.size.width-60, 50);
    //make any key editable
    for (NSString *key in selectedIndexDictionary.allKeys){
        //instantiate a new text view and customize it
        UITextView *textView = [UITextView new];
        textView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.65f];
        [textView setText:[selectedIndexDictionary objectForKey:key]];
        [textView setFont:[UIFont systemFontOfSize:14]];
        textView.frame = frame;
        frame.origin.y = frame.origin.y + 60;
        //add the text view to the controller's view
        [controller.view addSubview:textView];
     }
    [self presentViewController:controller animated:YES completion:nil];
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
