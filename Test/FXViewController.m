//
//  FXViewController.m
//  Test
//
//  Created by 徐宝桥 on 14-8-11.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "FXViewController.h"

@interface FXViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *dict;

@end

@implementation FXViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (NSString *)imagePath {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [document stringByAppendingPathComponent:@"image"];
}

- (void)documentSave {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[self imagePath]]) {
        [fileManager createDirectoryAtPath:[self imagePath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [[self imagePath] stringByAppendingPathComponent:@"1"];
    UIImage *image = [UIImage imageNamed:@"p.png"];
    //    NSData *data = [NSData da];
    [fileManager createFileAtPath:path contents:UIImagePNGRepresentation(image) attributes:nil];
}

- (void)print {
    [_tableView reloadData];
    for (NSNumber *key in _dict) {
        NSLog(@"%d-%@",key.intValue,[_dict objectForKey:key]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self documentSave];
    
    
    //    View *v = [[View alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    //    [self.view addSubview:v];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(print)];
    self.navigationItem.rightBarButtonItem = right;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dict = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIView *)contentView {
//    NSString *string = @"您的《<a href=\"www.baidu.com\" style=\"text-decoration : none\" target=\"_blank\">宝桥这是测试数据</a>》福务将于［18：08］开始，请注意及时参加。";
//    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(50, 0, 250, 1)];
//    webview.delegate = self;
//    webview.tag = 100;
//    webview.scrollView.scrollEnabled = NO;
//    [webview loadHTMLString:string baseURL:nil];
//    return webview;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(50, 0, 250, 1)];
        webview.delegate = self;
        webview.tag = 100;
        webview.scrollView.scrollEnabled = NO;
        [cell.contentView addSubview:webview];
        NSLog(@"nil");
    }
    NSString *string = [NSString stringWithFormat:@"您的《<a href=\"www.baidu.com\" style=\"text-decoration : none\" target=\"_blank\">宝桥这是测试数据</a>》福务将于［18：08］开始，请注意及时参加。%d",indexPath.row];
    UIWebView *webView = (UIWebView *)[cell viewWithTag:100];
    [webView loadHTMLString:string baseURL:nil];
    if (![_dict objectForKey:[NSNumber numberWithInt:indexPath.row]]) {
        NSLog(@"加载webview %d",indexPath.row);
        webView.delegate = self;
    }
    else {
        webView.delegate = nil;
        webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, [[_dict objectForKey:[NSNumber numberWithInt:indexPath.row]] floatValue]);
    }
//    cell.detailTextLabel.text = string;
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"高度 %d",indexPath.row);
    NSNumber *height = [_dict objectForKey:[NSNumber numberWithInt:indexPath.row]];
    if (height) {
        NSLog(@"重载cell = %d %@",indexPath.row,height);
        return [height floatValue];
    }
    return 44;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.delegate = nil;
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.scrollView.contentSize.height);
    NSLog(@"%@,%@,%@",webView.superview,webView.superview.superview,webView.superview.superview.superview);
    UITableViewCell *cell = (UITableViewCell *)[webView superview].superview;
    NSIndexPath *path = [_tableView indexPathForCell:cell];
    NSLog(@"webview加载完成 = %d",path.row);
    [_dict setObject:[NSNumber numberWithFloat:webView.scrollView.contentSize.height] forKey:[NSNumber numberWithInt:path.row]];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];
}

@end
