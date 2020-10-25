//Myclass.svh
class Myclass;
	rand logic [3:0] bcd;
	rand logic [7:0] value;
	rand logic [3:0] a, b, c;
	rand logic [1:0] op;
	
	constraint c_BCD {
		bcd inside {[0:9]};
	}
	constraint c_value {
		value dist {
			0:/1,
			[1:254]:/1,
			255:/1
		};
	}
	constraint c_abc {
		0 < a;
		a < b;
		b < c;
	}
	// op isn't constrained, but is randomized
endclass: Myclass