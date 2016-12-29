//
//  NRPlayer.h
//  Neon Runner
//
//  Created by Darren Vong on 29/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NREnums.h"

@interface NRPlayer : NSObject

@property (assign) NRLane lane;

-(BOOL)movePlayer:(NRDirection)direction;

@end
