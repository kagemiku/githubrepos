//
//  SearchViewController.mm
//  githubrepos
//
//  Created by KAGE on 7/2/16.
//  Copyright © 2016 KAGE. All rights reserved.
//

#import "SearchViewController.h"
#import "RepositorySearcher.h"

@interface RepositoryDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullRepositoryNameLabel;

@end

@implementation RepositoryDetailCell

@end


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, RepositorySearcherDelegate>
{
    RepositorySearcher *searcher_;
    NSArray *repositoryItems_;
}

@property (weak, nonatomic) IBOutlet UISearchBar *repositorySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.repositorySearchBar.delegate = self;
    self.resultTableView.dataSource   = self;
    self.resultTableView.delegate     = self;

    searcher_ = [[RepositorySearcher alloc] init];
    searcher_.delegate = self;

    repositoryItems_ = [NSArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return repositoryItems_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"repositoryDetailCell";

    RepositoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( !cell ) {
        cell = [[RepositoryDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.fullRepositoryNameLabel.text = repositoryItems_[indexPath.row][@"full_name"];
    NSLog(@"text: %@", cell.fullRepositoryNameLabel.text);

    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [searcher_ searchWithString:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancel button tapped");

    repositoryItems_ = [NSArray array];
    [self.resultTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search button tapped");
}

- (void)updateRepositoryItems:(NSArray *)items {
    dispatch_async(dispatch_get_main_queue(), ^{
        repositoryItems_ = items;
        [self.resultTableView reloadData];
    });
}

@end
