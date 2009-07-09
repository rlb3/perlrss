#import "Email.h"

@implementation Email

@synthesize config;

- (Email *)initWithConfig:(NSDictionary *) aDict {
    self = [super init];
    
    if (self) {
        self.config = aDict;
    }
    return self;
}

- (void)sendWithModules:(NSArray *) modules {
    CTCoreMessage *Msg = [[CTCoreMessage alloc] init];
    [Msg setTo:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"toName"] email:[config objectForKey:@"toAddress"]]]];
    [Msg setFrom:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"fromName"] email:[config objectForKey:@"fromAddress"]]]];
    [Msg setSubject:@"Updated CPAN Modules"];
    
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *dict in modules) {
        [body appendFormat:@"%@ %@\n", [dict objectForKey:@"name"], [dict objectForKey:@"version"]];
        [dict release];
    }
    [Msg setBody:body];
    
    [CTSMTPConnection sendMessage:Msg
                           server:[config objectForKey:@"mailServer"]
                         username:[config objectForKey:@"mailUser"]
                         password:[config objectForKey:@"mailPassword"]
                             port:[[config objectForKey:@"mailPort"] intValue]
                           useTLS:YES
                          useAuth:YES];
    [body release];
    [Msg release];
}

-(void) dealloc {
    [config release];
    [super dealloc];
}
        
         
@end
