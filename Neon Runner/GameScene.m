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

static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t trapCategory = 0x1 << 1;

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        // Only to confirm scene is successfully presented. Shouldn't matter much once background is overlayed on top
        self.backgroundColor = [SKColor redColor];
        self.scaleMode = SKSceneScaleModeResizeFill;
        
        /* Setting up game scene boundary */
        CGMutablePathRef gameBoundaries = CGPathCreateMutable();
        // Move to top right (assuming origin is at bottom left?) of scene
        CGPathMoveToPoint(gameBoundaries, nil, self.frame.size.width, self.frame.size.height);
        // Draw line from top right to top left
        CGPathAddLineToPoint(gameBoundaries, nil, 0, self.frame.size.height);
        // Draw line from top left to bottom left
        CGPathAddLineToPoint(gameBoundaries, nil, 0, 0);
        // Draw line from bottom left to bottom right
        CGPathAddLineToPoint(gameBoundaries, nil, self.frame.size.width, 0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:gameBoundaries];
        // Since this is a C struct, has to manually decrement ref count for ARC to free it
        CGPathRelease(gameBoundaries);
        
        /* Setting up player in the game */
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"Character"];
        // 150 is just some arbitrary distance declaring how far away the player is from the left of screen
        self.player.position = CGPointMake(150, self.frame.size.height/2.0);
        self.player.size = CGSizeMake((self.frame.size.height/3.0) - 20, (self.frame.size.height/3.0) - 20);
        self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.player.size];
        self.player.physicsBody.categoryBitMask = playerCategory;
        self.player.physicsBody.contactTestBitMask = trapCategory;
        self.player.physicsBody.collisionBitMask = trapCategory;
        [self addChild:self.player];
        
        /* Setting up trap */
        self.trap = [SKSpriteNode spriteNodeWithImageNamed:@"Spike"];
        float trapX = (float)(arc4random() % (int)(self.frame.size.width - 50));
        float trapY = (float)(arc4random() % (int)(self.frame.size.height - 50));
        self.trap.position = CGPointMake(trapX, trapY);
        self.trap.size = CGSizeMake(25, 25);
        self.trap.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"Spike.png"]
                                                          size:self.trap.size];
        self.trap.physicsBody.categoryBitMask = trapCategory;
        self.trap.physicsBody.contactTestBitMask = playerCategory;
        self.trap.physicsBody.collisionBitMask = playerCategory;
        self.trap.physicsBody.usesPreciseCollisionDetection = YES;
        [self addChild:self.trap];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
    
}

// Potentially a good place to perform scene update method here
//-(void)update:(NSTimeInterval)currentTime {
//    CGPoint playerPos = self.player.position;
//    playerPos.y -= 10;
//    self.player.position = playerPos;
//    
//}

// Quick touch event method to move player towards trap for testing collision
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];
    CGPoint playerPos = self.player.position;
    
    if (playerPos.x <= touchPos.x) { // touches is to the right
        playerPos.x -= 5;
        if (playerPos.y <= touchPos.y) { // touches to the top
            playerPos.y -= 5;
        }
        else { playerPos.y += 5; }
        self.player.position = playerPos;
    }
    else {
        playerPos.x += 5;
        if (playerPos.y <= touchPos.y) { // touches to the top
            playerPos.y -= 5;
        }
        else { playerPos.y += 5; }
        self.player.position = playerPos;
    }
    
}

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
    
    if ((firstBody.categoryBitMask & playerCategory) != 0 &&
        (secondBody.categoryBitMask & trapCategory) != 0) {
        NSLog(@"Player hit trap");
        [secondBody.node removeFromParent];
        
    }
}

@end
