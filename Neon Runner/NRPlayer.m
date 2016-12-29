//
//  NRPlayer.m
//  Neon Runner
//
//  Created by Darren Vong on 29/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRPlayer.h"

@implementation NRPlayer

-(instancetype)init {
    self = [super init];
    if (self) {
        _lane = NRLaneMiddle; // initialise player to be in the middle lane
    }
    return self;
}

-(BOOL)movePlayer:(NRDirection)direction {
    if (direction == NR_UP && self.lane != NRLaneTop) {
        self.lane -= 1; // can do this since the enums are merely integers
        return YES;
    }
    else if (direction == NR_DOWN && self.lane != NRLaneBottom) {
        self.lane += 1;
        return YES;
    }
    return NO;
}

@end
