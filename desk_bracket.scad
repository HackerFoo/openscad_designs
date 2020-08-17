total_h = 25.4;
l_min_d = 3;
l_max_d = 10;
board_h = 18.5;
plug_back_h = 6.7;
plug_front_h = 12.4;
plug_d = 5;
conn_d = 2.4;
conn_h = 6.5;
back_d = conn_d + plug_d;
tip_h = 2;

module bracket_poly() {
  polygon(points=[[0, conn_h/2], [0, total_h/2], [l_min_d, total_h/2], [l_min_d, total_h/2 - board_h],
                  [l_max_d, total_h/2 - board_h], [l_max_d, total_h/2 - board_h - tip_h], [l_min_d, -total_h/2], [0, -total_h/2], [0, -conn_h/2],
                  [-conn_d, -conn_h/2], [-conn_d, -plug_front_h/2], [-back_d, -plug_back_h/2],
                  [-back_d, plug_back_h/2], [-conn_d, plug_front_h/2], [-conn_d, conn_h/2], [0, conn_h/2]]);
}

module bracket() {
  color ("red") linear_extrude (height=25.4) bracket_poly();
}

for(x_i = [0 : 4]) {
  for(y = [0 : 4]) {
    x = x_i + (y % 2) * 0.5;
    translate([18 * x, 18 * y])
      rotate([0,0,-7])
        bracket();
  }
}
