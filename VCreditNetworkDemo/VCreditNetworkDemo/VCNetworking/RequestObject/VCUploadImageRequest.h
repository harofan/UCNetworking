//
//  VCUploadImageRequest.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/1.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCBaseRequest.h"

@interface VCUploadImageRequest : VCBaseRequest

/**
 Normal afn upload image.
 */
- (void)postWithimages:(NSArray *)imgArray
      imageFilePathStr:(NSString *)imageFilePathStr
              classObj:(Class)classObj
              progress:(void(^)(NSProgress *))progressCallBack
uploadProgressCompletion:(void (^)(id))completion
            exceptions:(void(^)(id))exceptions
                 error:(void(^)(NSError *))failure;

@end
