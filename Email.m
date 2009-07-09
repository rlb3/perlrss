#import "Email.h"

@implementation Email

- (Email *)initWithDict:(NSDictionary *) aDict {
    self = [super init];
    
    if (self) {
        config = aDict;
    }
    return self;
}

- (void)sendWithArray:(NSArray *) modules {
    CTCoreMessage *Msg = [[CTCoreMessage alloc] init];
    [Msg setTo:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"toName"] email:[config objectForKey:@"toAddress"]]]];
    [Msg setFrom:[NSSet setWithObject:[CTCoreAddress addressWithName:[config objectForKey:@"fromName"] email:[config objectForKey:@"fromAddress"]]]];
    [Msg setSubject:@"Updated CPAN Modules"];
    
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *dict in modules) {
        [body appendFormat:@"%@ %@\n", [dict objectForKey:@"name"], [dict objectForKey:@"version"]];
    }
    [Msg setBody:body];
    
    [CTSMTPConnection sendMessage:Msg
                           server:[config objectForKey:@"mailServer"]
                         username:[config objectForKey:@"mailUser"]
                         password:[config objectForKey:@"mailPassword"]
                             port:[[config objectForKey:@"mailPort"] intValue]
                           useTLS:YES
                          useAuth:YES];
    [Msg release];
}

-(void) dealloc {
    [config release];
    [super dealloc];
}
        
         
@end
