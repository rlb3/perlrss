#import <Foundation/Foundation.h>
#import "Rss.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSMutableArray *stash = [[NSMutableArray alloc] init];

    Rss *feed = [[Rss alloc] init];
    
    for (NSXMLElement *line in [[feed pull] itemNodes]) {
        if ([[line stringValue] isNotEqualTo:@"search.cpan.org"]) {
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[[line stringValue] componentsSeparatedByString:@"-"]];
            NSString *version = [tempArray lastObject];
            [tempArray removeLastObject];

            NSString *moduleName = [tempArray componentsJoinedByString:@"::"];
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];

            [tempDict setObject:moduleName forKey:@"name"];
            [tempDict setObject:version forKey:@"version"];

            [stash addObject:tempDict];

            [tempDict release];
        }
    }

    NSLog(@"%@", stash);

    [stash release];
    [pool drain];
    return 0;
}

