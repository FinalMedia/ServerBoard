//
//  JSON.h
//  ServerMonitor
//
//  Created by Mark Westenberg on 12/10/15.
//  Copyright © 2015 Addcomm Direct B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON : NSObject

-(NSDictionary *)doRequest:(NSString *)urlString;

@end
