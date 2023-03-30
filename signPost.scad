$fn = $preview ? 32 : 64; // reduce for potato

// parameters
signFont = "Major Snafu:style=Regular"; // don't forget to input an installed font
signText = ["Paccino"]; 				// ["your","text","here"]
textSize = 19;							// if you change this you have to fiddle with the offsets (todo)

// build the sign
module signBody() {
	for (i=[0:len(signText)-1]) {
		translate([0,-i * (textSize+0.3),0]) // offset 0.3
			difference() { 
				difference() { // uncomment the second object to save a little material
					hull() linear_extrude(1.5) offset(r=2.5) text(signText[i],size=textSize,halign="center", valign="center", font=signFont);
					// translate([0,0,0.5]) hull() linear_extrude(2) text(signText[i],size=textSize,halign="center", valign="center", font=signFont);
				}
				translate([0,0,-1]) linear_extrude(3) text(signText[i],size=textSize,halign="center",valign="center",font=signFont);
			}
	}
}

// build the stem
module signPost() {
	union() {
		translate([-2,0,0]) cube([4,50,1.5]);
		translate([0,-2,0]) linear_extrude(1.5) polygon(points=[[0,-1],[-2,2],[2,2]], paths=[[0,1,2]]);
	}
}

// combine both bodies
union() {
	signBody();
	translate([0,-(len(signText)+2)*textSize-3]) signPost(); // offset -3
}
