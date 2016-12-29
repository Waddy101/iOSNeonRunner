//
//  GameViewController.h
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "NRGameModel.h"

@interface GameViewController : UIViewController

@property (strong) NRGameModel* gameModel;
@property (strong) GameScene* scene;

@end
