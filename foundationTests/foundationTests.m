//
//  foundationTests.m
//  foundationTests
//
//  Created by Ariel on 2013-09-27.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface foundationTests : SenTestCase

@end

@implementation foundationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMainBundle
{
    STAssertEqualObjects([NSBundle mainBundle].bundlePath,
                         [NSBundle bundleForClass:self.class].bundlePath,
                         @"This is a stupid bug in the foundation or by the configuration of XCode. In reality main bundle should point to the root directory of this test's executable (which should be the \"foundationTests.octest\" directoy)");
}

@end
