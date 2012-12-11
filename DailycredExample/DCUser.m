//
//  DCUser.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCUser.h"
#import "DCClient.h"

@implementation DCUser

@synthesize uuid, email, display, picture;

-(DCUser *)initWithAccessToken:(NSString *)accessToken{
    NSDictionary *response = [[DCClient getClient] getUserFromAccessToken:accessToken];
    self.uuid = [response objectForKey:@"id"];
    self.email = [response objectForKey:@"email"];
    self.display = [response objectForKey:@"display"];
    self.picture = [response objectForKey:@"picture"];
    return self;
}

-(NSString *)description{
    return self.display;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.display forKey:@"display"];
    [encoder encodeObject:self.picture forKey:@"picture"];
    [encoder encodeObject:self.uuid forKey:@"uuid"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    if((self = [super init])) {
        self.picture = [decoder decodeObjectForKey:@"picture"];
        self.display = [decoder decodeObjectForKey:@"display"];
        self.uuid = [decoder decodeObjectForKey:@"uuid"];
        self.email = [decoder decodeObjectForKey:@"email"];
    }
    return self;
}

@end
