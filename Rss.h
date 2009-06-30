#import <Foundation/Foundation.h>


@interface Rss : NSObject {
    NSArray *itemNodes;
}

@property (nonatomic, retain) NSArray *itemNodes;

-(Rss *) pull;

@end
