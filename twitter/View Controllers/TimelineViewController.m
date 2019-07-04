//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;//step 3 VC becomes dataSource and delegate
    self.tableView.delegate = self;//step 3 VC becomes dataSource and delegate
    
    [self fetchTweets];
    
}


-(void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray<Tweet *> *tweets, NSError *error) {// step 4: make an API request
        if (tweets) {
            self.tweets = tweets;// step 6: actually stores data
            [self.tableView reloadData]; // step 7 reload table
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{// step 8 ask them
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.name.text = tweet.user.name;
    cell.actualTweet.text = tweet.text;
    cell.createdAt.text = tweet.createdAtString;
    cell.favorite.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweeted.text =[NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    
    NSString *fullURLString = tweet.user.profilePhoto;
    NSURL *actualURL = [NSURL URLWithString:fullURLString];
    [cell.profilePhoto setImageWithURL:actualURL];
    
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id vc = [segue destinationViewController];
}



@end
