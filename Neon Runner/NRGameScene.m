//
//  
//  Neon Runner
//
//  Created by Darren Vong on 21/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//
//  A special kind of "subview" - instead of seguing between different views,
//  change scenes within the view instead.

#import "NRGameScene.h"

static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t trapCategory = 0x1 << 1;
static const int MAX_TRAPS = 20;
static const float FPS = 1/60.0;

@implementation NRGameScene

-(instancetype)initWithSize:(CGSize)size model:(NRGameModel *)model controller:(UIViewController*)controller{
    self = [super initWithSize:size];
    if (self) {
        _gameModel = model;
        _trapSize = size.height/6.0;
        _laneSwitchDistance = size.height/3.0;
        _trackBorderHeight = size.height * 0.1;
        _newTrapsRequired = YES;
        _controller = controller;
        SKSpriteNode* laneBackground = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        laneBackground.position = CGPointMake(size.width/2, size.height/2);
        laneBackground.size = size;
        [self addChild:laneBackground];
        self.scaleMode = SKSceneScaleModeResizeFill;
        
        /* Setting up game scene boundary */
        SKSpriteNode* topEdge = [self makeGameBoundary:CGPointMake(0, self.size.height)
                                        ofSize:CGSizeMake(size.width, 0)];
        [self addChild:topEdge];
        SKSpriteNode* bottomEdge = [self makeGameBoundary:CGPointMake(0, 0) ofSize:CGSizeMake(size.width, 0)];
        [self addChild:bottomEdge];
        
        
        [self setUpPlayer];
        [self setUpScoreLabel];
        [self setUpTraps];
        [self setUpPauseButton];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSError* error;
        NSURL* backgroundMusicURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"fxMusic" ofType:@"wav"]];
        self.fxPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        NSString* backgroundMusicVolume = [[NSUserDefaults standardUserDefaults] stringForKey:@"fxVolume"];
        [self.fxPlayer setVolume: [backgroundMusicVolume floatValue]];
    }
    return self;
}

-(void)setUpPlayer {
    // 150 is just some arbitrary distance declaring how far away the player is from the left of screen
    SKSpriteNode* player = [SKSpriteNode spriteNodeWithImageNamed:@"Character"];
    player.name = @"player";
    player.size = CGSizeMake((self.frame.size.height/4.0) - 40, (self.frame.size.height/4.0) - 40);
    player.position = CGPointMake(150, self.frame.size.height / 2.0 - 20);
    player.zPosition = 4.0;
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = trapCategory;
    player.physicsBody.collisionBitMask = trapCategory;
    [self addChild:player];
}

-(void)setUpTraps {
    
    for(int i=0;i<MAX_TRAPS;i++) {
        SKSpriteNode* trap = [SKSpriteNode spriteNodeWithImageNamed:@"Spike"];
        trap.name = @"trap";
        trap.hidden = YES;
        trap.size = CGSizeMake(self.trapSize, self.trapSize);
        trap.position = CGPointMake(self.frame.size.width + trap.size.width/2, self.trackBorderHeight);
        trap.zPosition = 2.0;
        trap.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"Spike.png"]
                                                     size:trap.size];
        trap.physicsBody.categoryBitMask = trapCategory;
        trap.physicsBody.contactTestBitMask = playerCategory;
        trap.physicsBody.collisionBitMask = playerCategory;
        trap.physicsBody.usesPreciseCollisionDetection = YES;
        [self addChild:trap];
    }

}

-(void)setUpScoreLabel {
    SKLabelNode* scoreLabel = [SKLabelNode labelNodeWithText:@"Score: 0"];
    scoreLabel.name = @"score";
    scoreLabel.position = CGPointMake(100, self.frame.size.height-30);
    scoreLabel.zPosition = 3.0;
    scoreLabel.fontColor = [SKColor whiteColor];
    scoreLabel.fontSize = 24;
    [self addChild:scoreLabel];
}

-(void)setUpPauseButton {
    SKLabelNode* pauseButton = [SKLabelNode labelNodeWithText:@"| |"];
    pauseButton.name = @"pause";
    pauseButton.fontName = @"Helvetica-Bold";
    pauseButton.position = CGPointMake(self.frame.size.width-50, self.frame.size.height-35);
    pauseButton.zPosition = 1.0;
    pauseButton.fontColor = [SKColor whiteColor];
    pauseButton.fontSize = 24;
    [self addChild:pauseButton];
}

-(void)updateTrapPositions {
    //Check trap array
    //If trap is visible then move  x-variable each time
    //If new traps need to be drawn, finds a hidden trap and places into the correct lane and then shows the trap (exception for when game starts)
    __block int numTrapsToAdd = (arc4random() % 2) + 1;
    __block int lastLane = 5;
    __block SKSpriteNode* lastTrap;
    [self enumerateChildNodesWithName:@"trap" usingBlock:^(SKNode *node, BOOL *stop) {
        //Operate on each trap. Doctor we have to save the trap. It's a trap - Admiral Ackbar
        if (!node.hidden) {
            node.position = CGPointMake(node.position.x - self.gameModel.trapMovementSpeed, node.position.y);
        }
        
        if (node.position.x <= 0) {
            [node setHidden:YES];
        }
        
        if (numTrapsToAdd == 0) {
            [self setNewTrapsRequired:NO];
            lastLane = 5;
        }
        
        if (self.newTrapsRequired && node.hidden) {
            int lane = (NRLane) arc4random() % 3;
            
            while (lane == lastLane) {
                lane = (NRLane) arc4random() % 3;
            }
            
            switch (lane) {
                case NRLaneBottom:
                    node.position = CGPointMake(self.frame.size.width, self.trackBorderHeight);
                    break;
                case NRLaneMiddle:
                    node.position = CGPointMake(self.frame.size.width, self.trackBorderHeight + self.frame.size.height/3.0);
                    break;
                case NRLaneTop:
                    node.position = CGPointMake(self.frame.size.width, self.trackBorderHeight + 2/3.0 * self.frame.size.height);
                    break;
                default:
                    break;
            }
            lastLane = lane;
            numTrapsToAdd -= 1;
            [node setHidden:NO];
        }
        
        
        if (!node.hidden && node.position.x > lastTrap.position.x) {
            lastTrap = (SKSpriteNode*)node;
        }
    }];
    SKSpriteNode* player = (SKSpriteNode*) [self childNodeWithName:@"player"];
    if (lastTrap.position.x < (self.frame.size.width - (player.size.width * 1.7) - lastTrap.size.width)) {
        [self setNewTrapsRequired:YES];
    }
}

-(SKSpriteNode*)makeGameBoundary:(CGPoint)position ofSize:(CGSize)size {
    SKSpriteNode* boundary = [[SKSpriteNode alloc]initWithColor:[SKColor yellowColor] size:size];
    boundary.position = position;
    boundary.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0)
                                                       toPoint:CGPointMake(boundary.size.width, 0)];
    return boundary;
}

-(void)didMoveToView:(SKView *)view {
    //Setting up gesture recognisers to detect swipe motion...
    UISwipeGestureRecognizer *upRecogniser = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(swipedUp)];
    upRecogniser.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:upRecogniser];
    
    UISwipeGestureRecognizer *downRecogniser = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(swipedDown)];
    downRecogniser.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer:downRecogniser];
}

-(void)swipedUp {
    if ([self.gameModel movePlayer:NR_UP]) {
        [self movePlayer:NR_UP];
        [self.fxPlayer play];
    }
    
}

-(void)swipedDown {
    if ([self.gameModel movePlayer:NR_DOWN]) {
        [self movePlayer:NR_DOWN];
        [self.fxPlayer play];
    }
}

-(void)movePlayer:(NRDirection)direction {
    SKNode* player = [self childNodeWithName:@"player"];
    float rotateAngle;
    float moveY;
    if (direction == NR_UP) {
        rotateAngle = -1.5708;
        moveY = self.laneSwitchDistance;
    } else {
        rotateAngle = 1.5708;
        moveY = -self.laneSwitchDistance;
    }
    SKAction* rotate = [SKAction rotateByAngle:rotateAngle duration:0.5];
    SKAction* move = [SKAction moveByX:0 y:moveY duration:0.5];
    SKAction* animate = [SKAction group:@[rotate, move]];
    [player runAction:animate];
}

// Potentially a good place to perform scene update method here
-(void)update:(NSTimeInterval)currentTime {
    
    if (self.gameModel.lastUpdatedTime == 0.0) {
        self.gameModel.lastUpdatedTime = currentTime;
    }
    
    if (currentTime - self.gameModel.lastUpdatedTime >= FPS) {
        [self.gameModel update:self.frame.size.width];
        SKLabelNode* scoreLabel = (SKLabelNode*)[self childNodeWithName:@"score"];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
        self.gameModel.lastUpdatedTime = currentTime;
        [self updateTrapPositions];
    }
}

// SKPhysicsContactDelegate protocol method for collision detection
-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == trapCategory) {
        self.paused = YES;
        [self.controller performSegueWithIdentifier:@"gameOver" sender:self];
    }
}

@end
