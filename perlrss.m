#import <Foundation/Foundation.h>
#import "Rss.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool    = [[NSAutoreleasePool alloc] init];
    NSMutableArray    *data    = [[[Rss alloc] init] fetchData];
    NSArray           *modules = [NSArray arrayWithContentsOfFile:@"/Users/robert/projects/perlrss/modules.plist"];


    NSLog(@"%@", modules);

    [data release];
    [pool drain];
    return 0;
}

