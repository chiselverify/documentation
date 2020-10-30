# Step 0: Intro
This is a rundown of how I set up the [sbt-jni](https://github.com/jodersky/sbt-jni) plugin to enable using the JNI and sbt together. The below is an example which should outline all of the required steps for a simple setup. The code 

# Step 1: SBT Setup
Create `build.sbt` with the following contents
```scala
scalaVersion := "2.12.6"
enablePlugins(JniNative)
target in javah := file("src/native/include")
target in nativeCompile := file("lib")
```
Then create `project/plugins.sbt` and add the following line:
```
addSbtPlugin("ch.jodersky" % "sbt-jni" % "1.4.1")
```
# Step 2: Project setup
Add your `.scala` source files to `src/main/scala/<files.scala>`. For each class and object that uses JNI methods, you can use the below template. Only the class is required, the object is simply for testing purposes.

**Note**: sbt-jni doesn't look for classes with the @native modifier in src/test but only in src/main. So to invoke tests using JNI code, we must create the class in src/main, and then invoke it in src/test
```scala
import ch.jodersky.jni.nativeLoader

@nativeLoader("<projName>0") //use NativeLoader to simplify code-reuse in other places
class Myclass {
  // --- Native methods
  @native def digitsum(num: Int): Int
  @native def hello(string: String): String
}

object Myclass {
  // Main method to test our native library
  def main(args: Array[String]): Unit = {
    val mc = new MyClass
    val sum = mc.digitsum(1234)
	 val string = mc.hello("Scala")
	 println(s"$string")	 
    println(s"Digit sum is $sum")

  }
}
```
The line `@nativeLoader("<projName>0")` automatically loads in the shared object file for any other class or object which invokes MyClass. The SBT-JNI extension only generates one .so file for each project, and by default the file is named after the current project / directory. To change this name, add the following line to build.sbt
```scala
name := "<YourPreferredName>"
```
# Step 3: Generate header files
Run
```
sbt javah
```
To generate the header files for your C code. The header files are generated into `src/native/include`. 

# Step 4: Write C-code
For the generated header file, place a C source file in `src/native` and implement the function prototypes declared in the header file. For example:
```C
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
```

# Step 5: Create shared object
To create the shared object file, first run
```sbt nativeInit cmake``` 
to create a CMake Makefile for compilation. Then run 
```sbt nativeCompile``` 
to compile the library.

If all goes well, a shared object should be placed in `lib/bin/lib<projName>0.s0`

# Step 6: Run it!
If all goes well, a simple `sbt run` or `sbt test` should now suffice to run the native code.