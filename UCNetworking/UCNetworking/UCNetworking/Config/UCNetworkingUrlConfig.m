//
//  UCNetworkingUrlConfig.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCNetworkingUrlConfig.h"

@implementation UCNetworkingUrlConfig
+ (NSString *)getFormaterUrl{
    return [NSString stringWithFormat:@"%@%@%@",[self getHost], [self getPort], [self getApi]];
}

+ (NSString *)getHost{
#ifdef DEBUG
    return @"";
#else
    return @"";
#endif
}

+ (NSString *)getPort{
    return @"";
}

+ (NSString *)getApi{
    return @"";
}
@end
