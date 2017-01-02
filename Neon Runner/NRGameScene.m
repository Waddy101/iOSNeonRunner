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

@implementation NRGameScene

-(instancetype)initWithSize:(CGSize)size model:(NRGameModel *)model {
    self = [super initWithSize:size];
    if (self) {
        _gameModel = model;
        _trapSize = size.height/6.0;
        _laneSwitchDistance = size.height/3.0;
        _trackBorderHeight = size.height * 0.1;
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
        [self setUpTrap:NRLaneBottom];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
    
}

-(void)setUpPlayer {
    // 150 is just some arbitrary distance declaring how far away the player is from the left of screen
    SKSpriteNode* player = [SKSpriteNode spriteNodeWithImageNamed:@"Character"];
    player.name = @"player";
    player.size = CGSizeMake((self.frame.size.height/3.0) - 40, (self.frame.size.height/3.0) - 40);
    player.position = CGPointMake(150, self.frame.size.height / 2.0);
    player.zPosition = 4.0;
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = trapCategory;
    player.physicsBody.collisionBitMask = trapCategory;
    [self addChild:player];
}

-(void)setUpTrap:(NRLane)lane {
    SKSpriteNode* trap = [SKSpriteNode spriteNodeWithImageNamed:@"Spike"];
    trap.name = @"trap";
    trap.size = CGSizeMake(self.trapSize, self.trapSize);
    // This depends on the lane, to be changed...
    switch (lane) {
        case NRLaneBottom:
            trap.position = CGPointMake(self.frame.size.width, self.trackBorderHeight);
            break;
        case NRLaneMiddle:
            trap.position = CGPointMake(self.frame.size.width, self.trackBorderHeight + self.frame.size.height/3.0);
            break;
        case NRLaneTop:
            trap.position = CGPointMake(self.frame.size.width, self.trackBorderHeight + 2/3.0 * self.frame.size.height);
            break;
        default:
            break;
    }
    
    trap.zPosition = 2.0;
    trap.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"Spike.png"]
                                                  size:trap.size];
    trap.physicsBody.categoryBitMask = trapCategory;
    trap.physicsBody.contactTestBitMask = playerCategory;
    trap.physicsBody.collisionBitMask = playerCategory;
    trap.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:trap];
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
        NSLog(@"Player moved up to lane %ld", (long)self.gameModel.player.lane);
    }
    
}

-(void)swipedDown {
    if ([self.gameModel movePlayer:NR_DOWN]) {
        [self movePlayer:NR_DOWN];
        NSLog(@"Player moved down to lane %ld", (long)self.gameModel.player.lane);
    }
}

-(void)movePlayer:(NRDirection)direction {
    SKNode* player = [self childNodeWithName:@"player"];
    CGPoint pos = player.position;
    pos.y = (direction == NR_UP)? pos.y + self.laneSwitchDistance : pos.y - self.laneSwitchDistance;
    player.position = pos;
}

// Potentially a good place to perform scene update method here
-(void)update:(NSTimeInterval)currentTime {
    if (self.gameModel.lastUpdatedTime == 0.0) {
        self.gameModel.lastUpdatedTime = currentTime;
    }
    
    if (currentTime - self.gameModel.lastUpdatedTime >= 1) {
        [self.gameModel update:self.frame.size.width];
        SKLabelNode* scoreLabel = (SKLabelNode*)[self childNodeWithName:@"score"];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
        self.gameModel.lastUpdatedTime = currentTime;
    }
    SKNode* trap = [self childNodeWithName:@"trap"];
    CGPoint p = trap.position;
    p.x -= 5;
    trap.position = p;
    
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
        // Game over since player hit trap
        NSLog(@"Player hit trap");
        NSLog(@"Final score: %d", self.gameModel.score);
        self.paused = YES;
        
    }
}

@end
