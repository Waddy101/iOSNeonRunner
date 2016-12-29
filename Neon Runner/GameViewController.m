//
//  GameViewController.m
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// Method to try setting up scene if viewDidLoad doesn't work (i.e. it's too early in the view loading sequence)
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.gameModel = [[NRGameModel alloc]init];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    self.scene = [[GameScene alloc]initWithSize:skView.bounds.size];
    self.scene.gameModel = self.gameModel;
    
    // Present the scene.
    [skView presentScene:self.scene];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
