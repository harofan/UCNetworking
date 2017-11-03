//
//  VCCacheManger.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/11/3.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCCacheManger : NSObject

#pragma mark construct manager
+ (instancetype)shareManager;

- (id)readDataFromCacheWithUrlStr:(NSString *)urlStr;
- (void)saveDataWithObject:(id)object urlStr:(NSString *)urlStr;
- (void)clearCache;
- (void)clearObjectWithUrlStr:(NSString *)urlStr;

/**
 If your object is in cache return YES.
 */
- (BOOL)objectIsInCacheWithUrlStr:(NSString *)urlStr;

@end
