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


@interface SearchViewController () <UITableViewDataSource,
                                    UITableViewDelegate,
                                    UISearchBarDelegate,
                                    UISearchDisplayDelegate,
                                    RepositorySearcherDelegate>
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

    searcher_ = [[RepositorySearcher alloc] init];
    searcher_.delegate = self;

    repositoryItems_ = [NSArray array];

    self.repositorySearchBar.delegate = self;
    self.resultTableView.dataSource   = self;
    self.resultTableView.delegate     = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearResultDetailCells {
    repositoryItems_ = [NSArray array];
    [self.resultTableView reloadData];
}


#pragma mark - Table View Delegate

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

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.resultTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ( [searchText isEqualToString:@""] ) {
        [self clearResultDetailCells];
    } else {
        [searcher_ searchWithQueryString:searchText];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.repositorySearchBar.text = @"";
    [self clearResultDetailCells];
    [self.repositorySearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.repositorySearchBar resignFirstResponder];
}

#pragma mark - Repository Searcher Delegate

- (void)updateRepositoryItems:(NSArray *)items {
    dispatch_async(dispatch_get_main_queue(), ^{
        repositoryItems_ = items;
        [self.resultTableView reloadData];
    });
}


@end
