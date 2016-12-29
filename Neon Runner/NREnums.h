//
//  NREnums.h
//  Neon Runner
//
//  Created by Darren Vong on 29/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//
//  A bunch of enum constant types to improve the readability of the code.

#ifndef NREnums_h
#define NREnums_h

typedef NS_ENUM(NSInteger, NRLane) {
    NRLaneTop, NRLaneMiddle, NRLaneBottom,
    NRLaneMax // Not really a "valid" lane, only there to give the number of lanes possible
};

typedef NS_ENUM(NSInteger, NRDirection) {
    NR_UP, NR_DOWN
};

#endif /* NREnums_h */
