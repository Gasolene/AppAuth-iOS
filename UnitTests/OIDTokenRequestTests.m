/*! @file OIDTokenRequestTests.m
    @brief AppAuth iOS SDK
    @copyright
        Copyright 2015 Google Inc. All Rights Reserved.
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

#import "OIDTokenRequestTests.h"

#import "OIDAuthorizationResponseTests.h"
#import "OIDServiceConfigurationTests.h"
#import "Source/OIDAuthorizationRequest.h"
#import "Source/OIDAuthorizationResponse.h"
#import "Source/OIDScopeUtilities.h"
#import "Source/OIDServiceConfiguration.h"
#import "Source/OIDTokenRequest.h"

/*! @var kRefreshTokenTestValue
    @brief Test value for the @c refreshToken property.
 */
static NSString *const kRefreshTokenTestValue = @"refresh_token";

/*! @var kTestAdditionalParameterKey
    @brief Test key for the @c additionalParameters property.
 */
static NSString *const kTestAdditionalParameterKey = @"A";

/*! @var kTestAdditionalParameterValue
    @brief Test value for the @c additionalParameters property.
 */
static NSString *const kTestAdditionalParameterValue = @"1";

@implementation OIDTokenRequestTests

+ (OIDTokenRequest *)testInstance {
  OIDAuthorizationResponse *authResponse = [OIDAuthorizationResponseTests testInstance];
  NSArray<NSString *> *scopesArray =
      [OIDScopeUtilities scopesArrayWithString:authResponse.request.scope];
  NSDictionary *additionalParameters =
      @{ kTestAdditionalParameterKey : kTestAdditionalParameterValue };
  OIDTokenRequest *request =
      [[OIDTokenRequest alloc] initWithConfiguration:authResponse.request.configuration
                                           grantType:OIDGrantTypeAuthorizationCode
                                   authorizationCode:authResponse.authorizationCode
                                         redirectURL:authResponse.request.redirectURL
                                            clientID:authResponse.request.clientID
                                              scopes:scopesArray
                                        refreshToken:kRefreshTokenTestValue
                                        codeVerifier:authResponse.request.codeVerifier
                                additionalParameters:additionalParameters];
  return request;
}

+ (OIDTokenRequest *)testInstanceCodeExchange {
  OIDAuthorizationResponse *authResponse = [OIDAuthorizationResponseTests testInstance];
  NSArray<NSString *> *scopesArray =
      [OIDScopeUtilities scopesArrayWithString:authResponse.request.scope];
  NSDictionary *additionalParameters =
      @{ kTestAdditionalParameterKey : kTestAdditionalParameterValue };
  OIDTokenRequest *request =
      [[OIDTokenRequest alloc] initWithConfiguration:authResponse.request.configuration
                                           grantType:OIDGrantTypeAuthorizationCode
                                   authorizationCode:authResponse.authorizationCode
                                         redirectURL:authResponse.request.redirectURL
                                            clientID:authResponse.request.clientID
                                              scopes:scopesArray
                                        refreshToken:kRefreshTokenTestValue
                                        codeVerifier:authResponse.request.codeVerifier
                                additionalParameters:additionalParameters];
  return request;
}

+ (OIDTokenRequest *)testInstanceRefresh {
  OIDAuthorizationResponse *authResponse = [OIDAuthorizationResponseTests testInstance];
  NSArray<NSString *> *scopesArray =
      [OIDScopeUtilities scopesArrayWithString:authResponse.request.scope];
  NSDictionary *additionalParameters =
      @{ kTestAdditionalParameterKey : kTestAdditionalParameterValue };
  OIDTokenRequest *request =
      [[OIDTokenRequest alloc] initWithConfiguration:authResponse.request.configuration
                                           grantType:OIDGrantTypeAuthorizationCode
                                   authorizationCode:authResponse.authorizationCode
                                         redirectURL:authResponse.request.redirectURL
                                            clientID:authResponse.request.clientID
                                              scopes:scopesArray
                                        refreshToken:kRefreshTokenTestValue
                                        codeVerifier:authResponse.request.codeVerifier
                                additionalParameters:additionalParameters];
  return request;
}

/*! @fn testCopying
    @brief Tests the @c NSCopying implementation by round-tripping an instance through the copying
        process and checking to make sure the source and destination instances are equivalent.
 */
- (void)testCopying {
  OIDAuthorizationResponse *authResponse = [OIDAuthorizationResponseTests testInstance];
  OIDTokenRequest *request = [[self class] testInstance];

  XCTAssertEqualObjects(request.configuration.authorizationEndpoint,
                        authResponse.request.configuration.authorizationEndpoint);
  XCTAssertEqualObjects(request.grantType, OIDGrantTypeAuthorizationCode);
  XCTAssertEqualObjects(request.authorizationCode, authResponse.authorizationCode);
  XCTAssertEqualObjects(request.redirectURL, authResponse.request.redirectURL);
  XCTAssertEqualObjects(request.clientID, authResponse.request.clientID);
  XCTAssertEqualObjects(request.scope, authResponse.request.scope);
  XCTAssertEqualObjects(request.refreshToken, kRefreshTokenTestValue);
  XCTAssertEqualObjects(request.codeVerifier, authResponse.request.codeVerifier);
  XCTAssertNotNil(request.additionalParameters);
  XCTAssertEqualObjects(request.additionalParameters[kTestAdditionalParameterKey],
                        kTestAdditionalParameterValue);

  OIDTokenRequest *requestCopy = [request copy];

  // Not a full test of the configuration deserialization, but should be sufficient as a smoke test
  // to make sure the configuration IS actually getting carried along in the copy implementation.
  XCTAssertEqualObjects(requestCopy.configuration.authorizationEndpoint,
                        request.configuration.authorizationEndpoint);

  XCTAssertEqualObjects(requestCopy.grantType, request.grantType);
  XCTAssertEqualObjects(requestCopy.authorizationCode, request.authorizationCode);
  XCTAssertEqualObjects(requestCopy.redirectURL, request.redirectURL);
  XCTAssertEqualObjects(requestCopy.clientID, request.clientID);
  XCTAssertEqualObjects(requestCopy.scope, authResponse.request.scope);
  XCTAssertEqualObjects(requestCopy.refreshToken, kRefreshTokenTestValue);
  XCTAssertEqualObjects(requestCopy.codeVerifier, authResponse.request.codeVerifier);
  XCTAssertNotNil(requestCopy.additionalParameters);
  XCTAssertEqualObjects(requestCopy.additionalParameters[kTestAdditionalParameterKey],
                        kTestAdditionalParameterValue);
}

/*! @fn testSecureCoding
    @brief Tests the @c NSSecureCoding by round-tripping an instance through the coding process and
        checking to make sure the source and destination instances are equivalent.
 */
- (void)testSecureCoding {
  OIDAuthorizationResponse *authResponse = [OIDAuthorizationResponseTests testInstance];
  OIDTokenRequest *request = [[self class] testInstance];

  XCTAssertEqualObjects(request.configuration.authorizationEndpoint,
                        authResponse.request.configuration.authorizationEndpoint);
  XCTAssertEqualObjects(request.grantType, OIDGrantTypeAuthorizationCode);
  XCTAssertEqualObjects(request.authorizationCode, authResponse.authorizationCode);
  XCTAssertEqualObjects(request.redirectURL, authResponse.request.redirectURL);
  XCTAssertEqualObjects(request.clientID, authResponse.request.clientID);
  XCTAssertEqualObjects(request.scope, authResponse.request.scope);
  XCTAssertEqualObjects(request.refreshToken, kRefreshTokenTestValue);
  XCTAssertEqualObjects(request.codeVerifier, authResponse.request.codeVerifier);
  XCTAssertNotNil(request.additionalParameters);
  XCTAssertEqualObjects(request.additionalParameters[kTestAdditionalParameterKey],
                        kTestAdditionalParameterValue);

  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:request];
  OIDTokenRequest *requestCopy = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  // Not a full test of the configuration deserialization, but should be sufficient as a smoke test
  // to make sure the configuration IS actually getting serialized and deserialized in the
  // NSSecureCoding implementation. We'll leave it up to the OIDServiceConfiguration tests to make
  // sure the NSSecureCoding implementation of that class is correct.
  XCTAssertEqualObjects(requestCopy.configuration.authorizationEndpoint,
                        request.configuration.authorizationEndpoint);

  XCTAssertEqualObjects(requestCopy.grantType, request.grantType);
  XCTAssertEqualObjects(requestCopy.authorizationCode, request.authorizationCode);
  XCTAssertEqualObjects(requestCopy.redirectURL, request.redirectURL);
  XCTAssertEqualObjects(requestCopy.clientID, request.clientID);
  XCTAssertEqualObjects(requestCopy.scope, authResponse.request.scope);
  XCTAssertEqualObjects(requestCopy.refreshToken, kRefreshTokenTestValue);
  XCTAssertEqualObjects(requestCopy.codeVerifier, authResponse.request.codeVerifier);
  XCTAssertNotNil(requestCopy.additionalParameters);
  XCTAssertEqualObjects(requestCopy.additionalParameters[kTestAdditionalParameterKey],
                        kTestAdditionalParameterValue);
}

@end
