//
//  DCClient.h
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUser.h"

@interface DCClient : NSObject 

@property (strong) NSString *clientId;
@property (strong) NSString *clientSecret;
@property (strong) NSString *authEndpoint;
@property (strong) NSString *accessTokenEndpoint;
@property (strong) NSString *redirectUri;
@property (strong) NSString *meJsonEndpoint;


+(DCClient*) initWithClientId:(NSString*) clientId andClientSecret:(NSString*)clientSecret;

-(void) authorize;

-(void) authenticateWithCallbackUrl:(NSString *) callback;

+(DCClient *)getClient;

-(NSString *)getAccessTokenFromCode:(NSString *)code;

-(NSDictionary *)getUserFromAccessToken:(NSString *)accessToken;

+(DCUser *)getCurrentUser;
+(void)setCurrentUser:(DCUser *)user;
+(void)logout;


@end
