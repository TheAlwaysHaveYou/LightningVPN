//
//  HTTPRequestManager.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "AFNetWorking.h"


@interface HTTPRequestManager ()

@property (nonatomic,strong) AFHTTPSessionManager* manager;

@end

@implementation HTTPRequestManager

+ (instancetype)sharedInstance {
    static HTTPRequestManager *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[HTTPRequestManager alloc] init];
        
        request.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        request.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        request.manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        request.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD",@"PUT", nil];//AFN默认吧get head delete方法的请求参数拼到了url的后面，写这个是移除了delete
//
//        [request.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request.manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        request.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"image/jpeg", @"image/png",@"text/html",nil];
    });
    return request;
}
@end
