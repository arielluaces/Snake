//
//  LQSBroadcastUpdater.m
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSBroadcastUpdater.h"
#import "LQSUpdatableArray.h"

@implementation LQSBroadcastUpdater

- (void)update
{
    for (NSObject<ILQSUpdatable> *updatable in _updatableArray) {
        [updatable update];
    }
}

@end
