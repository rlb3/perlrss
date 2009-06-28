#import <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSData *urlData;
    NSError *error;
    NSXMLDocument *doc;
    NSURLResponse *response;
    NSArray *itemNodes;
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://search.cpan.org/uploads.rdf"]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];
    
    urlData = [NSURLConnection sendSynchronousRequest:theRequest
                                    returningResponse:&response
                                                error:&error];
    
    if (!urlData) {
        NSLog(@"ERROR: %@", error);
        return 1;
    }
    
    doc = [[NSXMLDocument alloc] initWithData:urlData
                                      options:0
                                        error:&error];
    if (!doc) {
        NSLog(@"ERROR: %@", error);
        return 1;
    }
    
    itemNodes = [doc nodesForXPath:@"//title" error:&error];
    
    if (!itemNodes) {
        NSLog(@"ERROR: %@", error);
        return 1;
    }
    
    for (NSXMLElement *line in itemNodes) {
        printf("%s\n", [[line stringValue] UTF8String]);
    }
    
    [pool drain];
    return 0;
}

