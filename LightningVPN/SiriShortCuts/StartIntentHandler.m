//
//  StartIntentHandler.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/16.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "StartIntentHandler.h"

@implementation StartIntentHandler

- (void)handleStartIntent:(StartIntentIntent *)intent completion:(void (^)(StartIntentIntentResponse *response))completion NS_SWIFT_NAME(handle(intent:completion:))  API_AVAILABLE(ios(12.0)) {
    NSLog(@"handleStartIntent");
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([StartIntentIntent class])];
    StartIntentIntentResponse *response = [[StartIntentIntentResponse alloc] initWithCode:StartIntentIntentResponseCodeSuccess userActivity:activity];
    completion(response);
}

- (void)confirmStartIntent:(StartIntentIntent *)intent completion:(void (^)(StartIntentIntentResponse *response))completion NS_SWIFT_NAME(confirm(intent:completion:)) API_AVAILABLE(ios(12.0)) {
    NSLog(@"confirmStartIntent");
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([StartIntentIntent class])];
    StartIntentIntentResponse *response = [[StartIntentIntentResponse alloc] initWithCode:StartIntentIntentResponseCodeReady userActivity:activity];
    completion(response);
}

@end
