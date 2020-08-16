color ("white") linear_extrude (height=25.4)

total_h = 25.4
l_min_d = 3
l_max_d = 10
board_h = 18.5
plug_back_h = 6.7
plug_front_h = 12.4
plug_d = 5
conn_d = 2.4
conn_h = 6.5
back_d = conn_d + plug_d

polygon(points=[[0, conn_h/2], [0, total_h/2], [l_min_d, total_h/2], [l_min_d, total_h/2 - board_h],
                [l_max_d, total_h/2 - board_h], [l_min_d, -total_h/2], [0, -total_h/2], [0, -conn_h/2],
                [-conn_d, -conn_h/2], [-conn_d, -plug_front_h], [-back_d, -plug_back_h/2],
                [-back_d, plug_back_h/2], [-conn_d, plug_front_h/2], [-conn_d, conn_h/2], [0, conn_h/2]]);
