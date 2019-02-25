filename flights 	'/folders/myfolders/SAS Master Case Study-1/flights.csv';
filename planes		'/folders/myfolders/SAS Master Case Study-1/planes.csv';
filename weather 	'/folders/myfolders/SAS Master Case Study-1/weather.csv';
filename airlines 	'/folders/myfolders/SAS Master Case Study-1/airlines.csv';
filename airports 	'/folders/myfolders/SAS Master Case Study-1/airports.csv';

/* IMPORTING AND PREPARING FLIGHTS DATA */

DATA flights (rename = (sched_dep_time_t = Sched_Dep_Time dep_time_t = Dep_Time sched_arr_time_t = Sched_Arr_Time arr_time_t = Arr_Time) drop = sched_dep_time dep_time sched_arr_time arr_time);
	infile flights dlm = ',' dsd truncover firstobs= 2;
	input 	Date			  :mmddyy10.
			Sched_Dep_Time	$ :4.
			Dep_Time		$ :4.
			Sched_Arr_Time	$ :4.
			Arr_Time		$ :4.	
			Carrier			$ :2.
			Flight			
			Tailnum			$ :6.
			Origin			$ :3.
			Dest			$ :3.
			Distance		
			Air_Time	
			;
	
	sched_dep_time_t 	= input(sched_dep_time, hhmmss4.);
	dep_time_t 			= input(dep_time, hhmmss4.);
	sched_arr_time_t 	= input(sched_arr_time, hhmmss4.);
	arr_time_t 			= input(arr_time, hhmmss4.);
	
	format  Date 				date10. 
			sched_dep_time_t 	time5.
			dep_time_t 			time5.
			sched_arr_time_t 	time5.
			arr_time_t			time5.
			;
RUN;

/* Variables and there attributes */

PROC CONTENTS data = flights order = varnum;
	title 'FLIGHTS DATA SET AND VARIABLE ATTRIBUTES';
RUN;


/* IMPORTING AND PREPARING PLANES DATA */

DATA planes;
	infile planes dlm = ',' dsd truncover firstobs=2;
	input  	Plane				$ :6.
			Manufacturing_Year	
			Type				$ :24.		
			Manufacturer		$ :29.
			Model				$ :18.
			Engines				 
			Seats				 
			Speed				 
			Engine				$ :13.
			Fuel_CC							 
			;
			
	format fuel_cc 10.2;
RUN;

/* Variables and there attributes */

PROC CONTENTS data = planes order = varnum;
	title 'PLANES DATA SET AND VARIABLE ATTRIBUTES';
RUN;


/* IMPORTING AND PREPARING WEATHER DATA */

DATA weather (rename = (temp_n = Temp dewp_n = Dewp humid_n = Humid wind_dir_n = Wind_Dir wind_speed_n = Wind_Speed wind_gust_n = Wind_Gust pressure_n = Pressure) drop = temp dewp humid wind_dir wind_speed wind_gust pressure);
	infile weather dlm = ',' dsd truncover firstobs=2;
	input 	Origin		$ :3.
			Date		  :mmddyy10.
			Time		  :time5.
			Temp		$ :6.		
			Dewp		$ :5.
			Humid		$ :5.
			Wind_Dir	$ :3.
			Wind_Speed	$ :10.
			Wind_Gust	$ :10.
			Precip
			Pressure	$ :6.
			Visib
			;
	
	temp_n 			= input(tranwrd(temp, 'NA', ''), 6.2);
	dewp_n 			= input(tranwrd(dewp, 'NA', ''), 5.2);
	humid_n 		= input(tranwrd(humid, 'NA', ''), 5.2);
	wind_dir_n 		= input(tranwrd(wind_dir, 'NA', ''), 3.2);
	wind_speed_n 	= input(tranwrd(wind_speed, 'NA', ''), 10.2);
	wind_gust_n 	= input(tranwrd(wind_gust, 'NA', ''), 10.2);
	pressure_n 		= input(tranwrd(pressure, 'NA', ''), 6.1);
	
	format 	date date10. time time5.;
RUN;

/* Variables and there attributes */

PROC CONTENTS data = weather order = varnum;
	title 'WEATHER DATA SET AND VARIABLE ATTRIBUTES';
RUN;


* IMPORTING AND PREPARING AIRLINES DATA;

DATA airlines;
	infile airlines dlm = ',' dsd truncover firstobs=2;
	input Flight_Code $ :2. Carrier_Name $ :27.;
RUN;

/* VALUE FORMATS FOR IMPORTED DATA */

PROC FORMAT;
	value $carrier
		'9E'='Endeavor Air Inc.'
		'AA'='American Airlines Inc.'
		'AS'='Alaska Airlines Inc.'
		'B6'='JetBlue Airways'
		'DL'='Delta Air Lines Inc.'
		'EV'='ExpressJet Airlines Inc.'
		'F9'='Frontier Airlines Inc.'
		'FL'='AirTran Airways Corporation'
		'HA'='Hawaiian Airlines Inc.'
		'MQ'='Envoy Air'
		'OO'='SkyWest Airlines Inc.'
		'UA'='United Air Lines Inc.'
		'US'='US Airways Inc.'
		'VX'='Virgin America'
		'WN'='Southwest Airlines Co.'
		'YV'='Mesa Airlines Inc.'
		;
		
	value $airport
		'04G'='Lansdowne Airport'
		'06A'='Moton Field Municipal Airport'
		'06C'='Schaumburg Regional'
		'06N'='Randall Airport'
		'09J'='Jekyll Island Airport'
		'0A9'='Elizabethton Municipal Airport'
		'0G6'='Williams County Airport'
		'0G7'='Finger Lakes Regional Airport'
		'0P2'='Shoestring Aviation Airfield'
		'0S9'='Jefferson County Intl'
		'0W3'='Harford County Airport'
		'10C'='Galt Field Airport'
		'17G'='Port Bucyrus-Crawford County Airport'
		'19A'='Jackson County Airport'
		'1A3'='Martin Campbell Field Airport'
		'1B9'='Mansfield Municipal'
		'1C9'='Frazier Lake Airpark'
		'1CS'='Clow International Airport'
		'1G3'='Kent State Airport'
		'1OH'='Fortman Airport'
		'1RL'='Point Roberts Airpark'
		'24C'='Lowell City Airport'
		'24J'='Suwannee County Airport'
		'25D'='Forest Lake Airport'
		'29D'='Grove City Airport'
		'2A0'='Mark Anton Airport'
		'2G2'='Jefferson County Airpark'
		'2G9'='Somerset County Airport'
		'2J9'='Quincy Municipal Airport'
		'369'='Atmautluak Airport'
		'36U'='Heber City Municipal Airport'
		'38W'='Lynden Airport'
		'3D2'='Ephraim-Gibraltar Airport'
		'3G3'='Wadsworth Municipal'
		'3G4'='Ashland County Airport'
		'3J1'='Ridgeland Airport'
		'3W2'='Put-in-Bay Airport'
		'40J'='Perry-Foley Airport'
		'41N'='Braceville Airport'
		'47A'='Cherokee County Airport'
		'49A'='Gilmer County Airport'
		'49X'='Chemehuevi Valley'
		'4A4'='Polk County Airport - Cornelius Moore Field'
		'4A7'='Clayton County Tara Field'
		'4A9'='Isbell Field Airport'
		'4B8'='Robertson Field'
		'4G0'='Pittsburgh-Monroeville Airport'
		'4G2'='Hamburg Inc Airport'
		'4G4'='Youngstown Elser Metro Airport'
		'4I7'='Putnam County Airport'
		'4U9'='Dell Flight Strip'
		'52A'='Madison GA Municipal Airport'
		'54J'='DeFuniak Springs Airport'
		'55J'='Fernandina Beach Municipal Airport'
		'57C'='East Troy Municipal Airport'
		'60J'='Ocean Isle Beach Airport'
		'6A2'='Griffin-Spalding County Airport'
		'6K8'='Tok Junction Airport'
		'6S0'='Big Timber Airport'
		'6S2'='Florence'
		'6Y8'='Welke Airport'
		'70J'='Cairo-Grady County Airport'
		'70N'='Spring Hill Airport'
		'7A4'='Foster Field'
		'7D9'='Germack Airport'
		'7N7'='Spitfire Aerodrome'
		'8M8'='Garland Airport'
		'93C'='Richland Airport'
		'99N'='Bamberg County Airport'
		'9A1'='Covington Municipal Airport'
		'9A5'='Barwick Lafayette Airport'
		'A39'='Phoenix Regional Airport'
		'AAF'='Apalachicola Regional Airport'
		'ABE'='Lehigh Valley Intl'
		'ABI'='Abilene Rgnl'
		'ABL'='Ambler Airport'
		'ABQ'='Albuquerque International Sunport'
		'ABR'='Aberdeen Regional Airport'
		'ABY'='Southwest Georgia Regional Airport'
		'ACK'='Nantucket Mem'
		'ACT'='Waco Rgnl'
		'ACV'='Arcata'
		'ACY'='Atlantic City Intl'
		'ADK'='Adak Airport'
		'ADM'='Ardmore Muni'
		'ADQ'='Kodiak'
		'ADS'='Addison'
		'ADW'='Andrews Afb'
		'AET'='Allakaket Airport'
		'AEX'='Alexandria Intl'
		'AFE'='Kake Airport'
		'AFW'='Fort Worth Alliance Airport'
		'AGC'='Allegheny County Airport'
		'AGN'='Angoon Seaplane Base'
		'AGS'='Augusta Rgnl At Bush Fld'
		'AHN'='Athens Ben Epps Airport'
		'AIA'='Alliance Municipal Airport'
		'AIK'='Municipal Airport'
		'AIN'='Wainwright Airport'
		'AIZ'='Lee C Fine Memorial Airport'
		'AKB'='Atka Airport'
		'AKC'='Akron Fulton Intl'
		'AKI'='Akiak Airport'
		'AKK'='Akhiok Airport'
		'AKN'='King Salmon'
		'AKP'='Anaktuvuk Pass Airport'
		'ALB'='Albany Intl'
		'ALI'='Alice Intl'
		'ALM'='Alamogordo White Sands Regional Airport'
		'ALO'='Waterloo Regional Airport'
		'ALS'='San Luis Valley Regional Airport'
		'ALW'='Walla Walla Regional Airport'
		'ALX'='Alexandria'
		'ALZ'='Alitak Seaplane Base'
		'AMA'='Rick Husband Amarillo Intl'
		'ANB'='Anniston Metro'
		'ANC'='Ted Stevens Anchorage Intl'
		'AND'='Anderson Rgnl'
		'ANI'='Aniak Airport'
		'ANN'='Annette Island'
		'ANP'='Lee Airport'
		'ANQ'='Tri-State Steuben County Airport'
		'ANV'='Anvik Airport'
		'AOH'='Lima Allen County Airport'
		'AOO'='Altoona Blair Co'
		'AOS'='Amook Bay Seaplane Base'
		'APA'='Centennial'
		'APC'='Napa County Airport'
		'APF'='Naples Muni'
		'APG'='Phillips Aaf'
		'APN'='Alpena County Regional Airport'
		'AQC'='Klawock Seaplane Base'
		'ARA'='Acadiana Rgnl'
		'ARB'='Ann Arbor Municipal Airport'
		'ARC'='Arctic Village Airport'
		'ART'='Watertown Intl'
		'ARV'='Lakeland'
		'ASE'='Aspen Pitkin County Sardy Field'
		'ASH'='Boire Field Airport'
		'AST'='Astoria Regional Airport'
		'ATK'='Atqasuk Edward Burnell Sr Memorial Airport'
		'ATL'='Hartsfield Jackson Atlanta Intl'
		'ATT'='Camp Mabry Austin City'
		'ATW'='Appleton'
		'ATY'='Watertown Regional Airport'
		'AUG'='Augusta State'
		'AUK'='Alakanuk Airport'
		'AUS'='Austin Bergstrom Intl'
		'AUW'='Wausau Downtown Airport'
		'AVL'='Asheville Regional Airport'
		'AVO'='Executive'
		'AVP'='Wilkes Barre Scranton Intl'
		'AVW'='Marana Regional'
		'AVX'='Avalon'
		'AZA'='Phoenix-Mesa Gateway'
		'AZO'='Kalamazoo'
		'BAB'='Beale Afb'
		'BAD'='Barksdale Afb'
		'BAF'='Barnes Municipal'
		'BBX'='Wings Field'
		'BCE'='Bryce Canyon'
		'BCT'='Boca Raton'
		'BDE'='Baudette Intl'
		'BDL'='Bradley Intl'
		'BDR'='Igor I Sikorsky Mem'
		'BEC'='Beech Factory Airport'
		'BED'='Laurence G Hanscom Fld'
		'BEH'='Southwest Michigan Regional Airport'
		'BET'='Bethel'
		'BFD'='Bradford Regional Airport'
		'BFF'='Western Nebraska Regional Airport'
		'BFI'='Boeing Fld King Co Intl'
		'BFL'='Meadows Fld'
		'BFM'='Mobile Downtown'
		'BFP'='Beaver Falls'
		'BFT'='Beaufort'
		'BGE'='Decatur County Industrial Air Park'
		'BGM'='Greater Binghamton Edwin A Link Fld'
		'BGR'='Bangor Intl'
		'BHB'='Hancock County - Bar Harbor'
		'BHM'='Birmingham Intl'
		'BID'='Block Island State Airport'
		'BIF'='Biggs Aaf'
		'BIG'='Allen Aaf'
		'BIL'='Billings Logan International Airport'
		'BIS'='Bismarck Municipal Airport'
		'BIV'='Tulip City Airport'
		'BIX'='Keesler Afb'
		'BJC'='Rocky Mountain Metropolitan Airport'
		'BJI'='Bemidji Regional Airport'
		'BKC'='Buckland Airport'
		'BKD'='Stephens Co'
		'BKF'='Buckley Afb'
		'BKG'='Branson LLC'
		'BKH'='Barking Sands Pmrf'
		'BKL'='Burke Lakefront Airport'
		'BKW'='Raleigh County Memorial Airport'
		'BKX'='Brookings Regional Airport'
		'BLD'='Boulder City Municipal Airport'
		'BLF'='Mercer County Airport'
		'BLH'='Blythe Airport'
		'BLI'='Bellingham Intl'
		'BLV'='Scott Afb Midamerica'
		'BMC'='Brigham City'
		'BMG'='Monroe County Airport'
		'BMI'='Central Illinois Rgnl'
		'BMX'='Big Mountain Afs'
		'BNA'='Nashville Intl'
		'BOI'='Boise Air Terminal'
		'BOS'='General Edward Lawrence Logan Intl'
		'BOW'='Bartow Municipal Airport'
		'BPT'='Southeast Texas Rgnl'
		'BQK'='Brunswick Golden Isles Airport'
		'BRD'='Brainerd Lakes Rgnl'
		'BRL'='Southeast Iowa Regional Airport'
		'BRO'='Brownsville South Padre Island Intl'
		'BRW'='Wiley Post Will Rogers Mem'
		'BSF'='Bradshaw Aaf'
		'BTI'='Barter Island Lrrs'
		'BTM'='Bert Mooney Airport'
		'BTR'='Baton Rouge Metro Ryan Fld'
		'BTT'='Bettles'
		'BTV'='Burlington Intl'
		'BUF'='Buffalo Niagara Intl'
		'BUR'='Bob Hope'
		'BUU'='Municipal Airport'
		'BUY'='Burlington-Alamance Regional Airport'
		'BVY'='Beverly Municipal Airport'
		'BWD'='KBWD'
		'BWG'='Bowling Green-Warren County Regional Airport'
		'BWI'='Baltimore Washington Intl'
		'BXK'='Buckeye Municipal Airport'
		'BXS'='Borrego Valley Airport'
		'BYH'='Arkansas Intl'
		'BYS'='Bicycle Lake Aaf'
		'BYW'='Blakely Island Airport'
		'BZN'='Gallatin Field'
		'C02'='Grand Geneva Resort Airport'
		'C16'='Frasca Field'
		'C47'='Portage Municipal Airport'
		'C65'='Plymouth Municipal Airport'
		'C89'='Sylvania Airport'
		'C91'='Dowagiac Municipal Airport'
		'CAE'='Columbia Metropolitan'
		'CAK'='Akron Canton Regional Airport'
		'CAR'='Caribou Muni'
		'CBE'='Greater Cumberland Rgnl.'
		'CBM'='Columbus Afb'
		'CCO'='Coweta County Airport'
		'CCR'='Buchanan Field Airport'
		'CDB'='Cold Bay'
		'CDC'='Cedar City Rgnl'
		'CDI'='Cambridge Municipal Airport'
		'CDK'='CedarKey'
		'CDN'='Woodward Field'
		'CDR'='Chadron Municipal Airport'
		'CDS'='Childress Muni'
		'CDV'='Merle K Mudhole Smith'
		'CDW'='Caldwell Essex County Airport'
		'CEC'='Del Norte County Airport'
		'CEF'='Westover Arb Metropolitan'
		'CEM'='Central Airport'
		'CEU'='Clemson'
		'CEW'='Bob Sikes'
		'CEZ'='Cortez Muni'
		'CFD'='Coulter Fld'
		'CGA'='Craig Seaplane Base'
		'CGF'='Cuyahoga County'
		'CGI'='Cape Girardeau Regional Airport'
		'CGX'='Meigs Field'
		'CGZ'='Casa Grande Municipal Airport'
		'CHA'='Lovell Fld'
		'CHI'='All Airports'
		'CHO'='Charlottesville-Albemarle'
		'CHS'='Charleston Afb Intl'
		'CHU'='Chuathbaluk Airport'
		'CIC'='Chico Muni'
		'CID'='Cedar Rapids'
		'CIK'='Chalkyitsik Airport'
		'CIL'='Council Airport'
		'CIU'='Chippewa County International Airport'
		'CKB'='Harrison Marion Regional Airport'
		'CKD'='Crooked Creek Airport'
		'CKF'='Crisp County Cordele Airport'
		'CKV'='Clarksville-Montgomery County Regional Airport'
		'CLC'='Clear Lake Metroport'
		'CLD'='McClellan-Palomar Airport'
		'CLE'='Cleveland Hopkins Intl'
		'CLL'='Easterwood Fld'
		'CLM'='William R Fairchild International Airport'
		'CLT'='Charlotte Douglas Intl'
		'CLW'='Clearwater Air Park'
		'CMH'='Port Columbus Intl'
		'CMI'='Champaign'
		'CMX'='Houghton County Memorial Airport'
		'CNM'='Cavern City Air Terminal'
		'CNW'='Tstc Waco'
		'CNY'='Canyonlands Field'
		'COD'='Yellowstone Rgnl'
		'COF'='Patrick Afb'
		'CON'='Concord Municipal'
		'COS'='City Of Colorado Springs Muni'
		'COT'='Cotulla Lasalle Co'
		'COU'='Columbia Rgnl'
		'CPR'='Natrona Co Intl'
		'CPS'='St. Louis Downtown Airport'
		'CRE'='Grand Strand Airport'
		'CRP'='Corpus Christi Intl'
		'CRW'='Yeager'
		'CSG'='Columbus Metropolitan Airport'
		'CTB'='Cut Bank Muni'
		'CTH'='Chester County G O Carlson Airport'
		'CTJ'='West Georgia Regional Airport - O V Gray Field'
		'CTY'='Cross City'
		'CVG'='Cincinnati Northern Kentucky Intl'
		'CVN'='Clovis Muni'
		'CVS'='Cannon Afb'
		'CVX'='Charlevoix Municipal Airport'
		'CWA'='Central Wisconsin'
		'CWI'='Clinton Municipal'
		'CXF'='Coldfoot Airport'
		'CXL'='Calexico Intl'
		'CXO'='Lone Star Executive'
		'CXY'='Capital City Airport'
		'CYF'='Chefornak Airport'
		'CYM'='Chatham Seaplane Base'
		'CYS'='Cheyenne Rgnl Jerry Olson Fld'
		'CYT'='Yakataga Airport'
		'CZF'='Cape Romanzof Lrrs'
		'CZN'='Chisana Airport'
		'DAB'='Daytona Beach Intl'
		'DAL'='Dallas Love Fld'
		'DAY'='James M Cox Dayton Intl'
		'DBQ'='Dubuque Rgnl'
		'DCA'='Ronald Reagan Washington Natl'
		'DDC'='Dodge City Regional Airport'
		'DEC'='Decatur'
		'DEN'='Denver Intl'
		'DET'='Coleman A Young Muni'
		'DFW'='Dallas Fort Worth Intl'
		'DGL'='Douglas Municipal Airport'
		'DHN'='Dothan Rgnl'
		'DHT'='Dalhart Muni'
		'DIK'='Dickinson Theodore Roosevelt Regional Airport'
		'DKB'='De Kalb Taylor Municipal Airport'
		'DKK'='Chautauqua County-Dunkirk Airport'
		'DKX'='Knoxville Downtown Island Airport'
		'DLF'='Laughlin Afb'
		'DLG'='Dillingham'
		'DLH'='Duluth Intl'
		'DLL'='Baraboo Wisconsin Dells Airport'
		'DMA'='Davis Monthan Afb'
		'DNL'='Daniel Field Airport'
		'DNN'='Dalton Municipal Airport'
		'DOV'='Dover Afb'
		'DPA'='Dupage'
		'DQH'='Douglas Municipal Airport'
		'DRG'='Deering Airport'
		'DRI'='Beauregard Rgnl'
		'DRM'='Drummond Island Airport'
		'DRO'='Durango La Plata Co'
		'DRT'='Del Rio Intl'
		'DSM'='Des Moines Intl'
		'DTA'='Delta Municipal Airport'
		'DTS'='Destin'
		'DTW'='Detroit Metro Wayne Co'
		'DUC'='Halliburton Field Airport'
		'DUG'='Bisbee Douglas Intl'
		'DUJ'='DuBois Regional Airport'
		'DUT'='Unalaska'
		'DVL'='Devils Lake Regional Airport'
		'DVT'='Deer Valley Municipal Airport'
		'DWA'='Yolo County Airport'
		'DWH'='David Wayne Hooks Field'
		'DWS'='Orlando'
		'DXR'='Danbury Municipal Airport'
		'DYS'='Dyess Afb'
		'E25'='Wickenburg Municipal Airport'
		'E51'='Bagdad Airport'
		'E55'='Ocean Ridge Airport'
		'E63'='Gila Bend Municipal Airport'
		'E91'='Chinle Municipal Airport'
		'EAA'='Eagle Airport'
		'EAR'='Kearney Municipal Airport'
		'EAT'='Pangborn Field'
		'EAU'='Chippewa Valley Regional Airport'
		'ECA'='Iosco County'
		'ECG'='Elizabeth City Cgas Rgnl'
		'ECP'='Panama City-NW Florida Bea.'
		'EDF'='Elmendorf Afb'
		'EDW'='Edwards Afb'
		'EEK'='Eek Airport'
		'EEN'='Dillant Hopkins Airport'
		'EET'='Shelby County Airport'
		'EFD'='Ellington Fld'
		'EGA'='Eagle County Airport'
		'EGE'='Eagle Co Rgnl'
		'EGT'='Wellington Municipal'
		'EGV'='Eagle River'
		'EGX'='Egegik Airport'
		'EHM'='Cape Newenham Lrrs'
		'EIL'='Eielson Afb'
		'EKI'='Elkhart Municipal'
		'EKN'='Elkins Randolph Co Jennings Randolph'
		'EKO'='Elko Regional Airport'
		'ELD'='South Arkansas Rgnl At Goodwin Fld'
		'ELI'='Elim Airport'
		'ELM'='Elmira Corning Rgnl'
		'ELP'='El Paso Intl'
		'ELV'='Elfin Cove Seaplane Base'
		'ELY'='Ely Airport'
		'EMK'='Emmonak Airport'
		'EMP'='Emporia Municipal Airport'
		'ENA'='Kenai Muni'
		'END'='Vance Afb'
		'ENV'='Wendover'
		'ENW'='Kenosha Regional Airport'
		'EOK'='Keokuk Municipal Airport'
		'EPM'='Eastport Municipal Airport'
		'EQY'='Monroe Reqional Airport'
		'ERI'='Erie Intl Tom Ridge Fld'
		'ERV'='Kerrville Municipal Airport'
		'ERY'='Luce County Airport'
		'ESC'='Delta County Airport'
		'ESD'='Orcas Island Airport'
		'ESF'='Esler Rgnl'
		'ESN'='Easton-Newnam Field Airport'
		'EUG'='Mahlon Sweet Fld'
		'EVV'='Evansville Regional'
		'EWB'='New Bedford Regional Airport'
		'EWN'='Craven Co Rgnl'
		'EWR'='Newark Liberty Intl'
		'EXI'='Excursion Inlet Seaplane Base'
		'EYW'='Key West Intl'
		'F57'='Seaplane Base'
		'FAF'='Felker Aaf'
		'FAI'='Fairbanks Intl'
		'FAR'='Hector International Airport'
		'FAT'='Fresno Yosemite Intl'
		'FAY'='Fayetteville Regional Grannis Field'
		'FBG'='Fredericksburg Amtrak Station'
		'FBK'='Ladd Aaf'
		'FBS'='Friday Harbor Seaplane Base'
		'FCA'='Glacier Park Intl'
		'FCS'='Butts Aaf'
		'FDY'='Findlay Airport'
		'FFA'='First Flight Airport'
		'FFC'='Atlanta Regional Airport - Falcon Field'
		'FFO'='Wright Patterson Afb'
		'FFT'='Capital City Airport'
		'FFZ'='Mesa Falcon Field'
		'FHU'='Sierra Vista Muni Libby Aaf'
		'FIT'='Fitchburg Municipal Airport'
		'FKL'='Franklin'
		'FLD'='Fond Du Lac County Airport'
		'FLG'='Flagstaff Pulliam Airport'
		'FLL'='Fort Lauderdale Hollywood Intl'
		'FLO'='Florence Rgnl'
		'FLV'='Sherman Aaf'
		'FME'='Tipton'
		'FMH'='Otis Angb'
		'FMN'='Four Corners Rgnl'
		'FMY'='Page Fld'
		'FNL'='Fort Collins Loveland Muni'
		'FNR'='Funter Bay Seaplane Base'
		'FNT'='Bishop International'
		'FOD'='Fort Dodge Rgnl'
		'FOE'='Forbes Fld'
		'FOK'='Francis S Gabreski'
		'FRD'='Friday Harbor Airport'
		'FRI'='Marshall Aaf'
		'FRN'='Bryant Ahp'
		'FRP'='St Lucie County International Airport'
		'FSD'='Sioux Falls'
		'FSI'='Henry Post Aaf'
		'FSM'='Fort Smith Rgnl'
		'FST'='Fort Stockton Pecos Co'
		'FTK'='Godman Aaf'
		'FTW'='Fort Worth Meacham Intl'
		'FTY'='Fulton County Airport Brown Field'
		'FUL'='Fullerton Municipal Airport'
		'FWA'='Fort Wayne'
		'FXE'='Fort Lauderdale Executive'
		'FYU'='Fort Yukon'
		'FYV'='Drake Fld'
		'FZG'='Fitzgerald Municipal Airport'
		'GAD'='Northeast Alabama Regional Airport'
		'GAI'='Montgomery County Airpark'
		'GAL'='Edward G Pitka Sr'
		'GAM'='Gambell Airport'
		'GBN'='Great Bend Municipal'
		'GCC'='Gillette-Campbell County Airport'
		'GCK'='Garden City Rgnl'
		'GCN'='Grand Canyon National Park Airport'
		'GCW'='Grand Canyon West Airport'
		'GDV'='Dawson Community Airport'
		'GDW'='Gladwin Zettel Memorial Airport'
		'GED'='Sussex Co'
		'GEG'='Spokane Intl'
		'GEU'='Glendale Municipal Airport'
		'GFK'='Grand Forks Intl'
		'GGE'='Georgetown County Airport'
		'GGG'='East Texas Rgnl'
		'GGW'='Wokal Field Glasgow International Airport'
		'GHG'='Marshfield Municipal Airport'
		'GIF'='Gilbert Airport'
		'GJT'='Grand Junction Regional'
		'GKN'='Gulkana'
		'GKY'='Arlington Municipal'
		'GLD'='Renner Fld'
		'GLH'='Mid Delta Regional Airport'
		'GLS'='Scholes Intl At Galveston'
		'GLV'='Golovin Airport'
		'GNT'='Grants Milan Muni'
		'GNU'='Goodnews Airport'
		'GNV'='Gainesville Rgnl'
		'GON'='Groton New London'
		'GPT'='Gulfport-Biloxi'
		'GPZ'='Grand Rapids Itasca County'
		'GQQ'='Galion Municipal Airport'
		'GRB'='Austin Straubel Intl'
		'GRF'='Gray Aaf'
		'GRI'='Central Nebraska Regional Airport'
		'GRK'='Robert Gray Aaf'
		'GRM'='Grand Marais Cook County Airport'
		'GRR'='Gerald R Ford Intl'
		'GSB'='Seymour Johnson Afb'
		'GSO'='Piedmont Triad'
		'GSP'='Greenville-Spartanburg International'
		'GST'='Gustavus Airport'
		'GTB'='Wheeler Sack Aaf'
		'GTF'='Great Falls Intl'
		'GTR'='Golden Triangle Regional Airport'
		'GTU'='Georgetown Municipal Airport'
		'GUC'='Gunnison - Crested Butte'
		'GUP'='Gallup Muni'
		'GUS'='Grissom Arb'
		'GVL'='Lee Gilmer Memorial Airport'
		'GVQ'='Genesee County Airport'
		'GVT'='Majors'
		'GWO'='Greenwood Leflore'
		'GYY'='Gary Chicago International Airport'
		'HBG'='Hattiesburg Bobby L. Chain Municipal Airport'
		'HBR'='Hobart Muni'
		'HCC'='Columbia County'
		'HCR'='Holy Cross Airport'
		'HDH'='Dillingham'
		'HDI'='Hardwick Field Airport'
		'HDN'='Yampa Valley'
		'HDO'='Hondo Municipal Airport'
		'HFD'='Hartford Brainard'
		'HGR'='Hagerstown Regional Richard A Henson Field'
		'HHH'='Hilton Head'
		'HHI'='Wheeler Aaf'
		'HHR'='Jack Northrop Fld Hawthorne Muni'
		'HIB'='Chisholm Hibbing'
		'HIF'='Hill Afb'
		'HII'='Lake Havasu City Airport'
		'HIO'='Portland Hillsboro'
		'HKB'='Healy River Airport'
		'HKY'='Hickory Rgnl'
		'HLG'='Wheeling Ohio County Airport'
		'HLN'='Helena Rgnl'
		'HLR'='Hood Aaf'
		'HMN'='Holloman Afb'
		'HNH'='Hoonah Airport'
		'HNL'='Honolulu Intl'
		'HNM'='Hana'
		'HNS'='Haines Airport'
		'HOB'='Lea Co Rgnl'
		'HOM'='Homer'
		'HON'='Huron Rgnl'
		'HOP'='Campbell Aaf'
		'HOT'='Memorial Field'
		'HOU'='William P Hobby'
		'HPB'='Hooper Bay Airport'
		'HPN'='Westchester Co'
		'HQM'='Bowerman Field'
		'HQU'='McDuffie County Airport'
		'HRL'='Valley Intl'
		'HRO'='Boone Co'
		'HRT'='Hurlburt Fld'
		'HSH'='Henderson Executive Airport'
		'HSL'='Huslia Airport'
		'HST'='Homestead Arb'
		'HSV'='Huntsville International Airport-Carl T Jones Field'
		'HTL'='Roscommon Co'
		'HTS'='Tri State Milton J Ferguson Field'
		'HUA'='Redstone Aaf'
		'HUF'='Terre Haute Intl Hulman Fld'
		'HUL'='Houlton Intl'
		'HUS'='Hughes Airport'
		'HUT'='Hutchinson Municipal Airport'
		'HVN'='Tweed-New Haven Airport'
		'HVR'='Havre City Co'
		'HWD'='Hayward Executive Airport'
		'HWO'='North Perry'
		'HXD'='Hilton Head Airport'
		'HYA'='Barnstable Muni Boardman Polando Fld'
		'HYG'='Hydaburg Seaplane Base'
		'HYL'='Hollis Seaplane Base'
		'HYS'='Hays Regional Airport'
		'HZL'='Hazleton Municipal'
		'IAB'='Mc Connell Afb'
		'IAD'='Washington Dulles Intl'
		'IAG'='Niagara Falls Intl'
		'IAH'='George Bush Intercontinental'
		'IAN'='Bob Baker Memorial Airport'
		'ICT'='Wichita Mid Continent'
		'ICY'='Icy Bay Airport'
		'IDA'='Idaho Falls Rgnl'
		'IDL'='Idlewild Intl'
		'IFP'='Laughlin-Bullhead Intl'
		'IGG'='Igiugig Airport'
		'IGM'='Kingman Airport'
		'IGQ'='Lansing Municipal'
		'IJD'='Windham Airport'
		'IKK'='Greater Kankakee'
		'IKO'='Nikolski Air Station'
		'IKR'='Kirtland Air Force Base'
		'IKV'='Ankeny Regl Airport'
		'ILG'='New Castle'
		'ILI'='Iliamna'
		'ILM'='Wilmington Intl'
		'ILN'='Wilmington Airborne Airpark'
		'IMM'='Immokalee'
		'IMT'='Ford Airport'
		'IND'='Indianapolis Intl'
		'INJ'='Hillsboro Muni'
		'INK'='Winkler Co'
		'INL'='Falls Intl'
		'INS'='Creech Afb'
		'INT'='Smith Reynolds'
		'INW'='Winslow-Lindbergh Regional Airport'
		'IOW'='Iowa City Municipal Airport'
		'IPL'='Imperial Co'
		'IPT'='Williamsport Rgnl'
		'IRC'='Circle City Airport'
		'IRK'='Kirksville Regional Airport'
		'ISM'='Kissimmee Gateway Airport'
		'ISN'='Sloulin Fld Intl'
		'ISO'='Kinston Regional Jetport'
		'ISP'='Long Island Mac Arthur'
		'ISW'='Alexander Field South Wood County Airport'
		'ITH'='Ithaca Tompkins Rgnl'
		'ITO'='Hilo Intl'
		'IWD'='Gogebic Iron County Airport'
		'IWS'='West Houston'
		'IYK'='Inyokern Airport'
		'JAC'='Jackson Hole Airport'
		'JAN'='Jackson Evers Intl'
		'JAX'='Jacksonville Intl'
		'JBR'='Jonesboro Muni'
		'JCI'='New Century AirCenter Airport'
		'JEF'='Jefferson City Memorial Airport'
		'JES'='Jesup-Wayne County Airport'
		'JFK'='John F Kennedy Intl'
		'JGC'='Grand Canyon Heliport'
		'JHM'='Kapalua'
		'JHW'='Chautauqua County-Jamestown'
		'JKA'='Jack Edwards Airport'
		'JLN'='Joplin Rgnl'
		'JMS'='Jamestown Regional Airport'
		'JNU'='Juneau Intl'
		'JOT'='Regional Airport'
		'JRA'='West 30th St. Heliport'
		'JRB'='Wall Street Heliport'
		'JST'='John Murtha Johnstown-Cambria County Airport'
		'JVL'='Southern Wisconsin Regional Airport'
		'JXN'='Reynolds Field'
		'JYL'='Plantation Airpark'
		'JYO'='Leesburg Executive Airport'
		'JZP'='Pickens County Airport'
		'K03'='Wainwright As'
		'KAE'='Kake Seaplane Base'
		'KAL'='Kaltag Airport'
		'KBC'='Birch Creek Airport'
		'KBW'='Chignik Bay Seaplane Base'
		'KCC'='Coffman Cove Seaplane Base'
		'KCL'='Chignik Lagoon Airport'
		'KCQ'='Chignik Lake Airport'
		'KEH'='Kenmore Air Harbor Inc Seaplane Base'
		'KEK'='Ekwok Airport'
		'KFP'='False Pass Airport'
		'KGK'='Koliganek Airport'
		'KGX'='Grayling Airport'
		'KKA'='Koyuk Alfred Adams Airport'
		'KKB'='Kitoi Bay Seaplane Base'
		'KKH'='Kongiganak Airport'
		'KLG'='Kalskag Airport'
		'KLL'='Levelock Airport'
		'KLN'='Larsen Bay Airport'
		'KLS'='Kelso Longview'
		'KLW'='Klawock Airport'
		'KMO'='Manokotak Airport'
		'KMY'='Moser Bay Seaplane Base'
		'KNW'='New Stuyahok Airport'
		'KOA'='Kona Intl At Keahole'
		'KOT'='Kotlik Airport'
		'KOY'='Olga Bay Seaplane Base'
		'KOZ'='Ouzinkie Airport'
		'KPB'='Point Baker Seaplane Base'
		'KPC'='Port Clarence Coast Guard Station'
		'KPN'='Kipnuk Airport'
		'KPR'='Port Williams Seaplane Base'
		'KPV'='Perryville Airport'
		'KPY'='Port Bailey Seaplane Base'
		'KQA'='Akutan Seaplane Base'
		'KSM'='St Marys Airport'
		'KTB'='Thorne Bay Seaplane Base'
		'KTN'='Ketchikan Intl'
		'KTS'='Brevig Mission Airport'
		'KUK'='Kasigluk Airport'
		'KVC'='King Cove Airport'
		'KVL'='Kivalina Airport'
		'KWK'='Kwigillingok Airport'
		'KWN'='Quinhagak Airport'
		'KWP'='West Point Village Seaplane Base'
		'KWT'='Kwethluk Airport'
		'KYK'='Karuluk Airport'
		'KYU'='Koyukuk Airport'
		'KZB'='Zachar Bay Seaplane Base'
		'L06'='Furnace Creek'
		'L35'='Big Bear City'
		'LAA'='Lamar Muni'
		'LAF'='Purude University Airport'
		'LAL'='Lakeland Linder Regional Airport'
		'LAM'='Los Alamos Airport'
		'LAN'='Capital City'
		'LAR'='Laramie Regional Airport'
		'LAS'='Mc Carran Intl'
		'LAW'='Lawton-Fort Sill Regional Airport'
		'LAX'='Los Angeles Intl'
		'LBB'='Lubbock Preston Smith Intl'
		'LBE'='Arnold Palmer Regional Airport'
		'LBF'='North Platte Regional Airport Lee Bird Field'
		'LBL'='Liberal Muni'
		'LBT'='Municipal Airport'
		'LCH'='Lake Charles Rgnl'
		'LCK'='Rickenbacker Intl'
		'LCQ'='Lake City Municipal Airport'
		'LDJ'='Linden Airport'
		'LEB'='Lebanon Municipal Airport'
		'LEW'='Lewiston Maine'
		'LEX'='Blue Grass'
		'LFI'='Langley Afb'
		'LFK'='Angelina Co'
		'LFT'='Lafayette Rgnl'
		'LGA'='La Guardia'
		'LGB'='Long Beach'
		'LGC'='LaGrange-Callaway Airport'
		'LGU'='Logan-Cache'
		'LHD'='Lake Hood Seaplane Base'
		'LHV'='William T. Piper Mem.'
		'LHX'='La Junta Muni'
		'LIH'='Lihue'
		'LIT'='Adams Fld'
		'LIV'='Livingood Airport'
		'LKE'='Kenmore Air Harbor Seaplane Base'
		'LKP'='Lake Placid Airport'
		'LMT'='Klamath Falls Airport'
		'LNA'='Palm Beach Co Park'
		'LNK'='Lincoln'
		'LNN'='Lost Nation Municipal Airport'
		'LNR'='Tri-County Regional Airport'
		'LNS'='Lancaster Airport'
		'LNY'='Lanai'
		'LOT'='Lewis University Airport'
		'LOU'='Bowman Fld'
		'LOZ'='London-Corbin Airport-MaGee Field'
		'LPC'='Lompoc Airport'
		'LPR'='Lorain County Regional Airport'
		'LPS'='Lopez Island Airport'
		'LRD'='Laredo Intl'
		'LRF'='Little Rock Afb'
		'LRU'='Las Cruces Intl'
		'LSE'='La Crosse Municipal'
		'LSF'='Lawson Aaf'
		'LSV'='Nellis Afb'
		'LTS'='Altus Afb'
		'LUF'='Luke Afb'
		'LUK'='Cincinnati Muni Lunken Fld'
		'LUP'='Kalaupapa Airport'
		'LUR'='Cape Lisburne Lrrs'
		'LVK'='Livermore Municipal'
		'LVM'='Mission Field Airport'
		'LVS'='Las Vegas Muni'
		'LWA'='South Haven Area Regional Airport'
		'LWB'='Greenbrier Valley Airport'
		'LWC'='Lawrence Municipal'
		'LWM'='Lawrence Municipal Airport'
		'LWS'='Lewiston Nez Perce Co'
		'LWT'='Lewistown Municipal Airport'
		'LXY'='Mexia - Limestone County Airport'
		'LYH'='Lynchburg Regional Preston Glenn Field'
		'LYU'='Ely Municipal'
		'LZU'='Gwinnett County Airport-Briscoe Field'
		'MAE'='Madera Municipal Airport'
		'MAF'='Midland Intl'
		'MBL'='Manistee County-Blacker Airport'
		'MBS'='Mbs Intl'
		'MCC'='Mc Clellan Afld'
		'MCD'='Mackinac Island Airport'
		'MCE'='Merced Municipal Airport'
		'MCF'='Macdill Afb'
		'MCG'='McGrath Airport'
		'MCI'='Kansas City Intl'
		'MCK'='McCook Regional Airport'
		'MCL'='McKinley National Park Airport'
		'MCN'='Middle Georgia Rgnl'
		'MCO'='Orlando Intl'
		'MCW'='Mason City Municipal'
		'MDT'='Harrisburg Intl'
		'MDW'='Chicago Midway Intl'
		'ME5'='Banks Airport'
		'MEI'='Key Field'
		'MEM'='Memphis Intl'
		'MER'='Castle'
		'MFD'='Mansfield Lahm Regional'
		'MFE'='Mc Allen Miller Intl'
		'MFI'='Marshfield Municipal Airport'
		'MFR'='Rogue Valley Intl Medford'
		'MGC'='Michigan City Municipal Airport'
		'MGE'='Dobbins Arb'
		'MGJ'='Orange County Airport'
		'MGM'='Montgomery Regional Airport'
		'MGR'='Moultrie Municipal Airport'
		'MGW'='Morgantown Muni Walter L Bill Hart Fld'
		'MGY'='Dayton-Wright Brothers Airport'
		'MHK'='Manhattan Reigonal'
		'MHM'='Minchumina Airport'
		'MHR'='Sacramento Mather'
		'MHT'='Manchester Regional Airport'
		'MHV'='Mojave'
		'MIA'='Miami Intl'
		'MIB'='Minot Afb'
		'MIE'='Delaware County Airport'
		'MIV'='Millville Muni'
		'MKC'='Downtown'
		'MKE'='General Mitchell Intl'
		'MKG'='Muskegon County Airport'
		'MKK'='Molokai'
		'MKL'='Mc Kellar Sipes Rgnl'
		'MKO'='Davis Fld'
		'MLB'='Melbourne Intl'
		'MLC'='Mc Alester Rgnl'
		'MLD'='Malad City'
		'MLI'='Quad City Intl'
		'MLJ'='Baldwin County Airport'
		'MLL'='Marshall Don Hunter Sr. Airport'
		'MLS'='Frank Wiley Field'
		'MLT'='Millinocket Muni'
		'MLU'='Monroe Rgnl'
		'MLY'='Manley Hot Springs Airport'
		'MMH'='Mammoth Yosemite Airport'
		'MMI'='McMinn Co'
		'MMU'='Morristown Municipal Airport'
		'MMV'='Mc Minnville Muni'
		'MNM'='Menominee Marinette Twin Co'
		'MNT'='Minto Airport'
		'MOB'='Mobile Rgnl'
		'MOD'='Modesto City Co Harry Sham'
		'MOT'='Minot Intl'
		'MOU'='Mountain Village Airport'
		'MPB'='Miami Seaplane Base'
		'MPI'='MariposaYosemite'
		'MPV'='Edward F Knapp State'
		'MQB'='Macomb Municipal Airport'
		'MQT'='Sawyer International Airport'
		'MRB'='Eastern WV Regional Airport'
		'MRI'='Merrill Fld'
		'MRK'='Marco Islands'
		'MRN'='Foothills Regional Airport'
		'MRY'='Monterey Peninsula'
		'MSL'='Northwest Alabama Regional Airport'
		'MSN'='Dane Co Rgnl Truax Fld'
		'MSO'='Missoula Intl'
		'MSP'='Minneapolis St Paul Intl'
		'MSS'='Massena Intl Richards Fld'
		'MSY'='Louis Armstrong New Orleans Intl'
		'MTC'='Selfridge Angb'
		'MTH'='Florida Keys Marathon Airport'
		'MTJ'='Montrose Regional Airport'
		'MTM'='Metlakatla Seaplane Base'
		'MUE'='Waimea Kohala'
		'MUI'='Muir Aaf'
		'MUO'='Mountain Home Afb'
		'MVL'='Morrisville Stowe State Airport'
		'MVY'="Martha\\'s Vineyard"
		'MWA'='Williamson Country Regional Airport'
		'MWC'='Lawrence J Timmerman Airport'
		'MWH'='Grant Co Intl'
		'MWL'='Mineral Wells'
		'MWM'='Windom Municipal Airport'
		'MXF'='Maxwell Afb'
		'MXY'='McCarthy Airport'
		'MYF'='Montgomery Field'
		'MYL'='McCall Municipal Airport'
		'MYR'='Myrtle Beach Intl'
		'MYU'='Mekoryuk Airport'
		'MYV'='Yuba County Airport'
		'MZJ'='Pinal Airpark'
		'N53'='Stroudsburg-Pocono Airport'
		'N69'='Stormville Airport'
		'N87'='Trenton-Robbinsville Airport'
		'NBG'='New Orleans Nas Jrb'
		'NBU'='Naval Air Station'
		'NCN'='Chenega Bay Airport'
		'NEL'='Lakehurst Naes'
		'NFL'='Fallon Nas'
		'NGF'='Kaneohe Bay Mcaf'
		'NGP'='Corpus Christi NAS'
		'NGU'='Norfolk Ns'
		'NGZ'='NAS Alameda'
		'NHK'='Patuxent River Nas'
		'NIB'='Nikolai Airport'
		'NID'='China Lake Naws'
		'NIP'='Jacksonville Nas'
		'NJK'='El Centro Naf'
		'NKT'='Cherry Point Mcas'
		'NKX'='Miramar Mcas'
		'NLC'='Lemoore Nas'
		'NLG'='Nelson Lagoon'
		'NME'='Nightmute Airport'
		'NMM'='Meridian Nas'
		'NNL'='Nondalton Airport'
		'NOW'='Port Angeles Cgas'
		'NPA'='Pensacola Nas'
		'NPZ'='Porter County Municipal Airport'
		'NQA'='Millington Rgnl Jetport'
		'NQI'='Kingsville Nas'
		'NQX'='Key West Nas'
		'NSE'='Whiting Fld Nas North'
		'NTD'='Point Mugu Nas'
		'NTU'='Oceana Nas'
		'NUI'='Nuiqsut Airport'
		'NUL'='Nulato Airport'
		'NUP'='Nunapitchuk Airport'
		'NUQ'='Moffett Federal Afld'
		'NUW'='Whidbey Island Nas'
		'NXP'='Twentynine Palms Eaf'
		'NXX'='Willow Grove Nas Jrb'
		'NY9'='Long Lake'
		'NYC'='All Airports'
		'NYG'='Quantico Mcaf'
		'NZC'='Cecil Field'
		'NZJ'='El Toro'
		'NZY'='North Island Nas'
		'O03'='Morgantown Airport'
		'O27'='Oakdale Airport'
		'OAJ'='Albert J Ellis'
		'OAK'='Metropolitan Oakland Intl'
		'OAR'='Marina Muni'
		'OBE'='County'
		'OBU'='Kobuk Airport'
		'OCA'='Key Largo'
		'OCF'='International Airport'
		'OEB'='Branch County Memorial Airport'
		'OFF'='Offutt Afb'
		'OGG'='Kahului'
		'OGS'='Ogdensburg Intl'
		'OKC'='Will Rogers World'
		'OLF'='LM Clayton Airport'
		'OLH'='Old Harbor Airport'
		'OLM'='Olympia Regional Airpor'
		'OLS'='Nogales Intl'
		'OLV'='Olive Branch Muni'
		'OMA'='Eppley Afld'
		'OME'='Nome'
		'OMN'='Ormond Beach municipal Airport'
		'ONH'='Oneonta Municipal Airport'
		'ONP'='Newport Municipal Airport'
		'ONT'='Ontario Intl'
		'OOK'='Toksook Bay Airport'
		'OPF'='Opa Locka'
		'OQU'='Quonset State Airport'
		'ORD'='Chicago Ohare Intl'
		'ORF'='Norfolk Intl'
		'ORH'='Worcester Regional Airport'
		'ORI'='Port Lions Airport'
		'ORL'='Executive'
		'ORT'='Northway'
		'ORV'='Robert Curtis Memorial Airport'
		'OSC'='Oscoda Wurtsmith'
		'OSH'='Wittman Regional Airport'
		'OSU'='Ohio State University Airport'
		'OTH'='Southwest Oregon Regional Airport'
		'OTS'='Anacortes Airport'
		'OTZ'='Ralph Wien Mem'
		'OWB'='Owensboro Daviess County Airport'
		'OWD'='Norwood Memorial Airport'
		'OXC'='Waterbury-Oxford Airport'
		'OXD'='Miami University Airport'
		'OXR'='Oxnard - Ventura County'
		'OZA'='Ozona Muni'
		'P08'='Coolidge Municipal Airport'
		'P52'='Cottonwood Airport'
		'PAE'='Snohomish Co'
		'PAH'='Barkley Regional Airport'
		'PAM'='Tyndall Afb'
		'PAO'='Palo Alto Airport of Santa Clara County'
		'PAQ'='Palmer Muni'
		'PBF'='Grider Fld'
		'PBG'='Plattsburgh Intl'
		'PBI'='Palm Beach Intl'
		'PBV'='St George'
		'PBX'='Pike County Airport - Hatcher Field'
		'PCW'='Erie-Ottawa Regional Airport'
		'PCZ'='Waupaca Municipal Airport'
		'PDB'='Pedro Bay Airport'
		'PDK'='Dekalb-Peachtree Airport'
		'PDT'='Eastern Oregon Regional Airport'
		'PDX'='Portland Intl'
		'PEC'='Pelican Seaplane Base'
		'PEQ'='Pecos Municipal Airport'
		'PFN'='Panama City Bay Co Intl'
		'PGA'='Page Municipal Airport'
		'PGD'='Charlotte County-Punta Gorda Airport'
		'PGV'='Pitt-Greenville Airport'
		'PHD'='Harry Clever Field Airport'
		'PHF'='Newport News Williamsburg Intl'
		'PHK'='Pahokee Airport'
		'PHL'='Philadelphia Intl'
		'PHN'='St Clair Co Intl'
		'PHO'='Point Hope Airport'
		'PHX'='Phoenix Sky Harbor Intl'
		'PIA'='Peoria Regional'
		'PIB'='Hattiesburg Laurel Regional Airport'
		'PIE'='St Petersburg Clearwater Intl'
		'PIH'='Pocatello Regional Airport'
		'PIM'='Harris County Airport'
		'PIP'='Pilot Point Airport'
		'PIR'='Pierre Regional Airport'
		'PIT'='Pittsburgh Intl'
		'PIZ'='Point Lay Lrrs'
		'PKB'='Mid-Ohio Valley Regional Airport'
		'PLN'='Pellston Regional Airport of Emmet County Airport'
		'PMB'='Pembina Muni'
		'PMD'='Palmdale Rgnl Usaf Plt 42'
		'PML'='Port Moller Airport'
		'PMP'='Pompano Beach Airpark'
		'PNC'='Ponca City Rgnl'
		'PNE'='Northeast Philadelphia'
		'PNM'='Princeton Muni'
		'PNS'='Pensacola Rgnl'
		'POB'='Pope Field'
		'POC'='Brackett Field'
		'POE'='Polk Aaf'
		'POF'='Poplar Bluff Municipal Airport'
		'PPC'='Prospect Creek Airport'
		'PPV'='Port Protection Seaplane Base'
		'PQI'='Northern Maine Rgnl At Presque Isle'
		'PQS'='Pilot Station Airport'
		'PRC'='Ernest A Love Fld'
		'PSC'='Tri Cities Airport'
		'PSG'='Petersburg James A. Johnson'
		'PSM'='Pease International Tradeport'
		'PSP'='Palm Springs Intl'
		'PSX'='Palacios Muni'
		'PTB'='Dinwiddie County Airport'
		'PTH'='Port Heiden Airport'
		'PTK'='Oakland Co. Intl'
		'PTU'='Platinum'
		'PUB'='Pueblo Memorial'
		'PUC'='Carbon County Regional-Buck Davis Field'
		'PUW'='Pullman-Moscow Rgnl'
		'PVC'='Provincetown Muni'
		'PVD'='Theodore Francis Green State'
		'PVU'='Provo Municipal Airport'
		'PWK'='Chicago Executive'
		'PWM'='Portland Intl Jetport'
		'PWT'='Bremerton National'
		'PYM'='Plymouth Municipal Airport'
		'PYP'='Centre-Piedmont-Cherokee County Regional Airport'
		'R49'='Ferry County Airport'
		'RAC'='John H. Batten Airport'
		'RAL'='Riverside Muni'
		'RAP'='Rapid City Regional Airport'
		'RBD'='Dallas Executive Airport'
		'RBK'='French Valley Airport'
		'RBM'='Robinson Aaf'
		'RBN'='Fort Jefferson'
		'RBY'='Ruby Airport'
		'RCA'='Ellsworth Afb'
		'RCE'='Roche Harbor Seaplane Base'
		'RCZ'='Richmond County Airport'
		'RDD'='Redding Muni'
		'RDG'='Reading Regional Carl A Spaatz Field'
		'RDM'='Roberts Fld'
		'RDR'='Grand Forks Afb'
		'RDU'='Raleigh Durham Intl'
		'RDV'='Red Devil Airport'
		'REI'='Redlands Municipal Airport'
		'RFD'='Chicago Rockford International Airport'
		'RHI'='Rhinelander Oneida County Airport'
		'RIC'='Richmond Intl'
		'RID'='Richmond Municipal Airport'
		'RIF'='Richfield Minicipal Airport'
		'RIL'='Garfield County Regional Airport'
		'RIR'='Flabob Airport'
		'RIU'='Rancho Murieta'
		'RIV'='March Arb'
		'RIW'='Riverton Regional'
		'RKD'='Knox County Regional Airport'
		'RKH'='Rock Hill York Co Bryant Airport'
		'RKP'='Aransas County Airport'
		'RKS'='Rock Springs Sweetwater County Airport'
		'RME'='Griffiss Afld'
		'RMG'='Richard B Russell Airport'
		'RMP'='Rampart Airport'
		'RMY'='Brooks Field Airport'
		'RND'='Randolph Afb'
		'RNM'='Ramona Airport'
		'RNO'='Reno Tahoe Intl'
		'RNT'='Renton'
		'ROA'='Roanoke Regional'
		'ROC'='Greater Rochester Intl'
		'ROW'='Roswell Intl Air Center'
		'RSH'='Russian Mission Airport'
		'RSJ'='Rosario Seaplane Base'
		'RST'='Rochester'
		'RSW'='Southwest Florida Intl'
		'RUT'='Rutland State Airport'
		'RVS'='Richard Lloyd Jones Jr Airport'
		'RWI'='Rocky Mount Wilson Regional Airport'
		'RWL'='Rawlins Municipal Airport-Harvey Field'
		'RYY'='Cobb County Airport-Mc Collum Field'
		'S46'="Port O\\'Connor Airfield"
		'SAA'='Shively Field Airport'
		'SAC'='Sacramento Executive'
		'SAD'='Safford Regional Airport'
		'SAF'='Santa Fe Muni'
		'SAN'='San Diego Intl'
		'SAT'='San Antonio Intl'
		'SAV'='Savannah Hilton Head Intl'
		'SBA'='Santa Barbara Muni'
		'SBD'='San Bernardino International Airport'
		'SBM'='Sheboygan County Memorial Airport'
		'SBN'='South Bend Rgnl'
		'SBO'='Emanuel Co'
		'SBP'='San Luis County Regional Airport'
		'SBS'='Steamboat Springs Airport-Bob Adams Field'
		'SBY'='Salisbury Ocean City Wicomico Rgnl'
		'SCC'='Deadhorse'
		'SCE'='University Park Airport'
		'SCH'='Stratton ANGB - Schenectady County Airpor'
		'SCK'='Stockton Metropolitan'
		'SCM'='Scammon Bay Airport'
		'SDC'='Williamson-Sodus Airport'
		'SDF'='Louisville International Airport'
		'SDM'='Brown Field Municipal Airport'
		'SDP'='Sand Point Airport'
		'SDX'='Sedona'
		'SDY'='Sidney-Richland Municipal Airport'
		'SEA'='Seattle Tacoma Intl'
		'SEE'='Gillespie'
		'SEF'='Regional - Hendricks AAF'
		'SEM'='Craig Fld'
		'SES'='Selfield Airport'
		'SFB'='Orlando Sanford Intl'
		'SFF'='Felts Fld'
		'SFM'='Sanford Regional'
		'SFO'='San Francisco Intl'
		'SFZ'='North Central State'
		'SGF'='Springfield Branson Natl'
		'SGH'='Springfield-Beckly Municipal Airport'
		'SGJ'='St. Augustine Airport'
		'SGR'='Sugar Land Regional Airport'
		'SGU'='St George Muni'
		'SGY'='Skagway Airport'
		'SHD'='Shenandoah Valley Regional Airport'
		'SHG'='Shungnak Airport'
		'SHH'='Shishmaref Airport'
		'SHR'='Sheridan County Airport'
		'SHV'='Shreveport Rgnl'
		'SHX'='Shageluk Airport'
		'SIK'='Sikeston Memorial Municipal'
		'SIT'='Sitka Rocky Gutierrez'
		'SJC'='Norman Y Mineta San Jose Intl'
		'SJT'='San Angelo Rgnl Mathis Fld'
		'SKA'='Fairchild Afb'
		'SKF'='Lackland Afb Kelly Fld Annex'
		'SKK'='Shaktoolik Airport'
		'SKY'='Griffing Sandusky'
		'SLC'='Salt Lake City Intl'
		'SLE'='McNary Field'
		'SLK'='Adirondack Regional Airport'
		'SLN'='Salina Municipal Airport'
		'SLQ'='Sleetmute Airport'
		'SMD'='Smith Fld'
		'SME'='Lake Cumberland Regional Airport'
		'SMF'='Sacramento Intl'
		'SMK'='St. Michael Airport'
		'SMN'='Lemhi County Airport'
		'SMO'='Santa Monica Municipal Airport'
		'SMX'='Santa Maria Pub Cpt G Allan Hancock Airport'
		'SNA'='John Wayne Arpt Orange Co'
		'SNP'='St Paul Island'
		'SNY'='Sidney Muni Airport'
		'SOP'='Moore County Airport'
		'SOW'='Show Low Regional Airport'
		'SPB'='Scappoose Industrial Airpark'
		'SPF'='Black Hills Airport-Clyde Ice Field'
		'SPG'='Albert Whitted'
		'SPI'='Abraham Lincoln Capital'
		'SPS'='Sheppard Afb Wichita Falls Muni'
		'SPW'='Spencer Muni'
		'SPZ'='Silver Springs Airport'
		'SQL'='San Carlos Airport'
		'SRQ'='Sarasota Bradenton Intl'
		'SRR'='Sierra Blanca Regional Airport'
		'SRV'='Stony River 2 Airport'
		'SSC'='Shaw Afb'
		'SSI'='McKinnon Airport'
		'STC'='Saint Cloud Regional Airport'
		'STE'='Stevens Point Municipal Airport'
		'STG'='St. George Airport'
		'STJ'='Rosecrans Mem'
		'STK'='Sterling Municipal Airport'
		'STL'='Lambert St Louis Intl'
		'STS'='Charles M Schulz Sonoma Co'
		'SUA'='Witham Field Airport'
		'SUE'='Door County Cherryland Airport'
		'SUN'='Friedman Mem'
		'SUS'='Spirit Of St Louis'
		'SUU'='Travis Afb'
		'SUX'='Sioux Gateway Col Bud Day Fld'
		'SVA'='Savoonga Airport'
		'SVC'='Grant County Airport'
		'SVH'='Regional Airport'
		'SVN'='Hunter Aaf'
		'SVW'='Sparrevohn Lrrs'
		'SWD'='Seward Airport'
		'SWF'='Stewart Intl'
		'SXP'='Sheldon Point Airport'
		'SXQ'='Soldotna Airport'
		'SYA'='Eareckson As'
		'SYB'='Seal Bay Seaplane Base'
		'SYR'='Syracuse Hancock Intl'
		'SZL'='Whiteman Afb'
		'TAL'='Tanana Airport'
		'TAN'='Taunton Municipal Airport - King Field'
		'TBN'='Waynesville Rgnl Arpt At Forney Fld'
		'TCC'='Tucumcari Muni'
		'TCL'='Tuscaloosa Rgnl'
		'TCM'='Mc Chord Afb'
		'TCS'='Truth Or Consequences Muni'
		'TCT'='Takotna Airport'
		'TEB'='Teterboro'
		'TEK'='Tatitlek Airport'
		'TEX'='Telluride'
		'TIK'='Tinker Afb'
		'TIW'='Tacoma Narrows Airport'
		'TKA'='Talkeetna'
		'TKE'='Tenakee Seaplane Base'
		'TKF'='Truckee-Tahoe Airport'
		'TKI'='Collin County Regional Airport at Mc Kinney'
		'TLA'='Teller Airport'
		'TLH'='Tallahassee Rgnl'
		'TLJ'='Tatalina Lrrs'
		'TLT'='Tuluksak Airport'
		'TMA'='Henry Tift Myers Airport'
		'TMB'='Kendall Tamiami Executive'
		'TNC'='Tin City LRRS Airport'
		'TNK'='Tununak Airport'
		'TNT'='Dade Collier Training And Transition'
		'TNX'='Tonopah Test Range'
		'TOA'='Zamperini Field Airport'
		'TOC'='Toccoa RG Letourneau Field Airport'
		'TOG'='Togiak Airport'
		'TOL'='Toledo'
		'TOP'='Philip Billard Muni'
		'TPA'='Tampa Intl'
		'TPL'='Draughon Miller Central Texas Rgnl'
		'TRI'='Tri-Cities Regional Airport'
		'TRM'='Jacqueline Cochran Regional Airport'
		'TSS'='East 34th Street Heliport'
		'TTD'='Portland Troutdale'
		'TTN'='Trenton Mercer'
		'TUL'='Tulsa Intl'
		'TUP'='Tupelo Regional Airport'
		'TUS'='Tucson Intl'
		'TVC'='Cherry Capital Airport'
		'TVF'='Thief River Falls'
		'TVI'='Thomasville Regional Airport'
		'TVL'='Lake Tahoe Airport'
		'TWA'='Twin Hills Airport'
		'TWD'='Jefferson County Intl'
		'TWF'='Magic Valley Regional Airport'
		'TXK'='Texarkana Rgnl Webb Fld'
		'TYE'='Tyonek Airport'
		'TYR'='Tyler Pounds Rgnl'
		'TYS'='Mc Ghee Tyson'
		'U76'='Mountain Home Municipal Airport'
		'UDD'='Bermuda Dunes Airport'
		'UDG'='Darlington County Jetport'
		'UES'='Waukesha County Airport'
		'UGN'='Waukegan Rgnl'
		'UIN'='Quincy Regional Baldwin Field'
		'UMP'='Indianapolis Metropolitan Airport'
		'UNK'='Unalakleet Airport'
		'UPP'='Upolu'
		'UST'='St. Augustine Airport'
		'UTM'='Tunica Municipal Airport'
		'UTO'='Indian Mountain Lrrs'
		'UUK'='Ugnu-Kuparuk Airport'
		'UUU'='Newport State'
		'UVA'='Garner Field'
		'VAD'='Moody Afb'
		'VAK'='Chevak Airport'
		'VAY'='South Jersey Regional Airport'
		'VBG'='Vandenberg Afb'
		'VCT'='Victoria Regional Airport'
		'VCV'='Southern California Logistics'
		'VDF'='Tampa Executive Airport'
		'VDZ'='Valdez Pioneer Fld'
		'VEE'='Venetie Airport'
		'VEL'='Vernal Regional Airport'
		'VGT'='North Las Vegas Airport'
		'VIS'='Visalia Municipal Airport'
		'VLD'='Valdosta Regional Airport'
		'VNW'='Van Wert County Airport'
		'VNY'='Van Nuys'
		'VOK'='Volk Fld'
		'VPC'='Cartersville Airport'
		'VPS'='Eglin Afb'
		'VRB'='Vero Beach Muni'
		'VSF'='Hartness State'
		'VYS'='Illinois Valley Regional'
		'W13'="Eagle's Nest Airport"
		'WAA'='Wales Airport'
		'WAL'='Wallops Flight Facility'
		'WAS'='All Airports'
		'WBB'='Stebbins Airport'
		'WBQ'='Beaver Airport'
		'WBU'='Boulder Municipal'
		'WBW'='Wilkes-Barre Wyoming Valley Airport'
		'WDR'='Barrow County Airport'
		'WFB'='Ketchikan harbor Seaplane Base'
		'WFK'='Northern Aroostook Regional Airport'
		'WHD'='Hyder Seaplane Base'
		'WHP'='Whiteman Airport'
		'WIH'='Wishram Amtrak Station'
		'WKK'='Aleknagik Airport'
		'WKL'='Waikoloa Heliport'
		'WLK'='Selawik Airport'
		'WMO'='White Mountain Airport'
		'WRB'='Robins Afb'
		'WRG'='Wrangell Airport'
		'WRI'='Mc Guire Afb'
		'WRL'='Worland Municipal Airport'
		'WSD'='Condron Aaf'
		'WSJ'='San Juan - Uganik Seaplane Base'
		'WSN'='South Naknek Airport'
		'WST'='Westerly State Airport'
		'WSX'='Westsound Seaplane Base'
		'WTK'='Noatak Airport'
		'WTL'='Tuntutuliak Airport'
		'WWD'='Cape May Co'
		'WWP'='North Whale Seaplane Base'
		'WWT'='Newtok Airport'
		'WYS'='Yellowstone Airport'
		'X01'='Everglades Airpark'
		'X07'='Lake Wales Municipal Airport'
		'X21'='Arthur Dunn Airpark'
		'X39'='Tampa North Aero Park'
		'X49'='South Lakeland Airport'
		'XFL'='Flagler County Airport'
		'XNA'='NW Arkansas Regional'
		'XZK'='Amherst Amtrak Station AMM'
		'Y51'='Municipal Airport'
		'Y72'='Bloyer Field'
		'YAK'='Yakutat'
		'YIP'='Willow Run'
		'YKM'='Yakima Air Terminal McAllister Field'
		'YKN'='Chan Gurney'
		'YNG'='Youngstown Warren Rgnl'
		'YUM'='Yuma Mcas Yuma Intl'
		'Z84'='Clear'
		'ZBP'='Penn Station'
		'ZFV'='Philadelphia 30th St Station'
		'ZPH'='Municipal Airport'
		'ZRA'='Atlantic City Rail Terminal'
		'ZRD'='Train Station'
		'ZRP'='Newark Penn Station'
		'ZRT'='Hartford Union Station'
		'ZRZ'='New Carrollton Rail Station'
		'ZSF'='Springfield Amtrak Station'
		'ZSY'='Scottsdale Airport'
		'ZTF'='Stamford Amtrak Station'
		'ZTY'='Boston Back Bay Station'
		'ZUN'='Black Rock'
		'ZVE'='New Haven Rail Station'
		'ZWI'='Wilmington Amtrak Station'
		'ZWU'='Washington Union Station'
		'ZYP'='Penn Station'
		;
	
	value MonthName
		1='January'
		2='February'
		3='March'
		4='April'
		5='May'
		6='June'
		7='July'
		8='August'
		9='September'
		10='October'
		11='November'
		12='December'
		;
	
	value timeofday
		0 = '0-1 A:M'
		1 = '1-2 A:M'
		2 = '2-3 A:M'
		3 = '3-4 A:M'
		4 = '4-5 A:M'
		5 = '5-6 A:M'
		6 = '6-7 A:M'
		7 = '7-8 A:M'
		8 = '8-9 A:M'
		9 = '9-10 A:M'
		10 = '10-11 A:M'
		11 = '11-12 A:M'
		12 = '12-1 P:M'
		13 = '1-2 P:M'
		14 = '2-3 P:M'
		15 = '3-4 P:M'
		16 = '4-5-P:M'
		17 = '5-6 P:M'
		18 = '6-7 P:M'
		19 = '7-8 P:M'
		20 = '8-9 P:M'
		21 = '9-10 P:M'
		22 = '10-11 P:M'
		23 = '11-12 P:M'
		;	
	
	value Dep_Delay
		-31<-<0 = 'Early Departure'
		;

	value Arr_Delay
		-31<-<0 = 'Early Arrival'
		;

 	value $missfmt 
 		' '='Missing' other='Not Missing'
 		;
 
 	value missfmt  
 		. ='Missing' other='Not Missing'
 		;

RUN;

/* QUESTION 1 */

DATA Q1_Flights;
	set Flights;
	
	Year 	= year(Date);
	Month 	= month(Date);
	Day 	= day(Date);
	Hour 	= hour(Sched_Dep_Time);
	
	Dep_Delay_Mins = intck('minutes',Sched_Dep_Time, Dep_Time);
	Arr_Delay_Mins = intck('minutes', Sched_Arr_Time, Arr_Time);
	
	format  Carrier				$carrier.
			Origin				$airport.
			Dest				$airport.
			Dep_Delay_Mins 		Dep_Delay. 
			Arr_Delay_Mins 		Arr_Delay.
			;
RUN;

/* QUESTION 2 */

/* Weather data with Hour variable */

DATA Q2A_Weather;
	set Weather;
	
	Hour = hour(Time);
	
	format 	Origin $airport.;
RUN;

/* Flights & Weather_combined Data set */

PROC SQL;
	create table 
		Flight_Weather_SQL
	as
	select 	 x.Date
			,x.Carrier
			,x.Flight
			,x.Origin
			,x.Dest
			,x.Tailnum
			,x.Distance
			,x.Air_Time
			,x.Sched_Dep_Time
			,x.Dep_Time
			,x.Sched_Arr_Time
			,x.Arr_Time
			,y.Precip
			,y.Visib
			,y.Temp
			,y.Dewp
			,y.Humid
			,y.Wind_Dir
			,y.Wind_Speed
			,y.Wind_Gust
			,y.Pressure
	from 
		Q1_Flights as x
	left join 
		Q2A_Weather as y
	on
		x.origin = y.origin 
	and
		x.date = y.date		
	and
		x.hour = y.hour;
QUIT;

/* QUESTION 2b */

DATA Q2B_Planes (drop = Current_Year);
	set Planes;

	Current_Year = 2013;
	Years_Use = (Current_Year - Manufacturing_Year);
RUN;

PROC SQL;
	create table 
		Flight_Plane_SQL
	as
	select 	 x.Date
			,x.Carrier
			,x.Flight
			,x.Origin
			,x.Dest
			,x.Tailnum
			,x.Distance
			,x.Air_Time
			,x.Sched_Dep_Time
			,x.Dep_Time
			,x.Sched_Arr_Time
			,x.Arr_Time
			,y.Manufacturer
			,y.Manufacturing_Year
			,y.Years_Use
	from
		Q1_Flights as x
	left join
		Q2B_Planes as y
	on  
		x.Tailnum = y.Plane
	order by
		x.Date;
QUIT;

/* QUESTION 3 (i) */

/* Missing values in Flight Data Set */

PROC FREQ data = flights; 
format _CHAR_ $missfmt.; 
tables _CHAR_ / missing missprint nocum;

format _NUMERIC_ missfmt.;
tables _NUMERIC_ / missing missprint nocum;
RUN;

/* Deleting observations with missing values for variables Tailnum, Dep_Time, Arr_Time */

DATA Flight_NoMisssing;
	set Flights;
	 
	where 	Tailnum  is not missing
	and 	Dep_Time is not missing
	and 	Arr_Time is not missing;
RUN;

/* Missing value count after deleting observations */

PROC MEANS data = Flight_NoMisssing nmiss ;
	title 'Missing count of variables in Flight Data Set';
RUN;

/* Replacing missing values */

PROC Sort data = Q1_Flights;
	by Carrier Origin Dest;
RUN;

/* Replacing misising values with mean */

PROC stdize data = Q1_Flights out = Flight_Std method=mean reponly;
	var Air_Time Arr_delay_Mins;
	by Carrier Origin Dest;
RUN;

/* Cross checking the avg delay value */

PROC TABULATE data = Q1_Flights;
	class Carrier Origin Dest;
	var Air_Time Arr_Delay_Mins;
	table (Carrier*Origin*Dest), (Air_Time Arr_Delay_Mins)*(mean);
RUN;

/* QUESTION 3 (ii) */

/* Missing value count in Weather dataset for variables */

PROC FREQ data = Q2A_Weather; 
format _CHAR_ $missfmt.; 
tables _CHAR_/ missing nocum nopercent;

format _NUMERIC_ missfmt.;
tables _NUMERIC_ / missing missprint nocum nopercent;
RUN;

/* Replacing missing values with avg values for temp parameters */

PROC SORT data = Q2A_Weather;
	by Origin Date;
RUN;

PROC stdize data = Q2A_Weather out = weather_std method=mean reponly;
	var Temp Dewp Humid Wind_Dir Wind_Speed Wind_Gust Precip Pressure Visib;
	by Origin Date;
RUN;

/* Cross checking avg temp parameters values */

PROC TABULATE data = Q2A_Weather;
	class Origin Date;
	var Temp Dewp Humid Wind_Dir Wind_Speed Wind_Gust Precip Pressure Visib;
	table (Origin*Date), (Temp Dewp Humid Wind_Dir Wind_Speed Wind_Gust Precip Pressure Visib)*(mean);
	keylabel mean = 'Average';
RUN;

/* QUESTION 3 (iii) */

/* Missing Value count in the Planes dataset for variables */

PROC FREQ data = Planes; 
format _CHAR_ $missfmt.; 
tables _CHAR_ / missing nocum ;

format _NUMERIC_ missfmt.;
tables _NUMERIC_ / missing missprint nocum;
RUN;

/* Drop Variable with more than 70% missing values */

DATA Planes_LessVar (drop = speed);
	set Planes;
RUN;

/* Count of observations with missing values for variables */

DATA Planes_Missing (keep = plane Fuel_CC Manufacturing_Year);
	set Planes_LessVar;
	
	where Fuel_CC = . or  Manufacturing_Year = .;
RUN;

/* Only 70 observations (common) needs to be deleted */

DATA Planes_LessData;
	set Planes_LessVar;
	
	where Fuel_CC ^= . or  Manufacturing_Year ^= .;
RUN;


/* QUESTION 4 */
/* Variable names and labels */

DATA Flights;
	set Flights;
	
	label 	Date			= 'Date of Departure'	
			Sched_Dep_Time	= 'Scheduled Departure Time'
			Dep_Time		= 'Departure Time'
			Sched_Arr_Time	= 'Scheduled Arrival Time'
			Arr_Time		= 'Arrival Time'
			Carrier			= 'Carrier Name'
			Flight			= 'Flight Number'
			Tailnum			= 'Tail Number'
			Origin			= 'Origin Airport'
			Dest			= 'Destination Airport'
			Distance		= 'Distance Flown'
			Air_Time		= 'Flight Duration (Mins)'
			;
RUN;

DATA Planes;
	set Planes;
	
	label  	Plane				= 'Tail Number'
			Manufacturing_Year	= 'Year Manufactured'
			Type				= 'Type of Plane'
			Manufacturer		= 'Manufacturer'
			Model				= 'Model Number'
			Engines				= 'Number of Engines'
			Seats				= 'Number of Seats'
			Speed				= 'Cruise Speed (MPH)'
			Engine				= 'Engine Type'
			Fuel_CC				= 'Avg Annual Fuel Consumption Cost'
			;
RUN;

DATA Weather;
	set Weather;
	
	label 	Origin		= 'Origin Airport'
			Date		= 'Date of Recording'
			Time		= 'Time of Recording'
			Temp		= 'Temperature (F)'
			Dewp		= 'Deppoint (F)'
			Humid		= 'Humidity'
			Wind_Dir	= 'Wind Direction (Degree)'
			Wind_Speed	= 'Wind Speed (MPH)'
			Wind_Gust	= 'Guest Speed (MPH)'
			Precip		= 'Preciptation (Inches)'
			Pressure	= 'Pressure (Milibars)'
			Visib		= 'Visibility (Miles)'
			;	
RUN;

/* QUESTION 4(ii) */

DATA Approx_FuelCost;
	set planes;
	
	Fuel_CC = round(Fuel_CC);
	
	format Fuel_CC 10.;
RUN;

/* QUESTION 4(iii) */

/* Adding value labels to Carrier Codes has been done at the time of importing and preparing data */
/* Adding value labels to Origin and Destination has been done importing and preparing data */

/* Flight variable Converting to CHARACTER VARIABLE */

DATA Flights (rename = (Flight_Char = Flight) drop = Flight);
	set Flights;
	
	Flight_Char = put(Flight, 4.);
RUN;

/* QUESTION 5 */

/* Top 5 Busiest routes for 2013 */

PROC SQL outobs = 5;
	create table 
		Busy_Routes
	as
	select	
		Origin			label = 'Origin Airport',
		Dest			label = 'Destination Airport',
		count(*) 	as  Flight_Count label = 'Flight Count'
	from
		Q1_Flights
	where 
		year(Date) = 2013
	group by
		Origin, Dest
	order by 
		Flight_Count desc;
		
	title 'Top 5 busiest route for year 2013';
	select * from Busy_Routes;
QUIT;

/* QUESTION 5 (ii) */

/* No of flights by Carrier to top 5 busiest routes */

PROC SQL;
	create table 
		Busy_Carrier
	as
	select	
		 Carrier						label = 'Carrier Name'
		,count(flight) 	as Flight_Count label = 'Flight Count'
	from
		Q1_Flights
	where 
		(Origin = 'JFK' and Dest = 'LAX')
	or
		(Origin = 'LGA' and Dest = 'ATL')
	or 
		(Origin = 'LGA' and Dest = 'ORD')
	or
		(Origin = 'JFK' and Dest = 'SFO')
	or	
		(Origin = 'LGA' and Dest = 'CLT')
	group by
		Carrier 
	order by 
		Flight_Count desc;	
		
	title 'No of flights by each Carrier for top 5 Routes';
	
	select 
		x.Carrier_Name,
		y.Flight_Count
	from	
		Airlines as x
	left join
		Busy_Carrier as y
	on
		x.Flight_Code = y.Carrier
	order by
		y.Flight_Count desc;
QUIT;

/* QUESTION 5 (iii) */

/* Total flights by Carrier */

PROC SQL;
	create table 
		Carrier_FlightCount
	as
	select	
		Carrier,
		count(*) as Total_Flights label = 'Total Flights'
	from	
		Q1_Flights
	group by
		Carrier;

	title 'Percentage of flights to top 5 routes to total flights for each Carrier';
	select
		 y.Carrier
		,case when x.Flight_Count is not missing then x.Flight_Count else 0 end as Flight_C
		,y.Total_Flights
		,((case when x.Flight_Count is not missing then x.Flight_Count else 0 end)/y.Total_Flights) as Percent_To_TopRoute format = percent7.3
	from
		Busy_Carrier as x
	right join
		Carrier_FlightCount as y
	on 
		x.Carrier = y.Carrier
	order by
		Percent_To_TopRoute desc;
QUIT;

/* QUESTION 6 */

/* QUESTION 6 (i) */

/* Busiest time of the day for Carrier */

PROC SQL;
	create table
		Busy_Time
	as
	select 
		 Carrier
		,Hour as Time_During_Day format = timeofday.
		,Count(*) as Total_Flight
	from
		Q1_flights
	group by
		Carrier, Hour
	order by
		Carrier, Total_Flight  desc;
QUIT;

PROC RANK data = Busy_Time out = Rank_Data descending ties= dense;
	by Carrier;
	var Total_Flight;
	ranks Rank;
RUN;

PROC SQL;
	title 'Busiest time of the day for each Carrier';
	
	select 
		 Carrier as Carrier_Name
		,Time_During_Day as Time_Interval
		,Total_Flight as Flight_Count
	from	
		Rank_Data
	where 
		Rank = 1
	order by
		Total_Flight desc;
QUIT;

/*  QUESTION 6 (ii) */

/* Busiest time of the day for Airports */

PROC SQL;
	create table
		busy_time_airport
	as
	select	
		 Origin
		,Hour as Time_During_Day format = timeofday.
		,Count(*) as Total_Flights
	from
		Q1_flights
	group by
		Origin, Hour
	order by
		Origin, Total_Flights  desc;
QUIT;

PROC RANK data = busy_time_airport out  = rank_data_airport descending ties= dense;
	by Origin;
	var Total_Flights;
	ranks airportrank;
RUN;

PROC SQL;
	title 'Busiest Time of the Day for JFK, LGA & EWR';
	select 
		 Origin
		,Time_During_Day
		,Total_Flights as Flights_Count
	from
		rank_data_airport
	where 
		airportrank = 1;
QUIT;

/* QUESTION 7 */

/* QUESTION 7 (i) */

/* Percentage of Flights delayed at JFK Airport */

PROC SQL;
	title ' Percentage of flights delayed from JFK Airport';
	select distinct
		 Origin
		,sum(case when Dep_Delay_Mins > 0 then 1 else 0 end) as Delayed_Flights
		,count(*) as Total_Flights
		,(sum(case when Dep_Delay_Mins > 0 then 1 else 0 end))/count(*) as Delay_Percentage format=percent7.2
	from
		Q1_flights
	where 
		origin = 'JFK';	
QUIT;

/* QUESTION 7 (ii) */

/* Origin Airports with least no of delayed flights */

PROC SQL outobs=1;
	title 'Origin Airport with least number of delayed flights';
	
	select distinct
		 Origin
		,sum(case when Dep_Delay_Mins > 0 then 1 else 0 end) as Delayed_Flights
	from
		Q1_flights
	group by
		Origin
	order by
		Delayed_Flights;
QUIT;

/* QUESTION 7 (iii) */

/* Destination Airports with highest no of delayed flights */

PROC SQL outobs=1;
	title 'Destination Airports with highest no of delayed flights';
	
	select distinct
		 Dest
		,sum(case when Arr_Delay_Mins > 0 then 1 else 0 end) as Delayed_Flights
	from
		Q1_flights
	group by
		Dest
	order by
		Delayed_Flights desc;
QUIT;

/* QUESTION 8 */

/* QUESTION 8 (i) */

/* Joining Flights Data with Weather Data */

PROC SQL;
	create table 
		Flight_Weather_Join
	as
	select 	 x.Date
			,x.Month
			,x.Dep_Delay_Mins
			,y.Precip
			,y.Visib
			,y.Temp
			,y.Dewp
			,y.Humid
			,y.Wind_Dir
			,y.Wind_Speed
			,y.Wind_Gust
			,y.Pressure
	from 
		Q1_Flights as x
	left join 
		Q2A_Weather as y
	on
		x.origin = y.origin 
	and
		x.date = y.date		
	and
		x.hour = y.hour;
QUIT;

/* QUESTION 8 (ii) */

PROC SORT data = Flight_Weather_Join;
	by Month;
RUN;

/* Standardzing missing values */

PROC stdize data = Flight_Weather_Join out = Flight_Weather_Std /*method=mean*/ missing=0 reponly;
	var Dep_Delay_Mins Temp Dewp Humid Wind_Dir Wind_Speed Wind_Gust Precip Pressure Visib;
	by Month;
RUN;

/* Average values for weather for each month */

PROC SQL;
	create table 
		Flight_Weather_Avg
	as
	select 	 Month 					as Month				format = MonthName.			
			,avg(Dep_Delay_Mins) 	as Avg_Delay			format = 4.
			,avg(Precip) 			as Avg_Precip			format = 4.2
			,avg(Visib) 			as Avg_Visibility		format = 5.2
			,avg(Temp) 				as Avg_Temp				format = 6.2
			,avg(Dewp) 				as Avg_Dewp				format = 5.2
			,avg(Humid) 			as Avg_Humid			format = 5.2
			,avg(Wind_Dir) 			as Avg_Wind_Dir			format = 3.
			,avg(Wind_Speed) 		as Avg_Wind_Speed		format = 7.2
			,avg(Wind_Gust) 		as Avg_Wind_Guest		format = 7.2
			,avg(Pressure) 			as Avg_Pressure			format = 6.1
	from
		Flight_Weather_Std
	group by
		month
	order by 
		Avg_Delay;
QUIT;

/* QUESTION 8 (iii) */

/* PROC CORR for correlation_Avg_Dealy and Weather Parameters */

PROC CORR data = Flight_Weather_Avg ;
	title 'Correlation between Avg_Dealy and Weather Parameters';
	title2 'By looking at the proc data, we find that Avg delay is correlated positively with Avg_Precip & negatively with Avg_Pressure';
	var avg_delay Avg_Precip Avg_Visibility Avg_Temp Avg_Dewp Avg_Humid Avg_Wind_Dir Avg_Wind_Speed Avg_Wind_Guest Avg_Pressure;
RUN;

/* PROC PLOT for correlation */

PROC PLOT data = Flight_Weather_Avg vpercent=30 hpercent = 30;
	plot Avg_Precip*Avg_Delay = '*';
	plot Avg_Visibility*Avg_Delay = '*';
	plot Avg_Temp*Avg_Delay = '*';
	plot Avg_Dewp*Avg_Delay = '*';
	plot Avg_Humid*Avg_Delay = '*';
	plot Avg_Wind_Dir*Avg_Delay = '*';
	plot Avg_Wind_Speed*Avg_Delay = '*';
	plot Avg_Wind_Guest*Avg_Delay = '*';
	plot Avg_Pressure*Avg_Delay = '*';
	
	title 'Average Flight Delay vs Temp Parameters';
	title2 'By looking at the Graphs below we can infer that Percipitaion (positively) and Pressure (negatively) corelated with Delay';
RUN;

/* QUESTION 9 */

/* QUESTION 9 (i) */

/* Average cost for fuel consumed by Planes */

PROC SQL;
	create table
		FuelCost_YearManu
	as
	select
		 Manufacturing_Year
		,Avg(Fuel_CC) as Fuel_Cost format=10.
	from
		Planes
	group by
		Manufacturing_Year
	order by
		Fuel_Cost desc;
QUIT;

PROC CORR data = FuelCost_YearManu;
	var Manufacturing_Year Fuel_Cost;
RUN;

PROC SGSCATTER data = FuelCost_YearManu;
	title 'Manufacturing Year vs Avg Fuel Cost';
	title2 'Average Fuel Cost for newer planes is more compared to older planes';
	plot Fuel_Cost*Manufacturing_Year / reg;
RUN;

/* QUESTION 9 (ii) */

PROC TABULATE data = Planes;
	class Engines Seats Engine Type / style=[background=orange];
	var Fuel_CC;
	tables (Engines Seats Engine Type),(Fuel_CC)* mean;
	keylabel mean = 'Average Fuel Cost';
	label Fuel_CC='Fuel Consumption Cost' Engines = 'No of Engines' Seats = 'No of Seats' Engine = 'Engine Type' Type = 'Plane Type';
RUN;

PROC CORR data = Planes;
	var Fuel_CC Engines Seats;
RUN;

PROC SGSCATTER data = Planes;
	title 'By looking at the plotted data, we can infer that the fuel consumtion is directly proportional to No of seats';

	plot Fuel_CC*Seats / reg;
RUN;

/* QUESTION 10 */

PROC SQL;
	create table
		DelayedFlights
	as
	select
		 Hour format=timeofday.
		,avg(Dep_Delay_Mins) as Avg_Delay_Mins format=5.2
	from
		Q1_flights
	where 
		Dep_Delay_Mins > 0
	group by
		Hour
	order by
		Avg_Delay_Mins;
QUIT;

/* Avreage delay in minutes over the day */

PROC SGSCATTER data = DelayedFlights;
	title 'Average flight delay in minutes during the day';
	title2 'Looking at the chart we can infer that avg deprature delays increases as day progresses and is maximum during midnight';

	plot Avg_Delay_Mins*Hour / reg;
RUN;

/*..........................END........................*/

