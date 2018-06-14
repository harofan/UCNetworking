//
//  UCCacheManager.h
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCCacheManager : NSObject

#pragma mark construct manager
+ (instancetype)shareManager;

- (NSDictionary *)readDataFromCacheWithUrlStr:(NSString *)urlStr;
- (void)saveDataWithObject:(id)object urlStr:(NSString *)urlStr;
- (void)clearCache;
- (void)clearObjectWithUrlStr:(NSString *)urlStr;

/**
 If your object is in cache return YES.
 */
- (BOOL)objectIsInCacheWithUrlStr:(NSString *)urlStr;

@end
