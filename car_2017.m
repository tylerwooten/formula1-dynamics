%MEEN 357 phase 1 project

wheel_rear_2017
wheel_front_2017
suspension_rear_2017
suspension_front_2017
motor_2017
chassis_2017
driver_tom

field46='team';
field47='year';
field48='top_speed';
field49='t2top_speed';
field50='pilot';
field51='chassis';
field52='power_plant';
field53='suspension_front';
field54='suspension_rear';
field55='wheel_front';
field56='wheel_rear';


t60=3.0;
vtop=80;

t_top=(pi*(t60))/(acos((vtop-120)/vtop));


value46='2017 car';
value47=2017;
value48=vtop;
value49=t_top;
value50=pilot;
value51=chassis;
value52=power_plant;
value53=suspension_front;
value54=suspension_rear;
value55=wheel_front;
value56=wheel_rear;



FSAE_Race_Car= struct(field46, value46,field47, value47,field48, value48,...
                           field49, value49,field50, value50,field51, value51,...
                           field52, value52,field53, value53,field54, value54,...
                           field55, value55,field56, value56);