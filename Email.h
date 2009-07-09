#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface Email : NSObject {
    NSDictionary *config;
}

- (Email *)initWithDict:(NSDictionary *) aDict;
- (void)sendWithArray:(NSArray *) modules;
@end
