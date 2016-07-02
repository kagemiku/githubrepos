//
//  RepositorySearcher.h
//  githubrepos
//
//  Created by KAGE on 7/3/16.
//  Copyright © 2016 KAGE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositorySearcher : NSObject

- (id)init;
- (void)searchWithString:(NSString *)query;

@end
