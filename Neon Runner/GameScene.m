//
//  NeonRunnerGameScene.m
//  Neon Runner
//
//  Created by Darren Vong on 21/12/2016.
//  Copyright © 2016. All rights reserved.
//
//  A special kind of "subview" - instead of seguing between different views,
//  change scenes within the view instead.

#import "GameScene.h"

#define TRACK_LINE_HEIGHT 10
static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t trapCategory = 0x1 << 1;

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        _lastUpdatedTime = 0.0; //arbitrary value
        _trapSize = size.height/3.5;
        _laneSwitchDistance = size.height/3.0;
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
        
        /* Setting up player in the game */
        [self setUpPlayer];
        
        /* Setting up trap - hardcoded value, to be changed... */
        [self setUpTrap];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
    
}

-(void)setUpPlayer {
    // 150 is just some arbitrary distance declaring how far away the player is from the left of screen
    SKSpriteNode* player = [SKSpriteNode spriteNodeWithImageNamed:@"Character"];
    player.name = @"player";
    player.position = CGPointMake(150, self.frame.size.height/2.0+TRACK_LINE_HEIGHT);
    player.zPosition = 4.0;
    player.size = CGSizeMake((self.frame.size.height/3.0) - 40, (self.frame.size.height/3.0) - 40);
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = trapCategory;
    player.physicsBody.collisionBitMask = trapCategory;
    [self addChild:player];
}

//Probs can remove this later as this is merely experimental code...
-(void)setUpTrap {
    SKSpriteNode* trap = [SKSpriteNode spriteNodeWithImageNamed:@"Spike"];
    trap.name = @"trap";
    trap.position = CGPointMake(self.frame.size.width-50, 20+TRACK_LINE_HEIGHT);
    trap.zPosition = 2.0;
    trap.size = CGSizeMake(self.trapSize, self.trapSize);
    trap.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"Spike.png"]
                                                  size:trap.size];
    trap.physicsBody.categoryBitMask = trapCategory;
    trap.physicsBody.contactTestBitMask = playerCategory;
    trap.physicsBody.collisionBitMask = playerCategory;
    trap.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:trap];
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

// To be implemented...
-(void)swipedUp {
    if ([self.gameModel movePlayer:NR_UP]) {
        NSLog(@"Player moved up to lane %ld", (long)self.gameModel.player.lane);
    }
    
}

// To be implemented...
-(void)swipedDown {
    if ([self.gameModel movePlayer:NR_DOWN]) {
        NSLog(@"Player moved down to lane %ld", (long)self.gameModel.player.lane);
    }
}

// Potentially a good place to perform scene update method here
-(void)update:(NSTimeInterval)currentTime {
    if (self.lastUpdatedTime == 0.0) {
        self.lastUpdatedTime = currentTime;
    }
    
    if (currentTime - self.lastUpdatedTime >= 1) {
        [self.gameModel update];
        self.lastUpdatedTime = currentTime;
    }
//    SKNode* trap = [self childNodeWithName:@"trap"];
//    CGPoint p = trap.position;
//    p.x -= 5;
//    trap.position = p;
    
}

// Quick touch event method to move player towards trap for testing collision
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];
    SKNode* player = [self childNodeWithName:@"player"];
    CGPoint playerPos = player.position;
    
    if (playerPos.x <= touchPos.x) { // touches is to the right
        playerPos.x -= 5;
        if (playerPos.y <= touchPos.y) { // touches to the top
            playerPos.y -= 5;
        }
        else { playerPos.y += 5; }
        player.position = playerPos;
    }
    else {
        playerPos.x += 5;
        if (playerPos.y <= touchPos.y) { // touches to the top
            playerPos.y -= 5;
        }
        else { playerPos.y += 5; }
        player.position = playerPos;
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
        // Game over since player hit trap
        NSLog(@"Player hit trap");
        NSLog(@"Final score: %d", self.gameModel.score);
        self.paused = YES;
        
    }
}

@end
