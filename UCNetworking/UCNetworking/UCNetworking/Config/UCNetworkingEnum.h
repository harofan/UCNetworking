//
//  UCNetworkingEnum.h
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#ifndef UCNetworkingEnum_h
#define UCNetworkingEnum_h
typedef NS_ENUM (NSUInteger, UCServiceAPIEnvironment){
    UCServiceAPIEnvironmentDevelop = 0,//测试
    UCServiceAPIEnvironmentRelease//生产
};

typedef NS_ENUM (NSUInteger, UCAPIManagerRequestType){
    UCAPIManagerRequestTypePost,
    UCAPIManagerRequestTypeGet,
//    UCAPIManagerRequestTypePut,
//    UCAPIManagerRequestTypeDelete,
};

typedef NS_ENUM (NSUInteger, UCAPIManagerResponseStatesType){
    UCAPIManagerResponseStatesTypeSuccess = 0,     // 请求成功
    UCAPIManagerResponseStatesTypeNeedAccessToken, // 需要重新刷新accessToken
    UCAPIManagerResponseStatesTypeNeedLogin,       // 需要登陆
    UCAPIManagerResponseStatesTypeTimeout,         // 超时
    UCAPIManagerResponseStatesTypeJsonError,       // json解析异常
    
//    UCAPIManagerResponseStatesTypeDefault,         // 没有产生过API请求，这个是manager的默认状态。
//    UCAPIManagerResponseStatesTypeLoginCanceled,   // 调用API需要登陆态，弹出登陆页面之后用户取消登陆了
//    UCAPIManagerResponseStatesTypeSuccess,         // API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
//    UCAPIManagerResponseStatesTypeNoContent,       // API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
//    UCAPIManagerResponseStatesTypeParamsError,     // 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
//    UCAPIManagerResponseStatesTypeTimeout,         // 请求超时。CTAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看CTAPIProxy的相关代码。
//    UCAPIManagerResponseStatesTypeNoNetWork,       // 网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
//    UCAPIManagerResponseStatesTypeCanceled,        // 取消请求
//    UCAPIManagerResponseStatesTypeDownGrade,       // APIManager被降级了
};

#endif /* UCNetworkingEnum_h */
