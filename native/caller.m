#ifdef EXIST_FOUNDATION
#import <Foundation/Foundation.h>
#endif

#import "caller.h"

void caller()
{
#ifdef WORK_NSLOG
	NSLog(@"Hello world from Objective-C.");
#endif
}
