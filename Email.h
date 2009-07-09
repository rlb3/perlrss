#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface Email : NSObject {
    NSDictionary *config;
}

@property (copy) NSDictionary *config;

- (Email *)initWithConfig:(NSDictionary *) aDict;
- (void)sendWithModules:(NSArray *) modules;
@end
