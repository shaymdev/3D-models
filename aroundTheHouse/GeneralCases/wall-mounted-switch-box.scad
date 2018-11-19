module nub (){
	hull () {
		cube ([1.5, 2.75, 4], center=true);
		translate ([-1.125, 0, -1]) {
			rotate (a=90.0, v=[1, 0, 0]) {
				scale ([1.05, 1, 1]) {
					cylinder ($fn=30, h=2.75, r=1, center=true);
				}
			}
		}
	}
}
module twoAdjacentWalls(wallHeight){
	union () {
		translate ([0, 8.325, 0]) {
			cube ([18.9, 2.25, wallHeight], center=true);
		}
		translate ([8.325, 0, 0]) {
			cube ([2.25, 18.9, wallHeight], center=true);
		}
		translate([8.325, 0, wallHeight/2-2]){
			nub();
		}
	}
}

module switchBox(wallHeight=4){
	union () {
		twoAdjacentWalls(wallHeight);
		mirror ([0, 1, 0]) {
			mirror ([1, 0, 0]) {
				twoAdjacentWalls(wallHeight);
			}
		}
	}
}

module screwMount (thickness=2,screwSize=2.5,mountHeight=2){ 
	difference(){
		hull(){
			translate([0,2*screwSize,0]){
				mountPoint(mountHeight,thickness);
			}
			cylinder ($fn=30, h=thickness, r=screwSize+2, center=true);
		}
		cylinder ($fn=30, h=mountHeight*2, r=screwSize, center=true);
	}
}

module mountPoint(height=2,thickness=2) {
	translate([0,0,height/2-thickness/2]){
		cube ([18.9, 2.25, height], center=true);
	}
}

module wireHole(){
	translate([0,-9,-5]){
		rotate (a=90.0, v=[1, 0, 0]) {
			scale ([2, 1.5, 1]) {
				cylinder ($fn=30, h=4, r=2, center=true);
			}
		}
	}
}

module wallMountableSingleSwitchBox(){
	translate([-13.5,0,-4]){
		rotate([0,0,270]){
			screwMount(2,2.5,5);
		}
	}
	difference(){
		switchBox(10);
		wireHole();
	}
}

wallMountableSingleSwitchBox();
