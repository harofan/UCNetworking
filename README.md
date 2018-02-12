![](https://github.com/RPGLiker/VCNetworking/blob/master/Resource/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-02-12%20%E4%B8%8B%E5%8D%889.05.59.png)

##VCNetworking

[![Build Status](https://travis-ci.org/RPGLiker/VCNetworking.svg?branch=master)](https://travis-ci.org/RPGLiker/VCNetworking)

VCNetworking是我自己利用设计模式整合的一个网络请求和数据处理工具,他依赖于`AFNetworking`,`YYModel`,`YYCache`才能够使用,如果你不想使用这两个框架,也可以在负责数据处理的类(`VCResponsobjParser`)里和数据请求的类(`VCBaseRequest的子类`)里面进行替换即可!


## 安装
- 1首先利用`cocoapods`导入`AFNetworking`,`YYModel`,`YYCache`
- 2将`VCNetworking`这个文件夹直接手动导入项目

## 如何使用?
- 1 普通的`post`请求

    	[[VCNetworkingManager shareManager] postUrl:@"" params:nil class:[YYModelClass class] completion:^(YYModelClass *model) {
            
        }error:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
- 2 普通的`post`请求,在请求获得到数据之前先利用缓存进行处理

    	[[VCNetworkingManager shareManager] postUrl:@"" cacheUrl:@"" params:nil class:[YYModelClass Class] completion:^(YYModelClass *model) {
            
        } exceptions:^(YYModelClass *model) {
            
        } error:^(NSError * error) {
            
        } cacheObjectCallBackBlock:^(id cacheObj) {
            //这里可以先获取到缓存
        }];
- 3 `post`上传图片数组,这里已经对图片进行了压缩,另外图片的命名上传路径都需要与后台约定       
 
    	[[VCNetworkingManager shareManager] postUrl:@"" images:@[image1, image2] imageFilePathStr:@"" progress:^(NSProgress *progress) {
            
        } completion:^(YYModelClass *model) {
            
        }];
        
## 后续扩展
后续将会支持上传与下载,但由于没有服务器对接可能要等机会了,但是这个工具类是采用面向对象的思想进行开发的,他可以把任务进行委托给`BaseRequest`的子类,数据处理交给`VCResponsobjParser`,数据缓存交给了`VCCacheManger`,职责分工很明确,便于维护.