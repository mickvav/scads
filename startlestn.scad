W=60;
W1=200;
Rcyl=25;
tga=16/30;
phi=atan(1/tga);
//echo(phi);
ipr1=191;
$fn=20;
pi=3.14159;
rad=180/pi;
Asin=57;
function xfl(i) = 
    -sin((i<ipr1? i*1.5 : ipr1*1.5+(i-ipr1)/1.7))*20;
function yfl(i) = 
    100+Asin*sin(i<ipr1 ? i*1.5: ipr1*1.5+(i-ipr1)*2/(Asin/rad));

function zfl(i) = 320+ (i<ipr1 ? 4*i :
          (ipr1*4-Asin*cos(ipr1*1.5)+Asin*cos(ipr1*1.5+ (i-ipr1)*2/(Asin/rad))));
          
function xsl(i) = sin(i/2)*20;

function ysl(i) = 100-Asin*sin(i);

ipr2=325;
function zsl(i) = 320+(i<ipr2 ? i*2 : (ipr2*2+Asin*sin(i-ipr2)));

function r(i,imax) = 30*(1-i/imax) + 25*(i/imax);
imaxf=320;
imaxs=360+90-phi;
zpr=1061;
xpr=0;
ypr=0;


module all() {

for(i=[0:imaxf]){
    translate([xfl(i),
         yfl(i),
         zfl(i)]) sphere(r(i,imaxf));
};
for(i=[0:imaxs]){

    translate([xsl(i),
    ysl(i),zsl(i)]) sphere(r(i,imaxs));
    il=i;
};

function apol(t0,t1,z0,z1,dz0,dz1) =  -(-2*z1+2*z0+(dz1+dz0)*t1+(-dz1-dz0)*t0)/(-t1*t1*t1+3*t0*t1*t1-3*t0*t0*t1+t0*t0*t0);

function bpol(t0,t1,z0,z1,dz0,dz1) = (-3*t1*z1+t0*((dz1-dz0)*t1-3*z1)+(3*t1+3*t0)*z0+(dz1+2*dz0)*t1*t1+(-2*dz1-dz0)*t0*t0)/(-t1*t1*t1+3*t0*t1*t1-3*t0*t0*t1+t0*t0*t0);

function cpol(t0,t1,z0,z1,dz0,dz1) =  -(t0*((2*dz1+dz0)*t1*t1-6*t1*z1)+6*t0*t1*z0+dz0*t1*t1*t1+(-dz1-2*dz0)*t0*t0*t1-dz1*t0*t0*t0)/(-t1*t1*t1+3*t0*t1*t1-3*t0*t0*t1+t0*t0*t0);

function dpol(t0,t1,z0,z1,dz0,dz1) = (t0*t0*((dz1-dz0)*t1*t1-3*t1*z1)+t0*t0*t0*(z1-dz1*t1)+(3*t0*t1*t1-t1*t1*t1)*z0+dz0*t0*t1*t1*t1)/(-t1*t1*t1+3*t0*t1*t1-3*t0*t0*t1+t0*t0*t0);

axf=apol(0,20,xfl(imaxf)-xpr,0,xfl(imaxf)-xfl(imaxf-1),0);
bxf=bpol(0,20,xfl(imaxf)-xpr,0,xfl(imaxf)-xfl(imaxf-1),0);
cxf=cpol(0,20,xfl(imaxf)-xpr,0,xfl(imaxf)-xfl(imaxf-1),0);
dxf=dpol(0,20,xfl(imaxf)-xpr,0,xfl(imaxf)-xfl(imaxf-1),0);

ayf=apol(0,20,yfl(imaxf)-ypr,0,yfl(imaxf)-yfl(imaxf-1),-1);
byf=bpol(0,20,yfl(imaxf)-ypr,0,yfl(imaxf)-yfl(imaxf-1),-1);
cyf=cpol(0,20,yfl(imaxf)-ypr,0,yfl(imaxf)-yfl(imaxf-1),-1);
dyf=dpol(0,20,yfl(imaxf)-ypr,0,yfl(imaxf)-yfl(imaxf-1),-1);


azf=apol(0,20,zfl(imaxf)-zpr,0,zfl(imaxf)-zfl(imaxf-1),tga);
bzf=bpol(0,20,zfl(imaxf)-zpr,0,zfl(imaxf)-zfl(imaxf-1),tga);
czf=cpol(0,20,zfl(imaxf)-zpr,0,zfl(imaxf)-zfl(imaxf-1),tga);
dzf=dpol(0,20,zfl(imaxf)-zpr,0,zfl(imaxf)-zfl(imaxf-1),tga);
for(i=[0:20]){
    translate([xpr+axf*i*i*i+bxf*i*i+cxf*i+dxf,ypr+ayf*i*i*i+byf*i*i+cyf*i+dyf,zpr+azf*i*i*i+bzf*i*i+czf*i+dzf]) sphere(25);
};



axs=apol(0,20,xsl(imaxs)-xpr,0,xsl(imaxs)-xsl(imaxs-3),0);
bxs=bpol(0,20,xsl(imaxs)-xpr,0,xsl(imaxs)-xsl(imaxs-3),0);
cxs=cpol(0,20,xsl(imaxs)-xpr,0,xsl(imaxs)-xsl(imaxs-3),0);
dxs=dpol(0,20,xsl(imaxs)-xpr,0,xsl(imaxs)-xsl(imaxs-3),0);

ays=apol(0,20,ysl(imaxs)-ypr,0,ysl(imaxs)-ysl(imaxs-3),-3);
bys=bpol(0,20,ysl(imaxs)-ypr,0,ysl(imaxs)-ysl(imaxs-3),-3);
cys=cpol(0,20,ysl(imaxs)-ypr,0,ysl(imaxs)-ysl(imaxs-3),-3);
dys=dpol(0,20,ysl(imaxs)-ypr,0,ysl(imaxs)-ysl(imaxs-3),-3);


azs=apol(0,20,zsl(imaxs)-zpr,0,zsl(imaxs)-zsl(imaxs-3),3*tga);
bzs=bpol(0,20,zsl(imaxs)-zpr,0,zsl(imaxs)-zsl(imaxs-3),3*tga);
czs=cpol(0,20,zfl(imaxs)-zpr,0,zsl(imaxs)-zsl(imaxs-3),3*tga);
dzs=dpol(0,20,zsl(imaxs)-zpr,0,zsl(imaxs)-zsl(imaxs-3),3*tga);
for(i=[0:20]){
    translate([xpr+axs*i*i*i+bxs*i*i+cxs*i+dxs,ypr+ays*i*i*i+bys*i*i+cys*i+dys,zpr+azs*i*i*i+bzs*i*i+czs*i+dzs]) sphere(25);
};



for(i=[-20:0]) {
    intersection() {
        translate([xsl(i),
    ysl(i),zsl(i)]) sphere(r(i,imaxs));
        translate([xfl(i),
         yfl(i),
         zfl(i)]) sphere(r(i,imaxf));
    };
};
imins2=-30;
imaxs2=180;

for(i=[imins2:imaxs2]) {
    translate([10*sin(i),100+60*sin(i), 50+i*2]) sphere(30);
    translate([-10*sin(i),100-60*sin(i), 50+i*2]) sphere(30);
};

for(i=[imaxs2:imaxs2+30]) {
    intersection() {
         translate([10*sin(i),100+60*sin(i), 50+i*2]) sphere(30);
    translate([-10*sin(i),100-60*sin(i), 50+i*2]) sphere(30);
    };
};


//echo((zfl(imaxf)-zfl(imaxf-2))/(yfl(imaxf)-yfl(imaxf-2)));
echo(zfl(imaxf));
};

difference() {
    all();
translate([xpr,ypr,zpr]) rotate([phi,0,0]) cylinder(200,25,25);
};

//echo(tga);
//echo(il);
//$fn=40;
//rotate([phi,0,0]) cylinder(200,Rcyl,Rcyl);
/*difference(){
    translate([-W/2,-W/2,-900]) cube([W,W,1000]);
     translate([0,70,30]) rotate([phi,0,0]) rotate([0,0,-45]) cube([W,W,200]);
     translate([1,70,30]) rotate([phi,0,0]) rotate([0,0,45]) cube([W,W,200]);
     translate([2,70,30]) rotate([phi,0,0]) rotate([0,0,135]) cube([W,W,200]);
};*/
/*
Rcone1=500;
Ycone1=-(Rcone1-130);
Zcone1=Ycone1+50;
//$fn=200;
difference() {
    intersection() {
    translate([-W/2,-W1/2,-900]) cube([W,W1,1100]);
    $fn=200;
    translate([-5,Ycone1,Zcone1]) union() {
       translate([10,0,0]) rotate([0,90,0]) cylinder(Rcone1,Rcone1,0);  
       rotate([0,90,0]) cylinder(10,Rcone1,Rcone1);
       rotate([0,-90,0]) cylinder(Rcone1,Rcone1,0);  
    }
   
};
     translate([-5,Ycone1,Zcone1]) {
      union() {
       difference(){ 
           translate([-80,0,0]) rotate([0,90,0]) cylinder(Rcone1,Rcone1,0);
           translate([80,-2*Ycone1-50,0]) rotate([0,-90,0]) cylinder(Rcone1,Rcone1,0);
       };
       difference() {
          translate([80,0,0]) rotate([0,-90,0]) cylinder(Rcone1,Rcone1,0);
          translate([-80,-2*Ycone1-50,0]) rotate([0,90,0]) cylinder(Rcone1,Rcone1,0);
       };
      };  
    };
};*/