//
//  NRGameOverViewController.m
//  Neon Runner
//
//  Created by aca13amw on 16/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameOverViewController.h"

@implementation NRGameOverViewController

-(void)viewDidLoad {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.score];
}

-(IBAction)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)shareToFacebook:(id)sender {
    SLComposeViewController* facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookController setInitialText:[NSString stringWithFormat:@"I have scored %i points on Neon Runner!", self.score]];
    
    // Check if Facebook Service is available first before presenting the controller for user to post
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        facebookController.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                case SLComposeViewControllerResultCancelled:
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
            }
        };
        [self presentViewController:facebookController animated:YES completion:nil];
    }
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Facebook Accounts Available"
                                                                       message:@"There are no Facebook Accounts configured. You can create or log into your Facebook account in Settings."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                              handler:nil];
        UIAlertAction* goToSettingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=FACEBOOK"]];
        }];
        [alert addAction:goToSettingsAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(IBAction)shareToTwitter:(id)sender {
    SLComposeViewController* twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterController setInitialText:[NSString stringWithFormat:@"I have scored %i points on Neon Runner!", self.score]];
    
    // Check if Twitter Service is available first before presenting the controller for user to post
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        twitterController.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                case SLComposeViewControllerResultCancelled:
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
            }
        };
        [self presentViewController:twitterController animated:YES completion:nil];
    }
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Twitter Accounts Available"
                                                                       message:@"There are no Twitter Accounts configured. You can create or log into your Twitter account in Settings."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                             handler:nil];
        UIAlertAction* goToSettingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];
        }];
        [alert addAction:goToSettingsAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NRScoreSubmissionViewController* submitController = [segue destinationViewController];
    submitController.score = self.score;
}

@end
