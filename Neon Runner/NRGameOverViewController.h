//
//  NRGameOverViewController.h
//  Neon Runner
//
//  Created by aca13amw on 16/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRGameOverViewController : UIViewController

@property (weak) IBOutlet UILabel* scoreLabel;
@property (weak) IBOutlet UIButton* facebookButton;
@property (weak) IBOutlet UIButton* twitterButton;
@property (weak) IBOutlet UIButton* addToScoreboardButton;
@property (assign) int score;

-(IBAction)goBack;
-(IBAction)shareToFacebook:(id)sender;
-(IBAction)shareToTwitter:(id)sender;
-(IBAction)addToScoreboard:(id)sender;

@end