//
//  TableViewController.m
//  Test
//
//  Created by 徐宝桥 on 14-6-10.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "TableViewController.h"
#import <CoreText/CoreText.h>

@interface TableViewController ()

@property (nonatomic, assign) int a;

@end

@implementation TableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(dd)];
    self.navigationItem.rightBarButtonItem = right;
    _a = 1;
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(abc) userInfo:nil repeats:YES];
    
    NSArray *segArray = [NSArray arrayWithObjects:@"最近", @"交易",@"订阅", nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segArray];
    segmentControl.frame = CGRectMake(10, 4, 300, 32);
    [segmentControl addTarget:self action:@selector(selectedType:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = segmentControl;
    self.refreshControl = [[UIRefreshControl alloc] init];
    NSLog(@"Test SourceTree");
}

- (void)selectedType:(id)sender {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)abc {
    _a++;
    NSLog(@"%d",_a);
}

- (void)dd {
    _a++;
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [@"👏" substringToIndex:1];
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
    if (![cell.textLabel.text cStringUsingEncoding:NSUTF8StringEncoding]) {
//        NSLog(@"YES");
    }
    const char *ss = [cell.textLabel.text cStringUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"!!!%s",[cell.textLabel.text cStringUsingEncoding:NSUTF8StringEncoding]);
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 22 + 22 * _a;
    }
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
