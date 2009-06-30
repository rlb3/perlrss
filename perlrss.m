#import <Foundation/Foundation.h>
#import "Rss.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    Rss *feed = [[Rss alloc] init];
    
    for (NSXMLElement *line in [[feed pull] itemNodes]) {
        printf("%s\n", [[line stringValue] UTF8String]);
    }
    
    [pool drain];
    return 0;
}

