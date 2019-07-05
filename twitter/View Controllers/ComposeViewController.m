//
//  ComposeViewController.m
//  twitter
//
//  Created by danielavila on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myBox;

@end

@implementation ComposeViewController

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)post:(id)sender {
    [[APIManager shared] postStatusWithText:_myBox.text completion:^(Tweet *tweets, NSError *error) {// step 4: make an API request
        if (tweets) {
            NSLog(@"Works getting home");
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
