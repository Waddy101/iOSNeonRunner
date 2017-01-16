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

@end
