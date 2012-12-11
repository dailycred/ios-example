//
//  DCUser.h
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUser : NSObject

@property (strong) NSString *uuid;
@property (strong) NSString *email;
@property (strong) NSString *display;
@property (strong) NSString *picture;

-(DCUser *)initWithAccessToken:(NSString *)accessToken;

-(void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;
@end
