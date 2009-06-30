#import <Foundation/Foundation.h>


@interface Rss : NSObject {
    NSArray *itemNodes;
}

@property (readonly) NSArray *itemNodes;

-(Rss *) pull;
-(NSMutableArray *) fetchData;

@end
