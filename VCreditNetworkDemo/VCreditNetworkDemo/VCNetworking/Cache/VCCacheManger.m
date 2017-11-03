//
//  VCCacheManger.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/11/3.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCCacheManger.h"
#import <YYCache.h>

@interface VCCacheManger ()
@property (nonatomic, strong) YYCache *cache;
@end

@implementation VCCacheManger

#pragma mark construct manager
static VCCacheManger *_share = nil;
+ (instancetype)shareManager{
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        _share = [[super allocWithZone:NULL] init];
    });
    return _share;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
}

- (void)clearCache{
    [self.cache removeAllObjects];
}

- (void)clearObjectWithUrlStr:(NSString *)urlStr{
    [self.cache removeObjectForKey:urlStr];
}

- (void)saveDataWithObject:(id)object urlStr:(NSString *)urlStr{
    if (!object) {
        NSLog(@"object in cache is nil!");
    }
    [self.cache setObject:object forKey:urlStr];
}
- (id)readDataFromCacheWithUrlStr:(NSString *)urlStr{
    return [self.cache objectForKey:urlStr];
}

- (BOOL)objectIsInCacheWithUrlStr:(NSString *)urlStr{
    return [self.cache containsObjectForKey:urlStr];
}


#pragma mark Lazy Load
- (YYCache *)cache{
    if (!_cache) {
        _cache = [YYCache cacheWithName:@"VCreditNetworkDemo"];
    }
    return _cache;
}

@end
