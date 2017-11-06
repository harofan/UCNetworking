//
//  VCUploadImageRequest.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/1.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//  http://www.jianshu.com/p/2cb9136c837a

#import "VCUploadImageRequest.h"
#import "VCNetworkingManager.h"
#import "VCResponsobjParser.h"

@implementation VCUploadImageRequest

- (void)postWithimages:(NSArray *)imgArray
      imageFilePathStr:(NSString *)imageFilePathStr
              classObj:(Class)classObj
              progress:(void (^)(NSProgress * _Nonnull ))progressCallBack
uploadProgressCompletion:(void (^)(id))completion
            exceptions:(void (^)(id))exceptions
                 error:(void (^)(NSError *))failure{
    
    //iPhone network activity
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    VCNetworkingManager *networkingManger = [VCNetworkingManager shareManager];
    VCResponsobjParser *parser = networkingManger.parser;
    
    //image name.You can add userName or token here.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    
    [networkingManger.manager POST:self.urlStr parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //image index
        int imgIndex = 0;
        NSString * serverName;
        if (imgArray.count>1) {
            serverName = [NSString stringWithFormat:@"%@[]",imageFilePathStr];
        } else {
            serverName = imageFilePathStr;
        }
        for (UIImage * image in imgArray) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d", str,imgIndex];
            NSData * imageData = [self resetSizeOfImageData:image maxSize:150];
            if (imageData != nil) {
                
                if (UIImagePNGRepresentation(image)) {
                    //PNG
                    NSString * name = [NSString stringWithFormat:@"%@%ld.png",fileName,(long)imgIndex];
                    [formData appendPartWithFileData:imageData name:serverName fileName:name mimeType:@"image/png"];
                }else{
                    //JPEG
                    NSString * name = [NSString stringWithFormat:@"%@%ld.jpeg",fileName,(long)imgIndex];
                    [formData appendPartWithFileData:imageData name:serverName fileName:name mimeType:@"image/jpeg"];
                }
                
                imgIndex ++ ;
            }
            
        }
    } progress:progressCallBack success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //success call back
        [parser success:task reponseObject:responseObject class:classObj completion:completion exceptions:exceptions failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //error call back
        [parser failure:task httpError:error class:classObj completion:completion failure:failure];
    }];

    
    
}


#pragma mark - reduce image
/**
 *  动态发布图片压缩
 *
 *  @param originalImage original image
 *  @param maxSize      image size.
 *
 *  @return 返回处理后的图片数据流
 */
- (NSData *)resetSizeOfImageData:(UIImage *)originalImage maxSize:(NSInteger)maxSize{
    //先调整分辨率
    CGSize newSize = CGSizeMake(originalImage.size.width, originalImage.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth != tempHeight) {
        newSize = CGSizeMake(originalImage.size.width / tempWidth, originalImage.size.height / tempWidth);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    NSLog(@"sizeOriginKB === %ld",sizeOriginKB);
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        NSLog(@"finallImageDataKB === %ld",[finallImageData length]/1024);
        return finallImageData;
    }
    //    NSData *imageData = [PMRequest image:newImage maxSize:maxSize];
    NSLog(@"imageDataKB === %ld",[imageData length]/1024);
    return imageData;
}

@end
