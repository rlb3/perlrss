#import <Foundation/Foundation.h>
#import "Rss.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool          = [[NSAutoreleasePool alloc] init];
    NSMutableArray    *updateModules = [[[Rss alloc] init] fetchData];
    NSArray           *modules       = [NSArray arrayWithContentsOfFile:@"/Users/robert/project/perlrss/modules.plist"];
    NSMutableArray    *seen          = [NSMutableArray arrayWithContentsOfFile:@"/Users/robert/project/perlrss/seen.plist"];

    for (NSDictionary *dict in updateModules) {
        NSString *fullModule = [[dict objectForKey:@"name"] stringByAppendingString:[dict objectForKey:@"version"]];
        if ([seen containsObject:fullModule] == NO) {
            if ([modules containsObject:[dict objectForKey:@"name"]]) {
                // Send email
                [seen addObject:fullModule];
            }
        }
    }

    [seen writeToFile:@"/Users/robert/project/perlrss/seen.plist" atomically:YES];

    [updateModules release];
    [pool drain];
    return 0;
}

