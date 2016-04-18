//満ち欠け
#version 3.7;

//sun  0.15   bkm  dia 1400    km   (x109 earth)
//moon 0.00038bkm         3.476km

#declare es = 1.3000 ;
#declare ss = 109*es;
#declare ms = ss/1400*3.476;
#declare esd = 15000 /1;
#declare emd = 38 /1;


#declare tp = 1;

camera {

	#switch (tp)
		#case (0)
			location <-esd-3, 2, -44+25*sin(2*3.1415*clock)>
			look_at <-esd+0, 0, 0>
			angle 90
		#break
		#case (1)
			location <-esd-8*cos(2*3.1415*clock),2,-8*sin(2*3.1415*clock)>
			look_at <-esd+emd*cos(2*3.1415*clock),0,emd*sin(2*3.1415*clock)>
			//rotate <23.4,0,0>
			angle 45
		#break
		#else
			#if (clock < .3)
				location <-esd+emd*(0.20-clock)*3.3*1.4142/2,2,emd*(0.20-clock)*3.3*1.4142/2>
				look_at <-esd+emd*1.4142/2,0,emd*1.4142/2>
			#else
				#if (clock < .5)
					location <-esd+emd*(0.20-.3)*3.3*1.4142/2,2,emd*(0.20-.3)*3.3*1.4142/2>
					look_at <-esd+emd*cos(2*3.1415* (0.3125-clock*.625)),0,emd*sin(2*3.1415* (0.3125-clock*.625))>
				#else
					location <-esd+emd*-.1*3.3*1.4142/2+esd*(clock-.5)*2*(1-(ss+40)*4/esd)
					,2
					,0+emd*-.1*3.3*1.4142/2*(2-2*clock)>
					look_at 0
				#end
			#end
		#end	

}


light_source{<0 , 0, 0>
   color rgb < 2 ,1.5 , 1 >
   area_light <1,0,0>,<0,0,0.5>,10,1
   adaptive 3
   jitter
	
	looks_like{
        sphere {<0,0,0> , ss
           texture {finish {ambient 1}
            	pigment{
            	color rgb <1.6 , .2 , .0>
            	/*	image_map {
						jpeg "1Sun01-thumbnail2.jpg"
						map_type 1
            		}*/
           		}
           }
        }
    } 
}
//media { absorption color rgb <.7, .1, 1> }

sphere { <0,0,0>, es
	pigment {color rgb<0.3,0.3,1>
		/*image_map {
			png "earth.png"
			map_type 1
		}*/
	}
	finish {ambient 0.1}
	translate <-esd,0,0>
}	
		

sphere {
	<0,0,0>, ms
	pigment {
	color rgb<1,.8,.2>
	/*	image_map {
			jpeg "seamless_concrete_texture.jpg"
			map_type 1
		}*/
	}
	finish {ambient 0.1}
	#switch (tp)
		#case (0)
		#case (1)
			translate <-esd+emd*cos(2*3.1415*clock),0,emd*sin(2*3.1415*clock)>
		#break
		#else
			translate <-esd+emd*1.4142/2,0,emd*1.4142/2>,ms
		#break
	#end
}
	

	
		
