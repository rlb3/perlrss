#import <Foundation/Foundation.h>
#import "Rss.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSMutableArray    *data = [[[Rss alloc] init] fetchData];
    
    NSLog(@"%@", data);

    [data release];
    [pool drain];
    return 0;
}

