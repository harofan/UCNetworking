//
//  VCPostController.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/11/6.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCPostController.h"
#import "VCShareModel.h"

@interface VCPostController ()

@end

@implementation VCPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"POST";
    
    [self p_loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark load data
- (void)p_loadData{
    
    [[VCNetworkingManager shareManager] postUrl:@"" params:nil class:[VCShareModel class] completion:^(VCShareModel *model) {
        NSLog(@"%@",model.downloadUrl);
    }error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
