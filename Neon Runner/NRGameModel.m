//
//  NRGameModel.m
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import "NRGameModel.h"

@implementation NRGameModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _score = 0;
        _player = [[NRPlayer alloc]init];
        _traps = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)update {
    self.score += 30;
    NSLog(@"Score increased! woohoo!");
}

-(BOOL)movePlayer:(NRDirection)direction {
    return [self.player movePlayer:direction];
}

// only add a trap after some time since the last one or via some random criteria?
-(void)maybeAddTrap:(NSTimeInterval*)currentTime {
    
}

@end
