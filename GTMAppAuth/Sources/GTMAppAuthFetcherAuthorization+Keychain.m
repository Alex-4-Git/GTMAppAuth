/*! @file GTMAppAuthFetcherAuthorization+Keychain.m
    @brief GTMAppAuth SDK
    @copyright
        Copyright 2016 Google Inc.
    @copydetails
        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.
 */

#import "GTMAppAuth/Sources/Public/GTMAppAuth/GTMAppAuthFetcherAuthorization+Keychain.h"

#import "GTMAppAuth/Sources/Public/GTMAppAuth/GTMKeychain.h"

@implementation GTMAppAuthFetcherAuthorization (Keychain)

+ (GTMAppAuthFetcherAuthorization *)authorizationFromKeychainForName:(NSString *)keychainItemName {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  return [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:keychainItemName
                                                   dataProtectionKeychain:NO];
#pragma clang diagnostic pop
}

+ (GTMAppAuthFetcherAuthorization *)authorizationFromKeychainForName:(NSString *)keychainItemName
                                              dataProtectionKeychain:(BOOL)dataProtectionKeychain {
  NSData *passwordData = [GTMKeychain passwordDataFromKeychainForName:keychainItemName
                                               dataProtectionKeychain:dataProtectionKeychain];
  if (!passwordData) {
    return nil;
  }
  GTMAppAuthFetcherAuthorization *authorization = (GTMAppAuthFetcherAuthorization *)
      [NSKeyedUnarchiver unarchiveObjectWithData:passwordData];
  return authorization;
}

+ (BOOL)removeAuthorizationFromKeychainForName:(NSString *)keychainItemName {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  return [GTMAppAuthFetcherAuthorization removeAuthorizationFromKeychainForName:keychainItemName
                                                        dataProtectionKeychain:NO];
#pragma clang diagnostic pop
}

+ (BOOL)removeAuthorizationFromKeychainForName:(NSString *)keychainItemName
                        dataProtectionKeychain:(BOOL)dataProtectionKeychain {
  return [GTMKeychain removePasswordFromKeychainForName:keychainItemName
                                 dataProtectionKeychain:dataProtectionKeychain];
}

+ (BOOL)saveAuthorization:(GTMAppAuthFetcherAuthorization *)auth
        toKeychainForName:(NSString *)keychainItemName {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  return [GTMAppAuthFetcherAuthorization saveAuthorization:auth
                                         toKeychainForName:keychainItemName
                                    dataProtectionKeychain:NO];
#pragma clang diagnostic pop
}

+ (BOOL)saveAuthorization:(GTMAppAuthFetcherAuthorization *)auth
             toKeychainForName:(NSString *)keychainItemName
        dataProtectionKeychain:(BOOL)dataProtectionKeychain {
  NSData *authorizationData = [NSKeyedArchiver archivedDataWithRootObject:auth];
  return [GTMKeychain savePasswordDataToKeychainForName:keychainItemName
                                           passwordData:authorizationData
                                 dataProtectionKeychain:dataProtectionKeychain];
}

@end
