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


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    __weak IBOutlet UISearchBar *repositorySearchBar;
    __weak IBOutlet UITableView *resultTableView;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    repositorySearchBar.delegate = self;
    resultTableView.dataSource   = self;
    resultTableView.delegate     = self;

    RepositorySearcher *rs = [[RepositorySearcher alloc] init];
    [rs searchWithString:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"repositoryDetailCell";

    RepositoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( !cell ) {
        cell = [[RepositoryDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.fullRepositoryNameLabel.text = @"full_name";

    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"test changed");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancel button tapped");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search button tapped");
}

@end
