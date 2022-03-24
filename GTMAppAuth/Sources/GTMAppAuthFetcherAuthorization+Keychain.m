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

+ (nullable GTMAppAuthFetcherAuthorization *)
    authorizationFromKeychainForName:(NSString *)keychainItemName {
  NSData *passwordData = [GTMKeychain passwordDataFromKeychainForName:keychainItemName];
  if (!passwordData) {
    return nil;
  }
  GTMAppAuthFetcherAuthorization *authorization;
  if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
    authorization = (GTMAppAuthFetcherAuthorization *)
        [NSKeyedUnarchiver unarchivedObjectOfClass:[GTMAppAuthFetcherAuthorization class]                                 fromData:passwordData
                                             error:nil];
  } else {
    authorization = (GTMAppAuthFetcherAuthorization *)
        [NSKeyedUnarchiver unarchiveObjectWithData:passwordData];
  }
  return authorization;
}

+ (BOOL)removeAuthorizationFromKeychainForName:(NSString *)keychainItemName {
  return [GTMKeychain removePasswordFromKeychainForName:keychainItemName];
}

+ (BOOL)saveAuthorization:(GTMAppAuthFetcherAuthorization *)auth
        toKeychainForName:(NSString *)keychainItemName {
  NSData *authorizationData;
  if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
    authorizationData = [NSKeyedArchiver archivedDataWithRootObject:auth
                                              requiringSecureCoding:YES
                                                              error:nil];
  } else {
    authorizationData = [NSKeyedArchiver archivedDataWithRootObject:auth];
  }
  return [GTMKeychain savePasswordDataToKeychainForName:keychainItemName
                                           passwordData:authorizationData];
}

@end
