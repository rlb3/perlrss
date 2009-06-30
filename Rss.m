//
//  Rss.m
//  perlrss
//
//  Created by Robert Boone on 6/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Rss.h"


@implementation Rss

@synthesize itemNodes;

-(void) dealloc {
    [itemNodes release];
    [super dealloc];
}

-(NSArray *) pull {
    NSURLRequest *theRequest;
    NSData *urlData;
    NSError *error;
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
}

@end
