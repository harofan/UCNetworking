//
//  VCNetworkingManager+FailureHandler.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCNetworkingManager+FailureHandler.h"
#import <objc/runtime.h>

#import <objc/runtime.h>

static const void *kFailureQueue = &kFailureQueue;

@implementation VCNetworkingManager (FailureHandler)

- (void)addFailureObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(networkStatusChanged:)
                                                name:AFNetworkingReachabilityDidChangeNotification
                                              object:nil];
}



- (void)setFailureQueue:(NSMutableSet *)failureQueue
{
    objc_setAssociatedObject(self, kFailureQueue, failureQueue, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableSet *)failureQueue
{
    NSMutableSet *set = objc_getAssociatedObject(self, kFailureQueue);
    if(!set)
    {
        set = [[NSMutableSet alloc]initWithCapacity:1];
        self.failureQueue = set;
    }
    return set;
}

- (void)networkStatusChanged:(NSNotification *)notification
{
    [self.failureQueue enumerateObjectsUsingBlock:^(NSURLSessionDataTask *task, BOOL *stop) {
        [task resume];
    }];
}


@end
