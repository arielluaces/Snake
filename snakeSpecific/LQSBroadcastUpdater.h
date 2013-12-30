//
//  LQSBroadcastUpdater.h
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSUpdatable.h"

@protocol ILQSUpdatableCollection;

@interface LQSBroadcastUpdater : NSObject<ILQSUpdatable>

@property (nonatomic) NSObject<ILQSUpdatableCollection> *updatableArray;

@end
