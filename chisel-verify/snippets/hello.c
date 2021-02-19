// hello.c
#include "svdpi.h"
#include <stdlib.h>

void c_hello(char* name) {
	printf("Hello from C, %s", name);
}

// hello.sv
module tb;
import "DPI-C" function void c_hello(string name);

	initial main();
	task main();
		c_hello("SystemVerilog");
	endtask
endmodule

// Outputs: "Hello from C, SystemVerilog"
