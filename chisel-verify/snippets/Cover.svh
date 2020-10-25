//Cover.svh
class Cover;
	Myclass mc;
	covergroup cg_bcd;
		BCD: coverpoint mc.bcd {
			bins valid[] = {[0:9]};
			bins others = default;
		}
	endgroup: cg_bcd

	covergroup cg_others;
		VAL: coverpoint mc.value {
			bins low = {[0:20]};
			bins high =  {[235:255]};
			bins bad = {[110:130]};
			bins others = default;
		}

		A: coverpoint mc.a;
		OP: coverpoint mc.op {
			bins toggle = (0 => 1);
		}
		cross A, OP;
	endgroup: cg_others

	function new();
		cg_bcd = new;
		cg_others = new;
	endfunction: new

	function void sample();
		cg_bcd.sample();
		cg_others.sample();
	endfunction: sample
endclass: Cover