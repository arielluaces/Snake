//
//  LQSSpaceCollectionTest.m
//  Snake
//
//  Created by Ariel on 2013-09-19.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSpaceCollectionTest.h"
#import "LQSSpaceCollection.h"
#import "LQSChildSpace.h"

@implementation LQSSpaceCollectionTest

- (void)testSpaceCollection
{
    LQSSpaceCollection *spaceCollection = [[LQSSpaceCollection alloc] init];
    STAssertTrue([spaceCollection size]==0, @"The initial size of the space collection should be 0");
    STAssertFalse([spaceCollection containsSpace:[[LQSChildSpace alloc] init]], @"The space collection should not say that it contains a random space");
    STAssertFalse([spaceCollection containsSpace:nil], @"The space collection should not say that it contains a nil space");
    LQSSpaceCollection *spaceCollection2 = [[LQSSpaceCollection alloc] init];
    STAssertTrue([spaceCollection containsSpaces:spaceCollection2], @"The empty space collection should say that it contains an empty space collection");
    [spaceCollection2 addSpace:[[LQSChildSpace alloc] init]];
    STAssertFalse([spaceCollection containsSpaces:spaceCollection2], @"The empty space collection should say that it does not contain a non empty space collection");
    STAssertTrue([spaceCollection2 containsSpaces:spaceCollection], @"A nonempty space collection should say that it contains an empty space collection");
    [spaceCollection addSpace:[[LQSChildSpace alloc] init]];
    STAssertTrue([spaceCollection size]==1, @"A space collection where one space was added should say that it has a size of 1");
    STAssertFalse([spaceCollection containsSpaces:spaceCollection2], @"A space collection with one space should say that it does not contain a space collection with another space");
    STAssertFalse([spaceCollection2 containsSpaces:spaceCollection], @"A space collection with one space should say that it does not contain a space collection with another space");
    [spaceCollection addSpaces:spaceCollection2];
    STAssertTrue([spaceCollection size]==2, @"A space collection with a single space where another space collection with another single space is added, should say that it now has a size of 2");
    STAssertTrue([spaceCollection containsSpaces:spaceCollection2], @"When a space collection is added to another space collection, the second space collection should say that it contains the first space collection");
    [spaceCollection clear];
    STAssertTrue([spaceCollection size] == 0, @"After being cleared, a space collection should say that it has no spaces");
    STAssertFalse([spaceCollection containsSpaces:spaceCollection2], @"After being cleared, space collection1 should not say that it still contains the non empty space collection2");
}

@end
