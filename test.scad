
hf=2840; // Height of 2-nd floor
Lx=2900; // Lx of 2-nd floor emulation 
Ns1=5;   // Number of stups in 1-st part
Ns2=3;   // Number of stups in 2-nd part
Ns3=5;   // Number of stups in 3-rd part
Wtet=60; // Tetive's width
HTtet=300; // Tetives height (orthogonal!)
Hsgap=160; // Height of stup
Lsgap=300; // Length of stup
Wstup=900; // Width of stup
Hstup=40;  // Height of stup's material
Rper=25;    // Radius of perill
Hbal=900;
Wbal=90;
Hper=Hbal-Wbal*16/30;   // Height of perill

Shift=10;    // Shift of 2-nd part

Lr=140;  
wr=16;

Wbr=90;
Hbr1=Hsgap*(Ns1+3);
module balyas() {
    Rcyl=Hbal/2; 
    Rcyl2=Rcyl+20;
    Dy=60;
    Dz=70;
    difference(){
        cube([18,Wbal,Hbal]);
        translate([-1,-Rcyl+Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
        translate([-1,Rcyl+Wbal-Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Hbal/2,Hbal/2);
        translate([-1,-Rcyl+Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
        translate([-1,Rcyl+Wbal-Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Hbal/2,Hbal/2);
    };
    intersection(){
          cube([18,Wbal,Hbal]);
        $fn=40;
          union(){
              difference(){
                  intersection(){
                      translate([-1,-Rcyl+Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Rcyl2,Rcyl2);
                      translate([-1,Rcyl+Wbal-Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Rcyl2,Rcyl2);
                  };
                  intersection() {
                      translate([-1,-Rcyl+Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
                      translate([-1,Rcyl+Wbal-Dy,Hbal/2+Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
                  };  
              }
              difference(){
                  intersection(){
                       translate([-1,-Rcyl+Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Rcyl2,Rcyl2);
                       translate([-1,Rcyl+Wbal-Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Rcyl2,Rcyl2);
                  };
                  intersection() {
                    translate([-1,-Rcyl+Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
                    translate([-1,Rcyl+Wbal-Dy,Hbal/2-Dz]) rotate([0,90,0]) cylinder(20,Rcyl,Rcyl);
                  }
              }
          };
    };
    
}


Ly2f=1000;
H2f=150+20+50+10;

Xopd2=Wstup+Wtet+Ns2*Lsgap-2*Wbr+Wstup+Wtet-40-2*Shift;
Yopd2=Lsgap*Ns1+Wtet+Wstup-Wbr-1000-80;
Zopd2=(Ns1+Ns2+4)*Hsgap-40-150;

module stups(Nst=10,Startcut=0,Endcut=0) {
difference(){
for(Ns=[1:1:Nst]) {
  translate([Wtet,(Ns-1)*Lsgap,Ns*Hsgap-Hstup]) cube([Wstup,Lsgap,Hstup]);
  translate([Wtet*1.5+Wstup,Lsgap*0.5-Lr*0.5+(Ns-1)*Lsgap,(Ns)*Hsgap-Hstup+Hsgap*0.5]) 
    if(Ns<Nst) 
      if(Ns>1) {
           translate([0,-50,-50*16/30]) balyas();
           translate([0,-50+Lsgap*0.5,(-50+0.5*Lsgap)*16/30]) balyas();
      }
      else {
          translate([0,20+Startcut,0]) 
               
               translate([0,-50-30-Startcut+Lsgap*0.5,(-50+0.5*Lsgap)*16/30]) balyas();
               //cube([wr,Lr-Startcut,Hper+Lr*16/30]);
      }
    else {
         translate([0,-50,-50*16/30]) balyas();
        //translate([0,-20,0]) cube([wr,Lr-Endcut+20,Hper+Lr*16/30]);
    }
};
translate([Wstup+Wtet,0,Hper+Hsgap]) rotate([atan(Hsgap/Lsgap),0,0]) cube([Wtet,Nst*sqrt(Lsgap*Lsgap+Hsgap*Hsgap),Lsgap]);
};

};
module tets(Nst=4,Startcut=0,Endcut=0) {
for(Nt=[0:1:1]) {
  intersection() {
   translate([Nt*(Wstup+Wtet),0,0]) 
      cube([Wtet,Nst*Lsgap,(Nst+1)*Hsgap+Hper+Rper*2
]);
   union() {
   translate([Nt*(Wstup+Wtet)+0.5*Wtet,0,Hper+Hsgap]) 
     rotate([-atan(Lsgap/Hsgap),0,0]) translate([0,0,Startcut]) 
       cylinder(Nst*sqrt(Lsgap*Lsgap+Hsgap*Hsgap)-Startcut-Endcut,Rper,Rper);
   translate([Nt*(Wstup+Wtet),-0.5*Lsgap,Hsgap-0.5*Hsgap]) 
     rotate([-atan(Lsgap/Hsgap),0,0]) 
       cube([Wtet,HTtet,2000]);
   }
  }
};

}

module all()
{

//    translate([Wstup+Wtet*1.5,90,Hsgap]) cylinder(Hbal,Rper,Rper);
//    translate([Wstup+Wtet,0,0]) cube([150,150,Hbal+Hsgap+Hsgap]);
      translate([Wstup+Wtet*1.5-0.5*Wbal,0,Hsgap]) {
          translate([0,18,0]) rotate([0,0,-90]) balyas();
          balyas();
          translate([90-18,0,0]) balyas();
          rotate([0,0,-90]) translate([-90,0,0]) balyas();
          
      };

translate([0,-Ly2f,hf-H2f]) cube([Lx,Ly2f,H2f]);
translate([0,0,hf+Hper+200]) rotate([0,90,0]) cylinder(Wstup-2*Wbr+Ns2*Lsgap,Rper,Rper);


stups(Ns1,0,40);
tets(Ns1,0,139);

translate([Wstup+1.5*Wtet,Ns1*Lsgap-Wbr-0.5*Wtet,(0.5+Ns1)*Hsgap+Rper-4]) union() {
  cylinder(Hper+3*Hsgap-1.5*Rper,Rper,Rper);
  translate([0,0,Hper+3*Hsgap-1.6*Rper]) sphere(Rper);
};

translate([Wstup+Wtet-2*Wbr+Lsgap*Ns2-0.5*Wtet-2*Shift,Ns1*Lsgap-Wbr-0.5*Wtet,(5.5+Ns1)*Hsgap+Ns2*Hsgap-2*Rper]) union() {
      cylinder(Hper+1.2*Rper,Rper,Rper);
      translate([0,0,Hper+1.2*Rper]) sphere(Rper);
};



translate([Wtet+Wstup-Wbr,Lsgap*Ns1-Wbr,0]) cube([Wbr,Wbr,Hbr1]);

translate([0,Lsgap*Ns1,Hsgap*(Ns1+1)-Hstup]) 
   intersection() {
     cube([Wtet+Wstup,Wstup-Wbr+Wtet,Hstup]);
     translate([Wtet+Wstup,0,0]) rotate([0,0,135]) cube([2*Wstup,2*Wstup,Hstup]);
   }
     
translate([0,Lsgap*Ns1,Hsgap*(Ns1+2)-Hstup]) 
   intersection() {
   cube([Wtet+Wstup,Wstup-Wbr+Wtet,Hstup]);
   translate([0,Wtet+Wstup-Wbr,0]) rotate([0,0,-45]) cube([2*Wstup,2*Wstup,Hstup]);
   
   }

translate([Wtet+Wstup-Wbr-Shift,(Ns1*Lsgap+Wtet+Wstup-Wbr),(Ns1+2)*Hsgap]) rotate([0,0,-90])  {
tets(Ns2,135,120);
stups(Ns2,40,40);

}

Hbr2=(Ns1+Ns2+1)*Hsgap-20;
Hbr3=(Ns1+Ns2+5)*Hsgap-Hbr2-Hstup;
translate([Wtet+Wstup-2*Wbr+Ns2*Lsgap-Shift*2,Lsgap*Ns1-Wbr,Hbr2]) cube([Wbr,Wbr,Hbr3]);



translate([Wstup+2*Wtet-2*Wbr+Ns2*Lsgap+Wstup-2*Shift,(Ns1*Lsgap),(Ns1+Ns2+4)*Hsgap]) rotate([0,0,-180])  {
tets(Ns3,136,0);
stups(Ns3,40,0);

}



translate([Lsgap*Ns2+Wstup+Wtet-Wbr-2*Shift,Lsgap*Ns1+Wstup-Wbr+Wtet,Hsgap*(Ns1+3+Ns2)-Hstup])
	
   rotate([0,0,-90]) 
   intersection() {
     cube([Wtet+Wstup,Wstup-Wbr+Wtet,Hstup]);
     translate([Wtet+Wstup,0,0]) rotate([0,0,135]) cube([2*Wstup,2*Wstup,Hstup]);
   }
     
translate([Lsgap*Ns2+Wstup+Wtet-Wbr-2*Shift,Lsgap*Ns1+Wstup-Wbr+Wtet,Hsgap*(Ns1+4+Ns2)-Hstup]) 
   rotate([0,0,-90]) 
   intersection() {
   cube([Wtet+Wstup,Wstup-Wbr+Wtet,Hstup]);
   translate([0,Wtet+Wstup-Wbr,0]) rotate([0,0,-45]) cube([2*Wstup,2*Wstup,Hstup]);
   
   }

//Xopd2=Wstup+Wtet+Ns2*Lsgap-2*Wbr+Wstup+Wtet-40-2*Shift;
//Yopd2=Lsgap*Ns1+Wtet+Wstup-Wbr-1000-80;
//Zopd2=(Ns1+Ns2+4)*Hsgap-40-150;

translate([Xopd2,
      Yopd2,
      Zopd2]) cube([40,1000,150]);
};


export(file="balcut1.dxf") projection(cut=true) rotate([0,90,0]) translate([-Wstup-Wtet*1.5,0,0]) all();

//projection(cut=true) translate([0,0,-Zopd2]) all();
//projection(cut=true) translate([0,0,Xopd2+20]) rotate([0,90,0]) all();
//projection(cut=true) rotate([90,0,0]) translate([0,-(Ns1*Lsgap+Wstup-Wbr+Wtet/2),0]) all();

//projection(cut=true) rotate([90,0,0]) translate([0,-(Ns1*Lsgap-Wbr/2-100),0]) all();

//rotate([90,0,0]) translate([0,-(Ns1*Lsgap-Wbr/2),0]) all();


//rotate([90,0,0]) translate([0,-(Ns1*Lsgap+Wstup-Wbr+Wtet/2),0]) all();