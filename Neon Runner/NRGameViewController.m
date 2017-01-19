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
    NSURL* popSoundURL =[NSURL fileURLWithPath:[mainBundle pathForResource:@"popSound" ofType:@"wav"]];
    self.popSound = [[AVAudioPlayer alloc] initWithContentsOfURL:popSoundURL error:&error];
    NSString* popSoundVolume = [[NSUserDefaults standardUserDefaults] stringForKey:@"fxVolume"];
    [self.popSound setVolume: [popSoundVolume floatValue]];
    
    self.gameModel = [[NRGameModel alloc]init];
    // Create and configure the scene.
    self.scene = [[NRGameScene alloc]initWithSize:skView.bounds.size model:self.gameModel controller:self];
    // Present the scene.
    [skView presentScene:self.scene];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* tap = [touches anyObject];
    SKView* skView = (SKView*)self.view;
    CGPoint loc = [tap locationInNode:skView.scene];
    SKNode* node = [skView.scene nodeAtPoint:loc];
    if ([node.name isEqualToString:@"pause"]) {
        if (self.gameModel.isPaused) {
            skView.scene.paused = NO;
            self.gameModel.isPaused = NO;
        }
        else {
            skView.scene.paused = YES;
            self.gameModel.isPaused = YES;
        }
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NRGameOverViewController* gameOverViewController = [segue destinationViewController];
    [gameOverViewController setScore:self.gameModel.score];
    [self.popSound play];
    [self.backgroundMusic stop];
    // Get rid of scene to prevent a finished game from running in background behind game over screen
    // if user sends the application to background and then brings it back to foreground again
    SKView* skView = (SKView*)self.view;
    [skView presentScene:nil];
}

@end
