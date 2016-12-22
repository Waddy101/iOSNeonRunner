//
//  NeonRunnerGameScene.h
//  Neon Runner
//
//  Created by Darren Vong on 21/12/2016.
//  Copyright © 2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property (strong) SKSpriteNode* player;
@property (strong) SKSpriteNode* trap; // should be an array of them later...
@end
