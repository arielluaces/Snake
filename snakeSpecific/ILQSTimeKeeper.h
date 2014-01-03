//
//  ILQSTimeKeeper.h
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSTimeKeeper <NSObject>

- (double)timeSinceFirstResume;
- (double)timeSinceLastResume;
- (double)timeSinceLastUpdate;
- (double)timeSinceLastDraw;

@end
