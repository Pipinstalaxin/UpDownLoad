//+---------------------------------------------------------------------+
//|                           Copyright © 2008, www.artemka@mail.ru    |
//+---------------------------------------------------------------------+
#property copyright "Copyright © 2008, www.artemka@mail.ru"
#property link      ""
#property indicator_separate_window

extern string Buy_currency_pairs = "----- List of Buy currency pairs -----";
extern string Buy_pair_1 = "USDJPY";
extern bool  Show_buy_direction_1 = true;

extern string Buy_pair_2 = "EURUSD";
extern bool  Show_buy_direction_2 = true;

extern string Buy_pair_3 = "EURCHF";
extern bool  Show_buy_direction_3 = true;

extern string Buy_pair_4 = "GBPJPY";
extern bool  Show_buy_direction_4 = true;

extern string Buy_pair_5 = "USDCAD";
extern bool  Show_buy_direction_5 = true;

extern string Buy_pair_6 = "CADJPY";
extern bool  Show_buy_direction_6 = true;

extern string Buy_pair_7 = "AUDUSD";
extern bool  Show_buy_direction_7 = true;

extern string Sell_currency_pairs = "----- List of Sell currency pairs -----";
extern string Sell_pair_1 = "EURJPY";
extern bool  Show_sell_direction_1 = true;

extern string Sell_pair_2 = "GBPUSD";
extern bool  Show_sell_direction_2 = true;

extern string Sell_pair_3 = "EURGBP";
extern bool  Show_sell_direction_3 = true;

extern string Sell_pair_4 = "GBPCHF";
extern bool  Show_sell_direction_4 = true;

extern string Sell_pair_5 = "CHFJPY";
extern bool  Show_sell_direction_5 = true;

extern string Sell_pair_6 = "USDCHF";
extern bool  Show_sell_direction_6 = true;

extern string Sell_pair_7 = "AUDJPY";
extern bool  Show_sell_direction_7 = true;


double GBPUSDm, EURGBPm, GBPJPYm, USDCHFm, NZDUSDm, AUDJPYm, EURJPYm;
double EURUSDm, USDJPYm, AUDUSDm, NZDJPYm, GBPCHFm, CHFJPYm, EURCHFm;

int blue, red;

double GBPUSDm_now,EURGBPm_now,GBPJPYm_now,USDCHFm_now,NZDUSDm_now,AUDJPYm_now,EURJPYm_now;
double EURUSDm_now,USDJPYm_now,AUDUSDm_now,NZDJPYm_now,GBPCHFm_now,CHFJPYm_now,EURCHFm_now;

double GBPUSDm_pips, EURGBPm_pips, GBPJPYm_pips, USDCHFm_pips, NZDUSDm_pips,
       AUDJPYm_pips, EURJPYm_pips;

double EURUSDm_pips, USDJPYm_pips,AUDUSDm_pips,NZDJPYm_pips,GBPCHFm_pips,
       CHFJPYm_pips,EURCHFm_pips;

double long_pips, short_pips;

string signal;

string short_name;
int wnd;

string PairsNames1[14];   
string PairsNames2[14];   
string PairsNames3[14];   
string PairsNames4[14];   
string PairsNames5[14];   
string PairsNames6[14];   
string PairsNames7[14];   


int init()
{
      
   short_name="EA_SHARK1.0_ULTIMATE";
   IndicatorShortName(short_name);

   return(0);
}

int deinit()
{
   delete_objects(1);
   delete_objects(2);
   delete_objects(3);
   delete_objects(4);
   delete_objects(5);
   delete_objects(6);
   delete_objects(7);
   
   return(0);
}

int start()
{
   int counted_bars = IndicatorCounted();

   if(counted_bars < 0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars > 0) counted_bars--;

   run_statistics_longs(1);  
   run_statistics_shorts(1); 
   draw_objects(1,PairsNames1);

   run_statistics_longs(2);  
   run_statistics_shorts(2); 
   draw_objects(2, PairsNames2);

   run_statistics_longs(3);  
   run_statistics_shorts(3); 
   draw_objects(3, PairsNames3);

   run_statistics_longs(4);  
   run_statistics_shorts(4); 
   draw_objects(4, PairsNames4);

   run_statistics_longs(5);  
   run_statistics_shorts(5); 
   draw_objects(5, PairsNames5);

   run_statistics_longs(6);  
   run_statistics_shorts(6); 
   draw_objects(6, PairsNames6);

   run_statistics_longs(7);  
   run_statistics_shorts(7); 
   draw_objects(7, PairsNames7);

return(0);
}


void run_statistics_longs(int week_back)
{

bool i_Open = false;

int tf=0;
int bars_back = 0;

GBPUSDm =0; EURGBPm =0; GBPJPYm=0; USDCHFm=0; NZDUSDm=0; AUDJPYm=0; EURJPYm=0;

GBPUSDm_now =0; EURGBPm_now = 0; GBPJPYm_now =0; USDCHFm_now =0; NZDUSDm_now = 0; AUDJPYm_now=0;EURJPYm_now=0;

GBPUSDm_pips = 0; EURGBPm_pips=0; GBPJPYm_pips = 0; USDCHFm_pips =0; NZDUSDm_pips=0;
AUDJPYm_pips = 0; EURJPYm_pips=0;


long_pips = 0;

 
 if (week_back==1)  // beginning of last month
 {
     tf = PERIOD_MN1;
     bars_back = 2;
     i_Open = true;
 }    
 else if (week_back==2) // beginning of last 2 weeks
 {
     tf = PERIOD_W1;
     bars_back = 3;
     i_Open = true;
 }    
 else if (week_back==3) // beginning of last week
 {
     tf = PERIOD_W1;
     bars_back = 2;
     i_Open = true;
    
 }    
 else if (week_back==4) // this week
 {
     tf = PERIOD_W1;
     bars_back = 1;
     i_Open = true;
 }    
 else if (week_back==5) // this day
 {
     tf = PERIOD_D1;
     bars_back = 1;
     i_Open = true;
 }
else if (week_back==6) // this 4 hours
 {
     tf = PERIOD_H4;
     bars_back = 1;
     i_Open = true;
 }
else if (week_back==7) // this hour
 {
     tf = PERIOD_H1;
     bars_back = 1;
     i_Open = true;
 }
 
  
if (StringLen(Buy_pair_1)>0)
{
   GBPUSDm      = iClose(Buy_pair_1, tf, bars_back);
   GBPUSDm_now  = iOpen(Buy_pair_1, PERIOD_M1, 0);
   GBPUSDm_pips = (GBPUSDm_now-GBPUSDm)/dPoint(Buy_pair_1);
}



if (StringLen(Buy_pair_2)>0)
{
   EURGBPm= iClose(Buy_pair_2, tf, bars_back);
   EURGBPm_now= iOpen(Buy_pair_2, PERIOD_M1, 0);
   EURGBPm_pips = (EURGBPm_now-EURGBPm)/dPoint(Buy_pair_2);

}

if (StringLen(Buy_pair_3)>0)
{
   GBPJPYm= iClose(Buy_pair_3, tf, bars_back);
   GBPJPYm_now= iOpen(Buy_pair_3, PERIOD_M1, 0);
   GBPJPYm_pips = (GBPJPYm_now-GBPJPYm)/dPoint(Buy_pair_3);
   
   //Print (GBPJPYm,GBPJPYm_now, GBPJPYm_pips);
}

if (StringLen(Buy_pair_4)>0)
{
   USDCHFm= iClose(Buy_pair_4, tf, bars_back);
   USDCHFm_now= iOpen(Buy_pair_4, PERIOD_M1, 0);
   USDCHFm_pips = (USDCHFm_now-USDCHFm)/dPoint(Buy_pair_4);
}

if (StringLen(Buy_pair_5)>0)
{
   NZDUSDm= iClose(Buy_pair_5, tf, bars_back);
   NZDUSDm_now= iOpen(Buy_pair_5, PERIOD_M1, 0);
   NZDUSDm_pips = (NZDUSDm_now-NZDUSDm)/dPoint(Buy_pair_5);
}

if (StringLen(Buy_pair_6)>0)
{
   AUDJPYm= iClose(Buy_pair_6, tf, bars_back);
   AUDJPYm_now= iOpen(Buy_pair_6, PERIOD_M1, 0);
   AUDJPYm_pips = (AUDJPYm_now-AUDJPYm)/dPoint(Buy_pair_6);

}

if (StringLen(Buy_pair_7)>0)
{
   EURJPYm= iClose(Buy_pair_7, tf, bars_back);
   EURJPYm_now= iOpen(Buy_pair_7, PERIOD_M1, 0);
   EURJPYm_pips = (EURJPYm_now-EURJPYm)/dPoint(Buy_pair_7);
}


   long_pips = GBPUSDm_pips + EURGBPm_pips + GBPJPYm_pips + USDCHFm_pips + 
                  NZDUSDm_pips + AUDJPYm_pips + EURJPYm_pips;
  
   //Print ("long pips"+long_pips);
   return;
}


void run_statistics_shorts(int week_back)
{

bool i_Open = false;

int tf=0;
int bars_back = 0;


EURUSDm=0; USDJPYm=0; AUDUSDm=0; NZDJPYm=0; GBPCHFm=0; CHFJPYm=0; EURCHFm=0;
EURUSDm_now=0;USDJPYm_now=0;AUDUSDm_now=0;NZDJPYm_now=0;GBPCHFm_now=0;CHFJPYm_now=0;EURCHFm_now=0;

EURUSDm_pips=0; USDJPYm_pips=0;AUDUSDm_pips=0;NZDJPYm_pips=0; GBPCHFm_pips=0;
CHFJPYm_pips=0;EURCHFm_pips=0;

short_pips=0;
 
 if (week_back==1)  // beginning of last month
 {
     tf = PERIOD_MN1;
     bars_back = 2;
     i_Open = true;
 }    
 else if (week_back==2) // beginning of last 2 weeks
 {
     tf = PERIOD_W1;
     bars_back = 3;
     i_Open = true;
 }    
 else if (week_back==3) // beginning of last week
 {
     tf = PERIOD_W1;
     bars_back = 2;
     i_Open = true;
    
 }    
 else if (week_back==4) // this week
 {
     tf = PERIOD_W1;
     bars_back = 1;
     i_Open = true;
 }    
 else if (week_back==5) // this day
 {
     tf = PERIOD_D1;
     bars_back = 1;
     i_Open = true;
 }
else if (week_back==6) // this 4 hours
 {
     tf = PERIOD_H4;
     bars_back = 1;
     i_Open = true;
 }
else if (week_back==7) // this hour
 {
     tf = PERIOD_H1;
     bars_back = 1;
     i_Open = true;
 }
 

if (StringLen(Sell_pair_1)>0)
{
   EURUSDm      = iClose(Sell_pair_1, tf, bars_back);
   EURUSDm_now  = iOpen(Sell_pair_1, PERIOD_M1, 0);
   EURUSDm_pips = (EURUSDm-EURUSDm_now)/dPoint(Sell_pair_1);
}


if (StringLen(Sell_pair_2)>0)
{
   USDJPYm= iClose(Sell_pair_2, tf, bars_back);
   USDJPYm_now= iOpen(Sell_pair_2, PERIOD_M1, 0);
   USDJPYm_pips = (USDJPYm-USDJPYm_now)/dPoint(Sell_pair_2);

}

if (StringLen(Sell_pair_3)>0)
{
   AUDUSDm= iClose(Sell_pair_3, tf, bars_back);
   AUDUSDm_now= iOpen(Sell_pair_3, PERIOD_M1, 0);
   AUDUSDm_pips = (AUDUSDm-AUDUSDm_now)/dPoint(Sell_pair_3);
}

if (StringLen(Sell_pair_4)>0)
{
   NZDJPYm= iClose(Sell_pair_4, tf, bars_back);
   NZDJPYm_now= iOpen(Sell_pair_4, PERIOD_M1, 0);
   NZDJPYm_pips = (NZDJPYm-NZDJPYm_now)/dPoint(Sell_pair_4);
}

if (StringLen(Sell_pair_5)>0)
{
   GBPCHFm= iClose(Sell_pair_5, tf, bars_back);
   GBPCHFm_now= iOpen(Sell_pair_5, PERIOD_M1, 0);
   GBPCHFm_pips = (GBPCHFm-GBPCHFm_now)/dPoint(Sell_pair_5);
}

if (StringLen(Sell_pair_6)>0)
{
   CHFJPYm= iClose(Sell_pair_6, tf, bars_back);
   CHFJPYm_now= iOpen(Sell_pair_6, PERIOD_M1, 0);
   CHFJPYm_pips = (CHFJPYm-CHFJPYm_now)/dPoint(Sell_pair_6);

}

if (StringLen(Sell_pair_7)>0)
{
   EURCHFm= iClose(Sell_pair_7, tf, bars_back);
   EURCHFm_now= iOpen(Sell_pair_7, PERIOD_M1, 0);
   EURCHFm_pips = (EURCHFm-EURCHFm_now)/dPoint(Sell_pair_7);
}
   short_pips = EURUSDm_pips + USDJPYm_pips + AUDUSDm_pips + NZDJPYm_pips +
                   GBPCHFm_pips + CHFJPYm_pips + EURCHFm_pips;

   //Print ("short pips"+short_pips);

   return;
}


void draw_objects(int week_back, string& PairsNames[])
{

int x_coord;
string loc_date;

 if (week_back==1)
     {x_coord = 5;  loc_date="Month";}
 else if (week_back==2)
     {x_coord = 145; loc_date="Last 2 weeks";}
 else if (week_back==3)
     {x_coord = 285; loc_date="Last Week";}
 else if (week_back==4)
     {x_coord = 425; loc_date="This Week";}
 else if (week_back==5)
     {x_coord = 565; loc_date="Day";}
 else if (week_back==6)
     {x_coord = 705; loc_date="4 hours";}
 else if (week_back==7)
     {x_coord = 845; loc_date="Last Hour";}

int companion =WindowFind(short_name);
if (companion == -1)companion=0;

blue=0; red=0;                                                                                  

   string PairsDisplay[14];   

   string PairsSearch[14];   
   
   color  PairsColor[14];              
   double PLArray[14];

   bool ShowDirections[14];

   //if (StringLen(PairsNames[0])>0)
  // {
      for(int m=0;m<=13;m++)
      { 
         PairsSearch[m] = PairsNames[m];   
      }
  // }

   PLArray[0]=GBPUSDm_pips;
   PLArray[1]=EURGBPm_pips;
   PLArray[2]=GBPJPYm_pips;
   PLArray[3]=USDCHFm_pips;
   PLArray[4]=NZDUSDm_pips;
   PLArray[5]=AUDJPYm_pips;
   PLArray[6]=EURJPYm_pips;
   
   PLArray[7]=  EURUSDm_pips;
   PLArray[8]=  USDJPYm_pips;
   PLArray[9]=  AUDUSDm_pips;
   PLArray[10]= NZDJPYm_pips;
   PLArray[11]= GBPCHFm_pips;
   PLArray[12]= CHFJPYm_pips;
   PLArray[13]= EURCHFm_pips;

   PairsNames[0]=Buy_pair_1;
   PairsNames[1]=Buy_pair_2;
   PairsNames[2]=Buy_pair_3;
   PairsNames[3]=Buy_pair_4;
   PairsNames[4]=Buy_pair_5;
   PairsNames[5]=Buy_pair_6;
   PairsNames[6]=Buy_pair_7;

   PairsNames[7]=Sell_pair_1;
   PairsNames[8]=Sell_pair_2;
   PairsNames[9]=Sell_pair_3;
   PairsNames[10]=Sell_pair_4;
   PairsNames[11]=Sell_pair_5;
   PairsNames[12]=Sell_pair_6;
   PairsNames[13]=Sell_pair_7;

   ShowDirections[0] = Show_buy_direction_1;    
   ShowDirections[1] = Show_buy_direction_2;    
   ShowDirections[2] = Show_buy_direction_3;    
   ShowDirections[3] = Show_buy_direction_4;    
   ShowDirections[4] = Show_buy_direction_5;    
   ShowDirections[5] = Show_buy_direction_6;    
   ShowDirections[6] = Show_buy_direction_7;    

   ShowDirections[7] = Show_sell_direction_1;    
   ShowDirections[8] = Show_sell_direction_2;    
   ShowDirections[9] = Show_sell_direction_3;    
   ShowDirections[10] = Show_sell_direction_4;    
   ShowDirections[11] = Show_sell_direction_5;    
   ShowDirections[12] = Show_sell_direction_6;    
   ShowDirections[13] = Show_sell_direction_7;    

   PairsColor[0] = Green;
   PairsColor[1] = Green;
   PairsColor[2] = Green;
   PairsColor[3] = Green;
   PairsColor[4] = Green;
   PairsColor[5] = Green;
   PairsColor[6] = Green;

   PairsColor[7] = Red;
   PairsColor[8] = Red;
   PairsColor[9] = Red;
   PairsColor[10]= Red;
   PairsColor[11]= Red;
   PairsColor[12]= Red;
   PairsColor[13]= Red;

   // ArraySort(PLArray,WHOLE_ARRAY,0,MODE_DESCEND); - doesn't work here

   // custom sorting function
   
   int plarr_size = ArraySize(PLArray);
   
   double temp_var;
   string temp_str;
   color temp_color;
   bool temp_direction;
   
   for(int i=0;i < plarr_size;i++) //Hold the first element
	{
		for(int j=i+1;j<plarr_size;j++) //Hold the next element from the first element
		{
			if(PLArray[i] < PLArray[j])	//comparing first and next element
			{
				temp_var = PLArray[j];	
				PLArray[j] = PLArray[i];
				PLArray[i] = temp_var;
				
				temp_str = PairsNames[j];	
				PairsNames[j] = PairsNames[i];
				PairsNames[i] = temp_str;

				temp_color  = PairsColor[j];	
				PairsColor[j] = PairsColor[i];
				PairsColor[i] = temp_color;

				temp_direction  = ShowDirections[j];	
				ShowDirections[j] = ShowDirections[i];
				ShowDirections[i] = temp_direction;
			}
		}
	}
   
   for(i=0;i<=13;i++)
    { 
      if(PairsColor[i] == Green) 
       {
         PairsDisplay[i] = ""+PairsNames[i]; // Buy
         blue = blue + PLArray[i];
       }
       
      if(PairsColor[i] == Red) 
       {
         PairsDisplay[i] = ""+PairsNames[i]; // Sell
         red = red + PLArray[i];
       }
       
      //Print(PairsDisplay[i],"...",i,"..",PairsColor[i]);
    }

    // Print(red,"...",blue);    

if (ObjectFind(week_back+"sig_tit") == -1 ){
   ObjectCreate(week_back+"sig_tit", OBJ_LABEL, companion, 0, 0);
   ObjectSet(week_back+"sig_tit", OBJPROP_COLOR, Red);
   ObjectSet(week_back+"sig_tit", OBJPROP_XDISTANCE, x_coord);
   ObjectSet(week_back+"sig_tit", OBJPROP_YDISTANCE, 15);
   
   ObjectSetText(week_back+"sig_tit",loc_date,10,"Courier New",White);
}

int y_coord = 40;

if (StringLen(PairsDisplay[0])>0) //StringLen(StringTrimLeft(StringSubstr(PairsDisplay[0],4)))>0
{
   if (ObjectFind("W"+week_back+"00") == -1 ){
      ObjectCreate("W"+week_back+"00", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"00", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"00", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"00", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"00",PairsDisplay[0]+"  "+DoubleToStr(PLArray[0],0), 9,
                     "Lucida Console Bold",PairsColor[0]);

      if (ShowDirections[0])
         draw_rating(0,week_back,PairsSearch,PairsDisplay[0], x_coord, y_coord, companion);

      y_coord = y_coord + 20;
}


if (StringLen(PairsDisplay[1])>0)
{
   if (ObjectFind("W"+week_back+"01") == -1 ){
      ObjectCreate("W"+week_back+"01", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"01", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"01", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"01", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"01",PairsDisplay[1]+"  "+DoubleToStr(PLArray[1],0), 9,
         "Lucida Console Bold",PairsColor[1]);

       if (ShowDirections[1])
         draw_rating(1,week_back,PairsSearch,PairsDisplay[1], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[2])>0)
{
   if (ObjectFind("W"+week_back+"02") == -1 ){
      ObjectCreate("W"+week_back+"02", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"02", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"02", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"02", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"02",PairsDisplay[2]+"  "+DoubleToStr(PLArray[2],0), 9,
      "Lucida Console Bold",PairsColor[2]);

       if (ShowDirections[2])
         draw_rating(2,week_back,PairsSearch,PairsDisplay[2], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;

}

if (StringLen(PairsDisplay[3])>0)
{
   if (ObjectFind("W"+week_back+"03") == -1 ){
      ObjectCreate("W"+week_back+"03", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"03", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"03", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"03", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"03",PairsDisplay[3]+"  "+DoubleToStr(PLArray[3],0), 9,
       "Lucida Console Bold",PairsColor[3]);

      if (ShowDirections[3])
         draw_rating(3,week_back,PairsSearch,PairsDisplay[3], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[4])>0)
{
   if (ObjectFind("W"+week_back+"04") == -1 ){
      ObjectCreate("W"+week_back+"04", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"04", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"04", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"04", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"04",PairsDisplay[4]+"  "+DoubleToStr(PLArray[4],0), 9,
      "Lucida Console Bold",PairsColor[4]);

      if (ShowDirections[4])
         draw_rating(4,week_back,PairsSearch,PairsDisplay[4], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[5])>0)
{
   if (ObjectFind("W"+week_back+"05") == -1 ){
      ObjectCreate("W"+week_back+"05", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"05", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"05", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"05", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"05",PairsDisplay[5]+"  "+DoubleToStr(PLArray[5],0), 9,
      "Lucida Console Bold",PairsColor[5]);

      if (ShowDirections[5])
        draw_rating(5,week_back,PairsSearch,PairsDisplay[5], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[6])>0)
{
   if (ObjectFind("W"+week_back+"06") == -1 ){
      ObjectCreate("W"+week_back+"06", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"06", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"06", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"06", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"06",PairsDisplay[6]+"  "+DoubleToStr(PLArray[6],0), 9,
      "Lucida Console Bold",PairsColor[6]);

      if (ShowDirections[6])
         draw_rating(6,week_back,PairsSearch,PairsDisplay[6], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (ObjectFind(week_back+"lin_med") == -1 ){
    ObjectCreate(week_back+"lin_med",OBJ_LABEL,companion,0, 0);
    ObjectSet(week_back+"lin_med",OBJPROP_COLOR,White);
    ObjectSet(week_back+"lin_med", OBJPROP_XDISTANCE, x_coord);
    ObjectSet(week_back+"lin_med", OBJPROP_YDISTANCE, y_coord-10);
    ObjectSetText(week_back+"lin_med","--------------", 10,
         "Courier New",Yellow);
}

if (StringLen(PairsDisplay[7])>0)
{
   if (ObjectFind("W"+week_back+"07") == -1 ){
      ObjectCreate("W"+week_back+"07", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"07", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"07", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"07", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"07",PairsDisplay[7]+"  "+DoubleToStr(PLArray[7],0), 9,
      "Lucida Console Bold",PairsColor[7]);

      if (ShowDirections[7])
         draw_rating(7,week_back,PairsSearch,PairsDisplay[7], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;

}

if (StringLen(PairsDisplay[8])>0)
{
   if (ObjectFind("W"+week_back+"08") == -1 ){
      ObjectCreate("W"+week_back+"08", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"08", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"08", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"08", OBJPROP_YDISTANCE, y_coord);
   }

   ObjectSetText("W"+week_back+"08",PairsDisplay[8]+"  "+DoubleToStr(PLArray[8],0), 9,
      "Lucida Console Bold",PairsColor[8]);


     if (ShowDirections[8])
       draw_rating(8,week_back,PairsSearch,PairsDisplay[8], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[9])>0)
{
   if (ObjectFind("W"+week_back+"09") == -1 ){
      ObjectCreate("W"+week_back+"09", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"09", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"09", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"09", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"09",PairsDisplay[9]+"  "+DoubleToStr(PLArray[9],0), 9,
      "Lucida Console Bold",PairsColor[9]);

      if (ShowDirections[9])
         draw_rating(9,week_back,PairsSearch,PairsDisplay[9], x_coord, y_coord, companion);
         
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[10])>0)
{
   if (ObjectFind("W"+week_back+"10") == -1 ){
      ObjectCreate("W"+week_back+"10", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"10", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"10", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"10", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"10",PairsDisplay[10]+"  "+DoubleToStr(PLArray[10],0), 9,
      "Lucida Console Bold",PairsColor[10]);

      if (ShowDirections[10])
         draw_rating(10,week_back,PairsSearch,PairsDisplay[10], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[11])>0)
{
   if (ObjectFind("W"+week_back+"11") == -1 ){
      ObjectCreate("W"+week_back+"11", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"11", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"11", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"11", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"11",PairsDisplay[11]+"  "+DoubleToStr(PLArray[11],0), 9,
      "Lucida Console Bold",PairsColor[11]);


      if (ShowDirections[11])
         draw_rating(11,week_back,PairsSearch,PairsDisplay[11], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[12])>0)
{
   if (ObjectFind("W"+week_back+"12") == -1 ){
      ObjectCreate("W"+week_back+"12", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"12", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"12", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"12", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"12",PairsDisplay[12]+"  "+DoubleToStr(PLArray[12],0), 9,
         "Lucida Console Bold",PairsColor[12]);

      if (ShowDirections[12])
         draw_rating(12,week_back,PairsSearch,PairsDisplay[12], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (StringLen(PairsDisplay[13])>0)
{
   if (ObjectFind("W"+week_back+"13") == -1 ){
      ObjectCreate("W"+week_back+"13", OBJ_LABEL, companion, 0, 0);
      ObjectSet("W"+week_back+"13", OBJPROP_COLOR, Red);
      ObjectSet("W"+week_back+"13", OBJPROP_XDISTANCE, x_coord);
      ObjectSet("W"+week_back+"13", OBJPROP_YDISTANCE, y_coord);
   }

      ObjectSetText("W"+week_back+"13",PairsDisplay[13]+"  "+DoubleToStr(PLArray[13],0), 9,
         "Lucida Console Bold",PairsColor[13]);

      if (ShowDirections[13])
         draw_rating(13,week_back,PairsSearch,PairsDisplay[13], x_coord, y_coord, companion);
      
      y_coord = y_coord + 20;
}

if (ObjectFind(week_back+"lin") == -1 ){
    ObjectCreate(week_back+"lin",OBJ_LABEL,companion,0, 0);
    ObjectSet(week_back+"lin",OBJPROP_COLOR,White);
    ObjectSet(week_back+"lin", OBJPROP_XDISTANCE, x_coord);
    ObjectSet(week_back+"lin", OBJPROP_YDISTANCE, y_coord);
    ObjectSetText(week_back+"lin","--------------", 10,
         "Courier New",White);
    y_coord = y_coord+20;
}

if (ObjectFind(week_back+"b_tot") == -1 ){
   ObjectCreate(week_back+"b_tot", OBJ_LABEL, companion, 0, 0);
   ObjectSet(week_back+"b_tot", OBJPROP_COLOR, SpringGreen);
   ObjectSet(week_back+"b_tot", OBJPROP_XDISTANCE, x_coord);
   ObjectSet(week_back+"b_tot", OBJPROP_YDISTANCE, y_coord);
}

   ObjectSetText(week_back+"b_tot",DoubleToStr(blue,0), 9,
         "Courier New",SpringGreen);

if (ObjectFind(week_back+"s_tot") == -1 ){
   ObjectCreate(week_back+"s_tot", OBJ_LABEL, companion, 0, 0);
   ObjectSet(week_back+"s_tot", OBJPROP_COLOR, OrangeRed);
   ObjectSet(week_back+"s_tot", OBJPROP_XDISTANCE, x_coord + 45);
   ObjectSet(week_back+"s_tot", OBJPROP_YDISTANCE, y_coord);
}

   ObjectSetText(week_back+"s_tot",DoubleToStr(red,0), 9,
         "Courier New",OrangeRed);

if (ObjectFind(week_back+"tot") == -1 ){
   ObjectCreate(week_back+"tot", OBJ_LABEL, companion, 0, 0);
   ObjectSet(week_back+"tot", OBJPROP_COLOR, Yellow);
   ObjectSet(week_back+"tot", OBJPROP_XDISTANCE, x_coord + 80);
   ObjectSet(week_back+"tot", OBJPROP_YDISTANCE, y_coord);
}

   ObjectSetText(week_back+"tot","T:"+DoubleToStr(red+blue,0), 9,
         "Courier New",Yellow);
   y_coord = y_coord +20;         



if (ObjectFind(week_back+"sig") == -1 ){
   ObjectCreate(week_back+"sig", OBJ_LABEL, companion, 0, 0);
   ObjectSet(week_back+"sig", OBJPROP_COLOR, Red);
   ObjectSet(week_back+"sig", OBJPROP_XDISTANCE, x_coord);
   ObjectSet(week_back+"sig", OBJPROP_YDISTANCE, y_coord);
}

  string trend = "NONE";
   color col = White;
   
   if (red > 0 && blue < 0)
      {trend = "SHORT (Strong)"; col = Red;}
   else if (red > blue && (red > 0 && blue > 0))
      {trend = "SHORT (Weak)"; col = Orange;}
   else if (blue > 0 && red < 0)
      {trend = "LONG (Strong)"; col = Blue;}
   else if (blue > red && (blue > 0 && red > 0))
      {trend = "LONG (Weak)"; col = DeepSkyBlue;}



   ObjectSetText(week_back+"sig",trend, 12,"Lucida Console Bold",col);

    WindowRedraw();
   
}


void delete_objects(int week_back)
{
  for(int m=0;m<=13;m++)
  { 
   if (ObjectFind("WA"+week_back+PairsNames1[m]) > -1 ){
      ObjectDelete("WA"+week_back+PairsNames1[m]);
   }

   if (ObjectFind("W"+week_back+PairsNames1[m]) > -1 ){
      ObjectDelete("W"+week_back+PairsNames1[m]);
   }
  }
  
if (ObjectFind(week_back+"b_tot") > -1 ){
   ObjectDelete(week_back+"b_tot");
}

if (ObjectFind(week_back+"tot") > -1 ){
   ObjectDelete(week_back+"tot");
}

if (ObjectFind(week_back+"s_tot") > -1 ){
   ObjectDelete(week_back+"s_tot");
}

if (ObjectFind(week_back+"lin") > -1 ){
   ObjectDelete(week_back+"lin");
}

if (ObjectFind(week_back+"lin_med") > -1 ){
   ObjectDelete(week_back+"lin_med");
}

if (ObjectFind(week_back+"sig_tit") > -1 ){
   ObjectDelete(week_back+"sig_tit");
}

if (ObjectFind("W"+week_back+"00") > -1 ){
   ObjectDelete("W"+week_back+"00");
}

if (ObjectFind("W"+week_back+"01") > -1 ){
   ObjectDelete("W"+week_back+"01");
}

if (ObjectFind("W"+week_back+"02") > -1 ){
   ObjectDelete("W"+week_back+"02");
}

if (ObjectFind("W"+week_back+"03") > -1 ){
   ObjectDelete("W"+week_back+"03");
}


if (ObjectFind("W"+week_back+"04") > -1 ){
   ObjectDelete("W"+week_back+"04");
}

if (ObjectFind("W"+week_back+"05") > -1 ){
   ObjectDelete("W"+week_back+"05");
}

if (ObjectFind("W"+week_back+"06") > -1 ){
   ObjectDelete("W"+week_back+"06");
}

if (ObjectFind("W"+week_back+"07") > -1 ){
   ObjectDelete("W"+week_back+"07");
}

if (ObjectFind("W"+week_back+"08") > -1 ){
   ObjectDelete("W"+week_back+"08");
}

if (ObjectFind("W"+week_back+"09") > -1 ){
   ObjectDelete("W"+week_back+"09");
}

if (ObjectFind("W"+week_back+"10") > -1 ){
   ObjectDelete("W"+week_back+"10");
}

if (ObjectFind("W"+week_back+"11") > -1 ){
   ObjectDelete("W"+week_back+"11");
}

if (ObjectFind("W"+week_back+"12") > -1 ){
   ObjectDelete("W"+week_back+"12");
}

if (ObjectFind("W"+week_back+"13") > -1 ){
   ObjectDelete("W"+week_back+"13");
}

if (ObjectFind(week_back+"sig") > -1 ){
   ObjectDelete(week_back+"sig");
}

}

double dPoint(string sym)
{
  int _Digits = MarketInfo(sym, MODE_DIGITS);
  if(_Digits == 0) _Digits = 4;
  double _Point = MarketInfo(sym, MODE_POINT);
  if(NormalizeDouble(_Point, _Digits) == 0.0) _Point = Point;
  return (_Point);
}

int ArraySearch(string& m[], string e) {
  for (int i=0; i<ArraySize(m); i++) {
    if (m[i]==e) return(i);
  }
  return(-1);
}

void draw_rating(int i_index, int week_back, string& PairsSearch[], string pair_display, int x_coord, int y_coord,
                 int companion)
{
      int result = ArraySearch(PairsSearch,pair_display);

      //Print (result); 

      if (result!=-1 && result!=i_index)
      {

         if (ObjectFind("W"+week_back+pair_display) != -1 )
         {
            ObjectDelete("W"+week_back+pair_display);
         }
         
         if (ObjectFind("WA"+week_back+pair_display) != -1 )
         {
            ObjectDelete("WA"+week_back+pair_display);         
         }

            ObjectCreate("W"+week_back+pair_display, OBJ_LABEL, companion, 0, 0);
            ObjectSet("W"+week_back+pair_display, OBJPROP_COLOR, White);
            ObjectSet("W"+week_back+pair_display, OBJPROP_XDISTANCE, x_coord + 95); // 75
            ObjectSet("W"+week_back+pair_display, OBJPROP_YDISTANCE, y_coord);
 
            ObjectSetText("W"+week_back+pair_display,DoubleToStr(result+1,0), 9,"Courier New",White);
 
            ObjectCreate("WA"+week_back+pair_display, OBJ_LABEL, companion, 0, 0); 
            ObjectSet("WA"+week_back+pair_display, OBJPROP_XDISTANCE, x_coord + 110); //110
            ObjectSet("WA"+week_back+pair_display, OBJPROP_YDISTANCE, y_coord);
     
            if (result > i_index) // went up
            {
               ObjectSetText("WA"+week_back+pair_display,"r", 9,"Wingdings 3",Green);
            }
            else if (result < i_index) // went down
            {
               ObjectSetText("WA"+week_back+pair_display,"s", 9,"Wingdings 3",Red);
            }
            else
            {
               ObjectSetText("WA"+week_back+pair_display,"Q", 9,"Wingdings 3",Yellow);
            }
      }
      return;
}