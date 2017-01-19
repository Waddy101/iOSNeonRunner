//
//  
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameViewController.h"

@implementation NRGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSError* error;
    NSURL* backgroundMusicURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"backgroundMusic" ofType:@"mp3"]];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    NSString* backgroundMusicVolume = [[NSUserDefaults standardUserDefaults] stringForKey:@"bkgVolume"];
    [self.backgroundMusic setVolume: [backgroundMusicVolume floatValue]];
    [self.backgroundMusic setNumberOfLoops:-1];
    [self.backgroundMusic play];
    
    self.gameModel = [[NRGameModel alloc]init];
    // Create and configure the scene.
    self.scene = [[NRGameScene alloc]initWithSize:skView.bounds.size model:self.gameModel controller:self];
        // Present the scene.
    [skView presentScene:self.scene];
    NSLog(@"Width: %f, height: %f", skView.bounds.size.width, skView.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NRGameOverViewController* gameOverViewController = [segue destinationViewController];
    [gameOverViewController setScore:self.gameModel.score];
    [self.backgroundMusic stop];
    // Get rid of scene to prevent a finished game from running in background behind game over screen
    // if user sends the application to background and then brings it back to foreground again
    SKView* skView = (SKView*)self.view;
    [skView presentScene:nil];
}

@end
