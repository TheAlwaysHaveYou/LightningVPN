//
//  KeyChainHelper.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/7.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "KeyChainHelper.h"

@implementation KeyChainHelper

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id) CFBridgingRelease(kSecClassGenericPassword), (id) CFBridgingRelease(kSecClass),
            service, (id) CFBridgingRelease(kSecAttrService),
            service, (id) CFBridgingRelease(kSecAttrAccount),
            (id) CFBridgingRelease(kSecAttrAccessibleAfterFirstUnlock), (id) CFBridgingRelease(kSecAttrAccessible),
            nil];
}

+ (OSStatus)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef) keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id) CFBridgingRelease(kSecValueData)];
    //Add item to keychain with the search dictionary
    return SecItemAdd((__bridge CFDictionaryRef) keychainQuery, NULL);
}

+ (id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id) kCFBooleanTrue forKey:(id) CFBridgingRelease(kSecReturnData)];
    [keychainQuery setObject:(id) CFBridgingRelease(kSecMatchLimitOne) forKey:(id) CFBridgingRelease(kSecMatchLimit)];
    [keychainQuery setObject:@YES forKey:(__bridge id)kSecReturnPersistentRef];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef) keychainQuery,
                            (CFTypeRef *) &keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge
                                                              NSData *) keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
+ (OSStatus)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    return SecItemDelete((__bridge CFDictionaryRef) keychainQuery);
}

@end
