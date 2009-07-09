#import <Foundation/Foundation.h>
#import "Rss.h"
#import "Email.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool           = [[NSAutoreleasePool alloc] init];
    NSDictionary      *config         = [NSDictionary dictionaryWithContentsOfFile:@"/Users/robert/projects/perlrss/config.plist"];
    NSArray           *modules        = [NSArray arrayWithContentsOfFile:@"/Users/robert/projects/perlrss/modules.plist"];
    NSMutableArray    *seen           = [NSMutableArray arrayWithContentsOfFile:@"/Users/robert/projects/perlrss/seen.plist"];
    NSMutableArray    *changedModules = [NSMutableArray array];
    NSMutableArray    *updateModules  = [[[Rss alloc] init] fetchData];
    Email             *email          = [[Email alloc] initWithConfig:config];

    for (NSDictionary *dict in updateModules) {
        NSString *fullModule = [[dict objectForKey:@"name"] stringByAppendingString:[dict objectForKey:@"version"]];
        if ([seen containsObject:fullModule] == NO) {
            if ([modules containsObject:[dict objectForKey:@"name"]]) {
                [changedModules addObject:dict];
                [seen addObject:fullModule];
            }
        }
    }

    [seen writeToFile:@"/Users/robert/projects/perlrss/seen.plist" atomically:YES];

    if ([changedModules count] != 0) {
        [email sendWithModules:changedModules];
    }

    [updateModules release];
    [pool drain];
    return 0;
}

