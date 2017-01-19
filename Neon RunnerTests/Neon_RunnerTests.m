//
//  Neon_RunnerTests.m
//  Neon RunnerTests
//
//  Created by aca13amw on 15/11/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NRPlayer.h"
#import "NREnums.h"
#import "NRGameModel.h"

@interface Neon_RunnerTests : XCTestCase

@end

@implementation Neon_RunnerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLaneSwitchMiddleToTop {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneMiddle;
    XCTAssert([testPlayer movePlayer:NR_UP]==YES);
    testPlayer.lane = NRLaneMiddle;
    XCTAssert([model movePlayer:NR_UP]==YES);
}

- (void)testLaneSwitchTopToMiddle {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneTop;
    XCTAssert([testPlayer movePlayer:NR_DOWN]==YES);
    testPlayer.lane = NRLaneTop;
    XCTAssert([model movePlayer:NR_DOWN]==YES);
}

- (void)testLaneSwitchMiddleToBottom {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneMiddle;
    XCTAssert([testPlayer movePlayer:NR_DOWN]==YES);
    testPlayer.lane = NRLaneMiddle;
    XCTAssert([model movePlayer:NR_DOWN]==YES);
}

- (void)testLaneSwitchBottomToMiddle {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneBottom;
    XCTAssert([testPlayer movePlayer:NR_UP]==YES);
    testPlayer.lane = NRLaneBottom;
    XCTAssert([model movePlayer:NR_UP]==YES);
}

- (void)testLaneSwitchTopUpwards {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneTop;
    XCTAssert([testPlayer movePlayer:NR_UP]==NO);
    testPlayer.lane = NRLaneTop;
    XCTAssert([model movePlayer:NR_UP]==NO);
}

- (void)testLaneSwitchBottomDownwards {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NRGameModel* model = [[NRGameModel alloc] init];
    NRPlayer* testPlayer = [[NRPlayer alloc] init];
    model.player = testPlayer;
    testPlayer.lane = NRLaneBottom;
    XCTAssert([testPlayer movePlayer:NR_DOWN]==NO);
    testPlayer.lane = NRLaneBottom;
    XCTAssert([model movePlayer:NR_DOWN]==NO);
}

-(void)testGameModelUpdate {
    NRGameModel* model = [[NRGameModel alloc] init];
    model.score = 100;
    model.trapMovementSpeed = 1.01;
    [model update:640.0];
    XCTAssertEqual(model.score, 101);
    XCTAssertEqualWithAccuracy(model.trapMovementSpeed, 1.01, 0.05);
}

-(void)testGameModelUpdate2 {
    NRGameModel* model = [[NRGameModel alloc] init];
    model.score = 499;
    model.trapMovementSpeed = 1.01;
    [model update:640.0];
    XCTAssertEqual(model.score, 500);
    XCTAssertEqualWithAccuracy(model.trapMovementSpeed, 1.01*1.01, 0.05);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
