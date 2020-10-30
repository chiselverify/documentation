#include "MyClass.h"
#include <stdlib.h>

JNIEXPORT jint JNICALL Java_MyClass_digitsum 
(JNIEnv * env, jobject obj, jint num) {
	int i = num;
	int sum = 0;
	while(i) {
		sum += i % 10;
		i = i / 10;
	}
	return sum;
}

JNIEXPORT jstring JNICALL Java_MyClass_hello 
(JNIEnv * env, jobject obj, jstring string) {
    const char* str = (*env)->GetStringUTFChars(env, string, 0);
    char buf[128];
	 snprintf(buf, 128, "Hello from C, %s", str);
    (*env)->ReleaseStringUTFChars(env, string, str);
    return (*env)->NewStringUTF(env,buf);	
}
