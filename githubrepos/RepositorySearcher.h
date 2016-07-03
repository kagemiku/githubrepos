//
//  RepositorySearcher.h
//  githubrepos
//
//  Created by KAGE on 7/3/16.
//  Copyright © 2016 KAGE. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RepositorySearcher;

@protocol RepositorySearcherDelegate <NSObject>

@required
- (void)updateRepositoryItems:(NSArray *)items;

@end


@interface RepositorySearcher : NSObject

@property (nonatomic, weak) id<RepositorySearcherDelegate> delegate;

- (id)init;
- (void)searchWithQueryString:(NSString *)query;

@end
