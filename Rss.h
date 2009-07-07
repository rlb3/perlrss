#import <Foundation/Foundation.h>


@interface Rss : NSObject {
    NSArray *itemNodes;
    NSString *theUrl;
}

@property (readonly) NSArray *itemNodes;

-(Rss *) pull;
-(NSMutableArray *) fetchData;

@end
