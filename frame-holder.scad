frame_h = 40.2;
frame_w = 6.4;

top_tooth_h = 4;
top_tooth_chamfer_d = 1;
top_tooth_chamfer_h = 2.5;
bottom_tooth_h = 1.25;

DEFAULT_FIT = 0.1;
DEFAULT_THICKNESS = 4;

module frame_holder_profile (thickness = DEFAULT_THICKNESS, fit = DEFAULT_FIT) {
  f_h = frame_h + fit;
  f_w = frame_w + fit;

  polygon([
    [0, 0],
    [0, f_h / 2 + thickness],
    [2 * thickness + f_w, f_h / 2 + thickness],
    [2 * thickness + f_w, f_h / 2 - top_tooth_h],
    [thickness + f_w + top_tooth_chamfer_d, f_h / 2 - top_tooth_h],
    [thickness + f_w , f_h / 2 - top_tooth_h + top_tooth_chamfer_h],
    [thickness + f_w, f_h / 2],
    [thickness, f_h / 2],
    [thickness, -f_h / 2],
    [thickness + f_w, -f_h / 2],
    [thickness + f_w, -f_h / 2 + bottom_tooth_h],
    [thickness + f_w+bottom_tooth_h, -f_h / 2],
    [thickness + f_w+bottom_tooth_h, -f_h / 2 - thickness],
    [0, -f_h / 2 - thickness],
  ]);
}

module frame_holder (width, thickness = DEFAULT_THICKNESS, fit = DEFAULT_FIT) {
  rotate([90, 0, 270]) // Rotate to printer coordinates
    translate([0, 0, -width / 2]) // Center our Z (X after rotation)
      linear_extrude(width)
        frame_holder_profile(thickness, fit);
}

module frame_holder_to_top (thickness = DEFAULT_THICKNESS, fit = DEFAULT_FIT) {
  translate([0, 0, (frame_h + fit) / 2 + thickness]) children();
}

module frame_holder_to_bottom (thickness = DEFAULT_THICKNESS, fit = DEFAULT_FIT) {
  translate([0, 0, -(frame_h + fit) / 2 - thickness]) children();
}

frame_holder(4);
