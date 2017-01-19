//
//  Neon_RunnerUITests.m
//  Neon RunnerUITests
//
//  Created by aca13amw on 15/11/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Neon_RunnerUITests : XCTestCase

@end

@implementation Neon_RunnerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

-(void)testSettingsButtonAndBackButton {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Settings"] tap];
    XCTAssertTrue(app.staticTexts[@"Music Volume"].exists);
    [app.buttons[@"Go Back"] tap];
    XCTAssertTrue(app.staticTexts[@"Neon Runner"].exists);
}

-(void)testScoreboardButtonAndBackButton {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Scoreboard"] tap];
    XCTAssertTrue(app.staticTexts[@"Username"].exists);
    [app.buttons[@"Go Back"] tap];
    XCTAssertTrue(app.staticTexts[@"Neon Runner"].exists);
}

-(void)testResetDataFunction {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Start"] tap];
    XCUIElement *testEle= app.staticTexts[@"Game Over"];
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:exists evaluatedWithObject:testEle handler:nil];
    [self waitForExpectationsWithTimeout:10 handler:nil];
    [app.buttons[@"Add to Scoreboard"] tap];
    XCUIElement *textField = [app.textFields elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"Adam"];
    [textField typeText:@"\n"];
    [app.buttons[@"Submit Score"] tap];
    [app.alerts[@"Success!"].collectionViews.buttons[@"OK"] tap];
    
    XCUIElement *scoreboardButton = app.buttons[@"Scoreboard"];
    [scoreboardButton tap];
    XCTAssertTrue(app.staticTexts[@"a"].exists);
    XCUIElement *goBackButton = app.buttons[@"Go Back"];
    [goBackButton tap];
    [app.buttons[@"Settings"] tap];
    [app.buttons[@"Reset Data"] tap];
    [app.alerts[@"Success"].collectionViews.buttons[@"OK"] tap];
    [goBackButton tap];
    [scoreboardButton tap];
    XCTAssertFalse(app.staticTexts[@"a"].exists);
  
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
