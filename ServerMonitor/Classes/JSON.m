//
//  JSON.m
//  ServerMonitor
//
//  Created by Mark Westenberg on 12/10/15.
//  Copyright © 2015 Addcomm Direct B.V. All rights reserved.
//

#import "JSON.h"

@implementation JSON



-(NSDictionary *)doRequest:(NSString *)urlString {
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    if (data == nil)
    {
        return nil;
        
    }
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return response;
    
}


@end
