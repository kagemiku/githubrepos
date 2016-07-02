//
//  RepositorySearcher.mm
//  githubrepos
//
//  Created by KAGE on 7/3/16.
//  Copyright © 2016 KAGE. All rights reserved.
//

#import "RepositorySearcher.h"
#import "AFNetworking.h"

@interface RepositorySearcher ()

@end


@implementation RepositorySearcher

- (id)init {
    self = [super init];
    if ( self ) {
    }

    return self;
}

- (void)searchWithString:(NSString *)query {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/search/repositories"
      parameters:@{@"q": @"tetris"}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSLog(@"JSON: %@", responseObject);

             NSArray *formattedItems = [self composeArrayForReturnFromJSON:responseObject];
             NSLog(@"items: %@", formattedItems);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }
     ];
}

- (NSArray *)composeArrayForReturnFromJSON:(NSDictionary *)json {
    NSArray *items = json[@"items"];
    NSMutableArray *formattedItems = [NSMutableArray array];

    NSArray *keys = @[@"full_name"];

    for ( NSDictionary *item in items ) {
        NSDictionary *formattedItem = [self extractSpecificKeys:keys fromJSON:item];
        [formattedItems addObject:formattedItem];
    }

    return formattedItems;
}

- (NSDictionary *)extractSpecificKeys:(NSArray *)keys fromJSON:(NSDictionary *)json {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for ( NSString *key in [json keyEnumerator] ) {
        if ( [keys containsObject:key] ) {
            [dic setValue:json[key] forKey:key];
        }
    }

    return dic;
}

@end

