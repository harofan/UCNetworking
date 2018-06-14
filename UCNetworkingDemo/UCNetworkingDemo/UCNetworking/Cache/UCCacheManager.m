 //
//  UCCacheManager.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCCacheManager.h"
#import <YYCache.h>
@interface UCCacheManager()
@property (nonatomic, strong) YYCache *cache;
@end
@implementation UCCacheManager
#pragma mark construct manager
static UCCacheManager *_share = nil;
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
        _cache = [YYCache cacheWithName:@"UCNetworkingDemo"];
    }
    return _cache;
}
@end
