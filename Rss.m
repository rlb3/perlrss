#import "Rss.h"


@implementation Rss

@synthesize itemNodes;

-(void) dealloc {
    [itemNodes release];
    [super dealloc];
}

-(NSMutableArray *) fetchData {
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
    return stash;
}

-(Rss *) pull {
    NSURLRequest  *theRequest;
    NSData        *urlData;
    NSError       *error;
    NSXMLDocument *doc;
    NSURLResponse *response;

    theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://search.cpan.org/uploads.rdf"]
                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:30];
    
    urlData = [NSURLConnection sendSynchronousRequest:theRequest
                                    returningResponse:&response
                                                error:&error];
    
    if (!urlData) {
        NSLog(@"ERROR: %@", error);
        return nil;
    }
    
    doc = [[NSXMLDocument alloc] initWithData:urlData
                                      options:0
                                        error:&error];
    if (!doc) {
        NSLog(@"ERROR: %@", error);
        return nil;
    }
    
    itemNodes = [doc nodesForXPath:@"//title" error:&error];
    
    if (!itemNodes) {
        NSLog(@"ERROR: %@", error);
        return nil;
    }
    
    [doc release];
    return self;
}

@end
