import ch.jodersky.jni.nativeLoader

@nativeLoader("native0") //use NativeLoader to simplify code-reuse in other places
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
//Outputs: 
//Hello from C, Scala
//Digit sum is 10
			  