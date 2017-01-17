//
//  NRScoreSubmissionViewController.m
//  Neon Runner
//
//  Created by Ka Chon Vong on 17/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRScoreSubmissionViewController.h"
#define MAX_NUM_SCORES 5

@interface NRScoreSubmissionViewController ()

@end

@implementation NRScoreSubmissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.delegate = self;
    self.scoreLabel.text = [NSString stringWithFormat:@"Your Score: %i", self.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)submitScore {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"scores.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSMutableArray* scores;
    if ([fileManager fileExistsAtPath:path]) {
        scores = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    else {
        scores = [[NSMutableArray alloc]init];
    }
    
    [scores addObject:[NSString stringWithFormat:@"%@,%i",self.nameField.text,self.score]];
    // Sorts score
    [scores sortUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        int score1 = [[obj1 componentsSeparatedByString:@","][1] intValue];
        int score2 = [[obj2 componentsSeparatedByString:@","][1] intValue];
        // The logic here is reversed since we want to sort this in descending order (method sorts in ascending order by default)
        if (score1 > score2) {
            return NSOrderedAscending;
        }
        else if (score1 < score2) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
        
    }];
    
    // Removes the lowest score if there are too many scores
    if ([scores count] > MAX_NUM_SCORES) {
        [scores removeLastObject];
    }
    
    return [scores writeToFile:path atomically:YES];
}

-(IBAction)onSubmit {
    if (self.nameField.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Empty Name" message:@"Please type in your name before submitting your score." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        BOOL didWriteToFile = [self submitScore];
        if (didWriteToFile) {
            UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your score has been successfully submitted." preferredStyle:UIAlertControllerStyleAlert];
            [confirmation addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:confirmation animated:YES completion:nil];
        }
    }
}

-(IBAction)onCancel {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
