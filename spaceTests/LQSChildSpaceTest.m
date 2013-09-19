//
//  LQSChildSpaceTest.m
//  Snake
//
//  Created by Ariel on 2013-09-19.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSChildSpaceTest.h"
#import "LQSChildSpace.h"
#import "ILQSSpaceCollection.h"
#import "LQSTranslationTransformation.h"

@implementation LQSChildSpaceTest

- (void)testAdjacentSpace
{
    LQSChildSpace *childSpace = [[LQSChildSpace alloc] init];
    {
        NSObject<ILQSAdjacentSpace> *space = childSpace;
        NSObject<ILQSSpaceCollection> *adjacentSpaces;
        STAssertNoThrow(adjacentSpaces = space.adjacentSpaces, @"Failed to get the adjacent spaces of the given space");
        STAssertNotNil(adjacentSpaces, @"Got a nil space collection");
        STAssertTrue([adjacentSpaces size] == 0, @"There shouldn't be any adjacent spaces that are to space because none have been added");
        STAssertFalse([adjacentSpaces containsSpace:nil], @"The space should not be saying that a nil space is adjacent to it");
        STAssertFalse([space isAdjacentSpace:nil], @"The space should not be saying that a nil space is adjacent to it");
        STAssertFalse([space isAdjacentSpace:[[LQSChildSpace alloc] init]], @"The space should not be saying that a random space is adjacent to it");
    }
    LQSChildSpace *parentSpace = [[LQSChildSpace alloc] init];
    childSpace.parent = parentSpace;
    {
        NSObject<ILQSAdjacentSpace> *space = childSpace;
        NSObject<ILQSSpaceCollection> *adjacentSpaces;
        STAssertNoThrow(adjacentSpaces = space.adjacentSpaces, @"Failed to get the adjacent spaces of the given space");
        STAssertNotNil(adjacentSpaces, @"Got a nil space collection");
        STAssertTrue([adjacentSpaces size] == 1, @"There should only be one space that is adjacent to space because only one had been added");
        STAssertTrue([adjacentSpaces containsSpace:parentSpace], @"The only space that should have been returned in the collection of adjacent spaces is the parent space");
        STAssertTrue([space isAdjacentSpace:parentSpace], @"The space should say that the parent space is adjacent because it was returned in the collection of adjacent spaces");
        STAssertFalse([space isAdjacentSpace:nil], @"The space should not be saying that a nil space is adjacent to it");
        STAssertFalse([space isAdjacentSpace:[[LQSChildSpace alloc] init]], @"The space should not be saying that a random space is adjacent to it");
        STAssertNil([space transformationObjectToSpace:parentSpace], @"The space should not be creating transformation objects out of nowhere since none have been given to it");
    }
    LQSTranslationTransformation *translationTransformation = [[LQSTranslationTransformation alloc] init];
    childSpace.transformToParent = translationTransformation;
    {
        NSObject<ILQSAdjacentSpace> *space = childSpace;
        NSObject<ILQSSpaceCollection> *adjacentSpaces;
        STAssertNoThrow(adjacentSpaces = space.adjacentSpaces, @"Failed to get the adjacent spaces of the given space");
        STAssertNotNil(adjacentSpaces, @"Got a nil space collection");
        STAssertTrue([adjacentSpaces size] == 1, @"There should only be one space that is adjacent to space because only one had been added");
        STAssertTrue([adjacentSpaces containsSpace:parentSpace], @"The only space that should have been returned in the collection of adjacent spaces is the parent space");
        STAssertTrue([space isAdjacentSpace:parentSpace], @"The space should say that the parent space is adjacent because it was returned in the collection of adjacent spaces");
        STAssertFalse([space isAdjacentSpace:nil], @"The space should not be saying that a nil space is adjacent to it");
        STAssertFalse([space isAdjacentSpace:[[LQSChildSpace alloc] init]], @"The space should not be saying that a random space is adjacent to it");
        NSObject<ILQSTransformation> *transformation = [space transformationObjectToSpace:parentSpace];
        STAssertNotNil(transformation, @"The space should be returning a transformation object since it was goven one");
        STAssertTrue(transformation == translationTransformation, @"The returned transformation should be the translation transformation that was given to the child space");
    }
}

@end
