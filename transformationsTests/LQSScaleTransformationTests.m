//
//  LQSScaleTransformationTests.m
//  Snake
//
//  Created by Ariel School on 2014-01-05.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "LQSScaleTransformation.h"
#import <SenTestingKit/SenTestingKit.h>

@interface LQSScaleTransformationTests : SenTestCase

@end

@implementation LQSScaleTransformationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    STFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testZeroScaleTransformations
{
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 1;
        scaleTransormation.scaleY = 1;
        scaleTransormation.scaleZ = 1;
        STAssertNoThrow(scaleTransormation.transformationMatrixInverse, @"The scale transformation should be producing inverse transformation matrices under normal circumstances");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 0;
        scaleTransormation.scaleY = 1;
        scaleTransormation.scaleZ = 1;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the x component is zero");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 1;
        scaleTransormation.scaleY = 0;
        scaleTransormation.scaleZ = 1;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the y component is zero");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 1;
        scaleTransormation.scaleY = 1;
        scaleTransormation.scaleZ = 0;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the z component is zero");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 0;
        scaleTransormation.scaleY = 0;
        scaleTransormation.scaleZ = 1;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the x and y components are zero");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 0;
        scaleTransormation.scaleY = 1;
        scaleTransormation.scaleZ = 0;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the x and z components are zero");
    }
    {
        LQSScaleTransformation *scaleTransormation = [[LQSScaleTransformation alloc] init];
        scaleTransormation.scaleX = 0;
        scaleTransormation.scaleY = 0;
        scaleTransormation.scaleZ = 0;
        STAssertThrows(scaleTransormation.transformationMatrixInverse, @"The scale transformation shouldn't be producing inverse transformation matrices when the x, y, and z components are zero");
    }
}

@end
