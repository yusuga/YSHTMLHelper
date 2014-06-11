//
//  YSHTMLHelper.h
//  YSHTMLHelperExample
//
//  Created by Yu Sugawara on 2014/06/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YSHTMLHelperOGPProperty) {
    YSHTMLHelperOGPPropertyTitle,
    YSHTMLHelperOGPPropertyType,
    YSHTMLHelperOGPPropertyImage,
    YSHTMLHelperOGPPropertyURL,
};

typedef void(^YSHTMLHelperGetStringCompletion)(NSString *str);

@interface YSHTMLHelper : NSObject

+ (NSString*)htmlForURLString:(NSString*)urlStr withEncoding:(NSStringEncoding)encoding;
+ (void)htmlForURLString:(NSString*)urlStr
            withEncoding:(NSStringEncoding)encoding
              completion:(YSHTMLHelperGetStringCompletion)completion;

+ (NSString*)ogpForURLString:(NSString*)urlStr property:(YSHTMLHelperOGPProperty)property;
+ (void)ogpForURLString:(NSString*)urlStr property:(YSHTMLHelperOGPProperty)property completion:(YSHTMLHelperGetStringCompletion)completion;

+ (NSArray*)faviconURLsForURLString:(NSString*)urlStr;

@end
