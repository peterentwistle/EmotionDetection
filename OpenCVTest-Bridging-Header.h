//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "OpenCVWrapper.h"


// Test
#ifdef __cplusplus
extern "C" {
#endif
	
	const void *initializeTest(char *filename);
	const char *hexdump(const void *object);
	const char *imageType(const void *object);
	
#ifdef __cplusplus
}
#endif

