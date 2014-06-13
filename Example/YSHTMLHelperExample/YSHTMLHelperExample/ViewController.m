//
//  ViewController.m
//  YSHTMLHelperExample
//
//  Created by Yu Sugawara on 2014/06/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ViewController.h"
#import "YSHTMLHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *urlStr;
    urlStr = @"http://www.apple.com";
    
    NSLog(@"%@", [YSHTMLHelper htmlForURLString:urlStr withEncoding:NSASCIIStringEncoding]);
//    NSLog(@"favicon image urls: %@", [YSHTMLHelper faviconURLsForURL:[NSURL URLWithString:urlStr]]);
//    NSLog(@"favicon image urls: %@", [YSHTMLHelper faviconURLsForURL:[NSURL URLWithString:@"http://store.apple.com/jp?aid=www-k2-mac%20-%20index%2Ftab&cp=k2-mac%20"]]);
    
#if 0
    uint64_t n = dispatch_benchmark(10, ^{
//        [YSHTMLHelper htmlForURLString:urlStr withEncoding:NSASCIIStringEncoding];
//        [YSHTMLHelper ogpForURLString:urlStr property:YSHTMLHelperOGPPropertyImage];
    });
    NSLog(@"n = %llu [ns]",n);
#endif
}

@end
