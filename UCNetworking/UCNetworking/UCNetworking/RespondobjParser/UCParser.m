//
//  UCParser.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCParser.h"

@implementation UCParser
- (void)successWithResponseDict:(NSDictionary *)responseDict
             dataParserCallBack:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))dataParserCallBack{
    UCAPIManagerResponseStatesType statesType;
    if ([responseDict[@"states"] isEqualToString:@"000"]) {
        statesType = UCAPIManagerResponseStatesTypeSuccess;
    }else if ([responseDict[@"states"] isEqualToString:@"001"]){
        statesType = UCAPIManagerResponseStatesTypeNeedAccessToken;
    }else if ([responseDict[@"states"] isEqualToString:@"002"]){
        statesType = UCAPIManagerResponseStatesTypeNeedLogin;
    }else{
        statesType = UCAPIManagerResponseStatesTypeJsonError;
    }
    if (dataParserCallBack) {
        dataParserCallBack(responseDict, statesType);
    }
}
@end
