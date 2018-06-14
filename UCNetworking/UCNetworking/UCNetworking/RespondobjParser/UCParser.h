//
//  UCParser.h
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCNetworkingEnum.h"
@interface UCParser : NSObject

- (void)successWithResponseDict:(NSDictionary *)responseDict
             dataParserCallBack:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))dataParserCallBack;
@end
