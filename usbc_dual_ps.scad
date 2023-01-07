// More information: https://danielupshaw.com/openscad-rounded-corners/

module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}

board_size = [25.4, 25.4, 1.7];
connector_th = 3.6;
connector_w = 9;

module connector() {
  translate([0,3.75,0])
  rotate([90,0,0])
  linear_extrude(height = 7.5)
  hull() {
    translate([-(connector_w-connector_th)/2,0,0]) circle(connector_th/2);
    translate([(connector_w-connector_th)/2,0,0]) circle(connector_th/2);
  }
}

th = [1, 0.05, 1];
under = 0.5;
over = 1;
lip = [0.5, 1.0];
out_d = 5;

module full_case() {
  difference() {
    // outer shell
    translate([-(board_size[0]/2 + th[0]), -(board_size[1]/2 + th[1]), 0])
      roundedcube_simple(board_size + [th[0] * 2, th[1] * 2, connector_th + th[2] * 2 + under + over], false, 1);

    // board slot
    translate([-board_size[0]/2, -board_size[1]/2, th[2] + under])
      cube(board_size);

    // inner cavity
    translate([-(board_size[0]/2 - lip[0]), -(board_size[1]/2 - lip[1]), th[2]])
      cube([board_size[0]-lip[0]*2, board_size[1]-lip[1]*2, under + over + board_size[2] + connector_th]);

    // out port
    translate([0,-12,th[2]+under+board_size[2]+connector_th/2]) connector();

    // in ports
    translate([-(connector_w + out_d)/2,12,th[2]+under+board_size[2]+connector_th/2]) connector();
    translate([(connector_w + out_d)/2,12,th[2]+under+board_size[2]+connector_th/2]) connector();
  }
}

module peg() {
  rotate([-90,0,0]) cylinder(h=5.5, r=th[0]+0.05);
}

module pegs() {
  h = connector_th + board_size[2] + th[2]*2 + under + over - 1;
  w = board_size[0]/2 + th[0] - 1;
  translate([-w, 0, h]) peg();
  translate([w, 0, h]) peg();
  translate([-w, 0, 1]) peg();
  translate([w, 0, 1]) peg();
}

module cutaway() {
  y = board_size[1]/2 - lip[1] - 5;
  translate([-25, y, -25]) cube([50, 50, 50]);
  translate([0,y-5,0]) pegs();
}


translate([0,-3,0])
difference() {
  full_case($fn=50);
  cutaway($fn=50);
}

translate([0, 3, 0])
intersection() {
  full_case($fn=50);
  cutaway($fn=50);
}
