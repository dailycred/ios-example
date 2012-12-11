//
//  DCClient.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCClient.h"
#import "DCURL.h"
#import "DCURLParser.h"

@implementation DCClient

static DCClient *instance = nil;
static DCUser *currentUser = nil;

@synthesize clientId, clientSecret, authEndpoint, accessTokenEndpoint, redirectUri, meJsonEndpoint;

+(DCClient*) initWithClientId:(NSString*) aClientId andClientSecret:(NSString*)aClientSecret{
    DCClient *client = [DCClient getClient];
    client.clientId = aClientId;
    client.clientSecret = aClientSecret;
    client.authEndpoint = @"https://www.dailycred.com/oauth/authorize";
    client.accessTokenEndpoint = @"https://www.dailycred.com/oauth/access_token";
    client.meJsonEndpoint = @"https://www.dailycred.com/graph/me.json";
    return client;
}

-(void) authorize{
    DCURL *url = [DCURL URLWithString: authEndpoint];
    url = [url URLbyAppendingParameterWithKey:@"client_id" andValue:clientId];
    if (redirectUri != nil){
        url = [url URLbyAppendingParameterWithKey:@"redirect_uri" andValue:redirectUri];
    }
    [[UIApplication sharedApplication] openURL: url];
}


-(void) authenticateWithCallbackUrl:(NSString *) callback{
    DCURLParser *parser = [[DCURLParser alloc] initWithURLString:callback];
    NSString *code = [parser valueForVariable:@"code"];
    NSString *accessToken = [self getAccessTokenFromCode:code];
    [DCClient setCurrentUser: [[DCUser alloc] initWithAccessToken:accessToken]];
}

+(DCClient *)getClient{
    @synchronized(self)    
    {    
        if(instance==nil)    
        {    
            
            instance= [DCClient new];    
        }    
    }    
    return instance;   
}

-(NSString *)getAccessTokenFromCode:(NSString *)code{
    DCURL *url = [DCURL URLWithString:[NSString stringWithFormat:accessTokenEndpoint]];
    url = [url URLbyAppendingParameterWithKey:@"code" andValue:code];
    url = [url URLbyAppendingParameterWithKey:@"client_secret" andValue:clientSecret];
    NSDictionary* results = [url getJsonResponse];
    NSString *accessToken = [results objectForKey:@"access_token"];
        
    return accessToken;
}

                                    
-(NSDictionary *)getUserFromAccessToken:(NSString *)accessToken{
    DCURL *url = [DCURL URLWithString:meJsonEndpoint];
    url = [url URLbyAppendingParameterWithKey:@"access_token" andValue:accessToken];
    return [url getJsonResponse];
}

+(DCUser *)getCurrentUser{
    if (currentUser == nil){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData *userData = [prefs objectForKey:@"dc_current_user"];
        if (userData != nil){
            currentUser = (DCUser *)[NSKeyedUnarchiver unarchiveObjectWithData:userData];
        }
    }
    return currentUser;
}

+(void)setCurrentUser:(DCUser *)user{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [prefs setObject:userData forKey:@"dc_current_user"];
    currentUser = user;
}

+(void)logout{
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"dc_current_user"];
    currentUser = nil;
}

@end
