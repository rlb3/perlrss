#import <Foundation/Foundation.h>
#import "Rss.h"
#import <MailCore/MailCore.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool          = [[NSAutoreleasePool alloc] init];
    NSDictionary      *config        = [NSDictionary dictionaryWithContentsOfFile:@"/Users/robert/project/perlrss/config.plist"];
    NSArray           *modules       = [NSArray arrayWithContentsOfFile:@"/Users/robert/project/perlrss/modules.plist"];
    NSMutableArray    *seen          = [NSMutableArray arrayWithContentsOfFile:@"/Users/robert/project/perlrss/seen.plist"];
    NSMutableArray    *updateModules = [[[Rss alloc] init] fetchData];

    NSLog(@"%@", config);

    for (NSDictionary *dict in updateModules) {
        NSString *fullModule = [[dict objectForKey:@"name"] stringByAppendingString:[dict objectForKey:@"version"]];
        if ([seen containsObject:fullModule] == NO) {
            if ([modules containsObject:[dict objectForKey:@"name"]]) {
                // EMAIL
                [seen addObject:fullModule];
            }
        }
    }

    [seen writeToFile:@"/Users/robert/project/perlrss/seen.plist" atomically:YES];

    CTCoreMessage *testMsg = [[CTCoreMessage alloc] init];
    [testMsg setTo:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"toName"] email:[config objectForKey:@"toAddress"]]]];
    [testMsg setFrom:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"fromName"] email:[config objectForKey:@"fromAddress"]]]];
    [testMsg setBody:@"This is a test message!"];
    [testMsg setSubject:@"This is a subject"];

    [CTSMTPConnection sendMessage:testMsg
                           server:[config objectForKey:@"mailServer"]
                         username:[config objectForKey:@"mailUser"]
                         password:[config objectForKey:@"mailPassword"]
                             port:25
                           useTLS:YES
                          useAuth:YES];
    [testMsg release];

    NSLog(@"%@", updateModules);
    [updateModules release];
    [pool drain];
    return 0;
}

