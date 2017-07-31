//
//  ViewController.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "ViewController.h"
#import "VCNetworking.h"

@interface ViewController ()

@property (strong, nonatomic)void(^successBlock)(id obj);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setSuccessBlock:^(id obj){
        NSLog(@"1");
    }];
    NSDictionary *dict = [NSDictionary dictionary];
    [[VCNetworkingManager shareManager] postUrl:@"/getShareInfo" params:dict class:[VCBaseModel class] completion:self.successBlock];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
