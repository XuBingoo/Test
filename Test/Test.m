//
//  Test.m
//  Test
//
//  Created by 徐宝桥 on 14-5-23.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "Test.h"

@implementation Test

- (id)initWithRequest {
    if (self = [super init]) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"24234"]];
        request.delegate = self;
        [request startAsynchronous];
    }
    return self;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"11111");
}

@end
