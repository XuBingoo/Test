//
//  ViewController.m
//  Test
//
//  Created by 徐宝桥 on 14-6-4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()


@end

@implementation ViewController

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self documentSave];
    
    
//    View *v = [[View alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
//    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
