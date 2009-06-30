//
//  Rss.h
//  perlrss
//
//  Created by Robert Boone on 6/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Rss : NSObject {
    NSArray *itemNodes;
}

@property (nonatomic, retain) NSArray *itemNodes;

-(Rss *) pull;

@end
