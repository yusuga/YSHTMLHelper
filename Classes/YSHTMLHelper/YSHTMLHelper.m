//
//  YSHTMLHelper.m
//  YSHTMLHelperExample
//
//  Created by Yu Sugawara on 2014/06/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "YSHTMLHelper.h"

@implementation YSHTMLHelper

#pragma mark - html

+ (NSString*)htmlForURLString:(NSString*)urlStr withEncoding:(NSStringEncoding)encoding
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *html = [[NSString alloc] initWithData:data encoding:encoding];
    return html;
}

+ (void)htmlForURLString:(NSString*)urlStr
            withEncoding:(NSStringEncoding)encoding
              completion:(YSHTMLHelperGetStringCompletion)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *html = [self htmlForURLString:urlStr withEncoding:encoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) completion(html);
        });
    });
}

#pragma mark - OGP

/* http://ogp.me */

+ (NSString*)ogpForURLString:(NSString*)urlStr property:(YSHTMLHelperOGPProperty)property
{
    NSString *html = [self htmlForURLString:urlStr withEncoding:NSASCIIStringEncoding];
    NSString *pattern = [NSString stringWithFormat:@"<meta property=\"%@\"[ ]*content=\"([\\w\\W]*?)\"[ ]*[/]*>", [self stringFromOGPProperty:property]];
    return [self findWordWithTargetText:html pattern:pattern];
}

+ (void)ogpForURLString:(NSString*)urlStr property:(YSHTMLHelperOGPProperty)property completion:(YSHTMLHelperGetStringCompletion)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *propertyStr = [self ogpForURLString:urlStr property:property];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) completion(propertyStr);
        });
    });
}

#pragma mark - favicon

/**
 favicon
 http://hail2u.net/documents/favicon-cheat-sheet-ja.html
 
 apple-touch-icon
 https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html
 https://developer.apple.com/jp/devcenter/ios/library/documentation/userexperience/conceptual/mobilehig/WebClipIcons/WebClipIcons.html
 
 ex)
 http://www.apple.com/apple-touch-icon.png
 http://www.apple.com/favicon.ico
 */

+ (NSArray *)faviconURLsForURLString:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *baseURLStr = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    
    return @[[baseURLStr stringByAppendingPathComponent:@"apple-touch-icon.png"],
             [baseURLStr stringByAppendingPathComponent:@"favicon.ico"]];
}

#pragma mark - utility

+ (NSString*)stringFromOGPProperty:(YSHTMLHelperOGPProperty)property
{
    switch (property) {
        case YSHTMLHelperOGPPropertyTitle:
            return @"og:title";
        case YSHTMLHelperOGPPropertyType:
            return @"og:type";
        case YSHTMLHelperOGPPropertyImage:
            return @"og:image";
        case YSHTMLHelperOGPPropertyURL:
            return @"og:url";
        default:
            NSLog(@"%s, undefined property: %zd", __func__, property);
            return nil;
    }
}

+ (NSString*)findWordWithTargetText:(NSString*)text pattern:(NSString*)pattern
{
    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    if (error != nil) {
        NSLog(@"[ERROR] RegularExpression error[%@]", error);
        return nil;
    } else {
        NSTextCheckingResult *match = [regexp firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
        if (match.numberOfRanges > 1) {
            NSString *matchStr = [text substringWithRange:[match rangeAtIndex:1]];
            return matchStr.length > 0 ? matchStr : nil;
        } else {
            return nil;
        }
    }
}

@end
