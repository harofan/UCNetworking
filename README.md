
![](https://github.com/RPGLiker/UCNetworking/blob/master/Resource/%E3%83%A6%E3%83%8B%E3%82%B3%E3%83%BC%E3%83%B3%E3%82%AC%E3%83%B3%E3%83%80%E3%83%A0.jpeg)

## 前言

以前的框架是为了直接在网络请求完毕后就将json转化为我们需要的model,但为了新的路由组件化框架,降低耦合所以去除了Model这个环节,这个是重构之后的.

## 一般使用

- 一般的`POST`请求

   	    [[UCNetworkingManager shareManager] postUrl:@"" params:nil completion:^(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates) {
            
        } failure:^(NSError *error) {
            
        }];
        
- 带缓存的`POST`请求

        [[UCNetworkingManager shareManager] postUrl:@"" cacheUrl:@"" params:nil completion:^(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates) {

        } failure:^(NSError *error) {

        } cacheDictCallBackBlock:^(NSDictionary *cacheDict) {

        }];
        
- 一般的`GET`请求

    	[[UCNetworkingManager shareManager] getUrl:@"" params:nil completion:^(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates) {
            
        } error:^(NSError *error) {
            
        }];
        
        
- 带缓存的`GET`请求
 
    	[[UCNetworkingManager shareManager] getUrl:@"" cacheUrl:@"" params:nil completion:^(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates) {
    	
        } failure:^(NSError *error) {
        
        } cacheDictCallBackBlock:^(NSDictionary *cacheDict) {
        
        }];
        
## 代理使用

调用下面的方法成为代理即可,目前仅仅实现了观察网络状态,有需求的话自己可以添加.这里是用的`NSHashTable`来持有多个`delegate`的,为了避免循环引用,这里的策略你可以认为是hashTable弱引用了这些delegate,并且当代理被释放时,hashtable中也会自动清除这个对象不会造成内存泄漏.

  		[[UCNetworkingManager shareManager] addObjToDelegateArray:self];
  		
主动移除这个代理可以使用下面的这个方法,没有必要特意在dealloc中去写.

		- (void)removeObjFromDelegateArray:(id<UCNetworkingManagerDelegate>)delegateObj;

## 请求头设置

	- (void)setRequestHeaderFieldWithToken:(NSString *)accessToken;
    - (void)setRequestHTTPHeadFieldWithDictionary:(NSDictionary *)dict;
    - (void)removeTokenFromHeaderField;
    - (void)removeValueFromHeaderFieldWithKey:(NSString *)keyStr;

## URL配置

在`UCNetworkingUrlConfig`类中去完成配置

## 数据处理

这里可以根据自己的业务需求对数据进行解析和加工,demo只是单单对数据的响应状态进行了解析.详细请看`UCParser`
