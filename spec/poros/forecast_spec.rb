require 'rails_helper'

RSpec.describe Forecast do
  before :each do
    data = {:lat=>39.7385,
      :lon=>-104.9849,
      :timezone=>"America/Denver",
      :timezone_offset=>-21600,
      :current=>
       {:dt=>1623812766,
        :sunrise=>1623756687,
        :sunset=>1623810579,
        :temp=>82.17,
        :feels_like=>81.16,
        :pressure=>1010,
        :humidity=>36,
        :dew_point=>52.59,
        :uvi=>0,
        :clouds=>91,
        :visibility=>10000,
        :wind_speed=>1.01,
        :wind_deg=>342,
        :wind_gust=>1.01,
        :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}]},
      :hourly=>
       [{:dt=>1623812400, :temp=>82.17, :feels_like=>81.16, :pressure=>1010, :humidity=>36, :dew_point=>52.59, :uvi=>0, :clouds=>91, :visibility=>10000, :wind_speed=>12.71, :wind_deg=>163, :wind_gust=>16.73, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623816000, :temp=>82.06, :feels_like=>80.87, :pressure=>1010, :humidity=>34, :dew_point=>50.94, :uvi=>0, :clouds=>87, :visibility=>10000, :wind_speed=>8.12, :wind_deg=>190, :wind_gust=>11.63, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623819600, :temp=>81.88, :feels_like=>80.56, :pressure=>1011, :humidity=>32, :dew_point=>49.15, :uvi=>0, :clouds=>77, :visibility=>10000, :wind_speed=>5.88, :wind_deg=>206, :wind_gust=>10.11, :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623823200, :temp=>80.96, :feels_like=>79.65, :pressure=>1012, :humidity=>28, :dew_point=>44.83, :uvi=>0, :clouds=>65, :visibility=>10000, :wind_speed=>6.35, :wind_deg=>202, :wind_gust=>10.31, :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623826800, :temp=>79.2, :feels_like=>79.2, :pressure=>1012, :humidity=>27, :dew_point=>42.37, :uvi=>0, :clouds=>22, :visibility=>10000, :wind_speed=>6.53, :wind_deg=>206, :wind_gust=>10.65, :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02n"}], :pop=>0},
        {:dt=>1623830400, :temp=>77.23, :feels_like=>75.88, :pressure=>1013, :humidity=>26, :dew_point=>39.34, :uvi=>0, :clouds=>28, :visibility=>10000, :wind_speed=>7.29, :wind_deg=>205, :wind_gust=>12.44, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}], :pop=>0},
        {:dt=>1623834000, :temp=>76.41, :feels_like=>75.06, :pressure=>1013, :humidity=>28, :dew_point=>40.51, :uvi=>0, :clouds=>47, :visibility=>10000, :wind_speed=>7, :wind_deg=>220, :wind_gust=>13.53, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}], :pop=>0},
        {:dt=>1623837600, :temp=>75.54, :feels_like=>74.16, :pressure=>1013, :humidity=>29, :dew_point=>40.44, :uvi=>0, :clouds=>40, :visibility=>10000, :wind_speed=>5.88, :wind_deg=>216, :wind_gust=>9.75, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}], :pop=>0},
        {:dt=>1623841200, :temp=>74.84, :feels_like=>73.35, :pressure=>1013, :humidity=>28, :dew_point=>39.38, :uvi=>0, :clouds=>36, :visibility=>10000, :wind_speed=>4.76, :wind_deg=>214, :wind_gust=>5.61, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}], :pop=>0},
        {:dt=>1623844800, :temp=>74.3, :feels_like=>72.75, :pressure=>1013, :humidity=>28, :dew_point=>38.64, :uvi=>0, :clouds=>33, :visibility=>10000, :wind_speed=>2.28, :wind_deg=>197, :wind_gust=>2.57, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}], :pop=>0},
        {:dt=>1623848400, :temp=>77.02, :feels_like=>75.65, :pressure=>1014, :humidity=>26, :dew_point=>38.77, :uvi=>0.53, :clouds=>18, :visibility=>10000, :wind_speed=>1.12, :wind_deg=>227, :wind_gust=>1.7, :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}], :pop=>0},
        {:dt=>1623852000, :temp=>81.34, :feels_like=>79.47, :pressure=>1014, :humidity=>21, :dew_point=>37.56, :uvi=>1.65, :clouds=>14, :visibility=>10000, :wind_speed=>0.54, :wind_deg=>147, :wind_gust=>0.81, :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}], :pop=>0},
        {:dt=>1623855600, :temp=>85.75, :feels_like=>82.51, :pressure=>1014, :humidity=>17, :dew_point=>36, :uvi=>3.6, :clouds=>19, :visibility=>10000, :wind_speed=>0.92, :wind_deg=>156, :wind_gust=>0.72, :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}], :pop=>0},
        {:dt=>1623859200, :temp=>90.55, :feels_like=>86.41, :pressure=>1013, :humidity=>14, :dew_point=>34.14, :uvi=>5.9, :clouds=>18, :visibility=>10000, :wind_speed=>2.17, :wind_deg=>139, :wind_gust=>2.35, :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}], :pop=>0},
        {:dt=>1623862800, :temp=>95.07, :feels_like=>90.27, :pressure=>1012, :humidity=>10, :dew_point=>30.04, :uvi=>8.37, :clouds=>27, :visibility=>10000, :wind_speed=>4.61, :wind_deg=>95, :wind_gust=>6.13, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}], :pop=>0},
        {:dt=>1623866400, :temp=>97.83, :feels_like=>92.57, :pressure=>1011, :humidity=>8, :dew_point=>26.67, :uvi=>10.21, :clouds=>30, :visibility=>10000, :wind_speed=>9.22, :wind_deg=>59, :wind_gust=>9.4, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}], :pop=>0},
        {:dt=>1623870000, :temp=>98.28, :feels_like=>93.04, :pressure=>1010, :humidity=>9, :dew_point=>29.48, :uvi=>8.2, :clouds=>100, :visibility=>10000, :wind_speed=>13.73, :wind_deg=>58, :wind_gust=>11.95, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.08},
        {:dt=>1623873600, :temp=>97.5, :feels_like=>92.55, :pressure=>1011, :humidity=>11, :dew_point=>33.53, :uvi=>7.69, :clouds=>100, :visibility=>10000, :wind_speed=>18.57, :wind_deg=>4, :wind_gust=>12.59, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623877200, :temp=>93.92, :feels_like=>89.33, :pressure=>1011, :humidity=>12, :dew_point=>34.41, :uvi=>6.31, :clouds=>100, :visibility=>10000, :wind_speed=>16.64, :wind_deg=>5, :wind_gust=>17.05, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623880800, :temp=>94.28, :feels_like=>89.67, :pressure=>1011, :humidity=>12, :dew_point=>34.77, :uvi=>4, :clouds=>100, :visibility=>10000, :wind_speed=>13.8, :wind_deg=>5, :wind_gust=>10.36, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623884400, :temp=>93.51, :feels_like=>89.02, :pressure=>1011, :humidity=>13, :dew_point=>36.12, :uvi=>2.34, :clouds=>100, :visibility=>10000, :wind_speed=>9.84, :wind_deg=>5, :wind_gust=>8.23, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623888000, :temp=>84.31, :feels_like=>81.81, :pressure=>1013, :humidity=>25, :dew_point=>44.37, :uvi=>1.07, :clouds=>100, :visibility=>10000, :wind_speed=>17.83, :wind_deg=>8, :wind_gust=>24.27, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623891600, :temp=>82.94, :feels_like=>80.92, :pressure=>1015, :humidity=>27, :dew_point=>45.05, :uvi=>0.48, :clouds=>97, :visibility=>10000, :wind_speed=>13.22, :wind_deg=>345, :wind_gust=>14.97, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.12},
        {:dt=>1623895200, :temp=>81.72, :feels_like=>80.08, :pressure=>1015, :humidity=>27, :dew_point=>44.17, :uvi=>0, :clouds=>98, :visibility=>10000, :wind_speed=>6.89, :wind_deg=>316, :wind_gust=>9.98, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.2},
        {:dt=>1623898800, :temp=>80.6, :feels_like=>79.41, :pressure=>1015, :humidity=>28, :dew_point=>43.59, :uvi=>0, :clouds=>94, :visibility=>10000, :wind_speed=>7.14, :wind_deg=>194, :wind_gust=>13.42, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0.2},
        {:dt=>1623902400, :temp=>78.42, :feels_like=>77.38, :pressure=>1015, :humidity=>30, :dew_point=>43.83, :uvi=>0, :clouds=>94, :visibility=>10000, :wind_speed=>7.83, :wind_deg=>193, :wind_gust=>15.08, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0.2},
        {:dt=>1623906000, :temp=>76.55, :feels_like=>75.45, :pressure=>1015, :humidity=>33, :dew_point=>44.92, :uvi=>0, :clouds=>95, :visibility=>10000, :wind_speed=>7.74, :wind_deg=>182, :wind_gust=>11.7, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0.16},
        {:dt=>1623909600, :temp=>74.86, :feels_like=>73.69, :pressure=>1015, :humidity=>35, :dew_point=>45.23, :uvi=>0, :clouds=>85, :visibility=>10000, :wind_speed=>8.95, :wind_deg=>168, :wind_gust=>13.31, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0.12},
        {:dt=>1623913200, :temp=>73.54, :feels_like=>72.34, :pressure=>1014, :humidity=>37, :dew_point=>45.3, :uvi=>0, :clouds=>98, :visibility=>10000, :wind_speed=>9.28, :wind_deg=>185, :wind_gust=>18.7, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623916800, :temp=>73.47, :feels_like=>72.21, :pressure=>1013, :humidity=>36, :dew_point=>44.65, :uvi=>0, :clouds=>93, :visibility=>10000, :wind_speed=>6.8, :wind_deg=>217, :wind_gust=>13.35, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623920400, :temp=>73.02, :feels_like=>71.67, :pressure=>1012, :humidity=>35, :dew_point=>43.59, :uvi=>0, :clouds=>96, :visibility=>10000, :wind_speed=>5.08, :wind_deg=>208, :wind_gust=>8.28, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623924000, :temp=>72.25, :feels_like=>70.83, :pressure=>1012, :humidity=>35, :dew_point=>43.11, :uvi=>0, :clouds=>97, :visibility=>10000, :wind_speed=>5.35, :wind_deg=>214, :wind_gust=>8.43, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623927600, :temp=>71.87, :feels_like=>70.36, :pressure=>1012, :humidity=>34, :dew_point=>41.95, :uvi=>0, :clouds=>94, :visibility=>10000, :wind_speed=>4.85, :wind_deg=>231, :wind_gust=>5.68, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04n"}], :pop=>0},
        {:dt=>1623931200, :temp=>72.12, :feels_like=>70.59, :pressure=>1012, :humidity=>33, :dew_point=>40.66, :uvi=>0, :clouds=>95, :visibility=>10000, :wind_speed=>3.8, :wind_deg=>238, :wind_gust=>4.25, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623934800, :temp=>74.28, :feels_like=>72.86, :pressure=>1013, :humidity=>31, :dew_point=>41.07, :uvi=>0.47, :clouds=>100, :visibility=>10000, :wind_speed=>4.21, :wind_deg=>204, :wind_gust=>5.12, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623938400, :temp=>78.17, :feels_like=>77, :pressure=>1012, :humidity=>28, :dew_point=>41.9, :uvi=>1.48, :clouds=>100, :visibility=>10000, :wind_speed=>4.9, :wind_deg=>208, :wind_gust=>6.42, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623942000, :temp=>83.59, :feels_like=>81.07, :pressure=>1011, :humidity=>22, :dew_point=>41.16, :uvi=>3.23, :clouds=>100, :visibility=>10000, :wind_speed=>4.34, :wind_deg=>204, :wind_gust=>5.39, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623945600, :temp=>88.99, :feels_like=>85.19, :pressure=>1010, :humidity=>17, :dew_point=>38.79, :uvi=>5.8, :clouds=>100, :visibility=>10000, :wind_speed=>2.39, :wind_deg=>144, :wind_gust=>1.7, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623949200, :temp=>92.43, :feels_like=>88.03, :pressure=>1010, :humidity=>13, :dew_point=>35.26, :uvi=>8.23, :clouds=>100, :visibility=>10000, :wind_speed=>5.06, :wind_deg=>96, :wind_gust=>5.08, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623952800, :temp=>95.94, :feels_like=>91.11, :pressure=>1009, :humidity=>11, :dew_point=>32.43, :uvi=>10.04, :clouds=>94, :visibility=>10000, :wind_speed=>6.96, :wind_deg=>80, :wind_gust=>6.55, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623956400, :temp=>98.06, :feels_like=>92.86, :pressure=>1008, :humidity=>9, :dew_point=>30.51, :uvi=>10.13, :clouds=>35, :visibility=>10000, :wind_speed=>9.37, :wind_deg=>89, :wind_gust=>9.6, :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}], :pop=>0},
        {:dt=>1623960000, :temp=>98.64, :feels_like=>93.36, :pressure=>1007, :humidity=>9, :dew_point=>31.15, :uvi=>9.51, :clouds=>67, :visibility=>10000, :wind_speed=>5.32, :wind_deg=>191, :wind_gust=>7.72, :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}], :pop=>0},
        {:dt=>1623963600, :temp=>90.91, :feels_like=>86.85, :pressure=>1009, :humidity=>16, :dew_point=>37.65, :uvi=>7.8, :clouds=>78, :visibility=>10000, :wind_speed=>18.68, :wind_deg=>210, :wind_gust=>14.9, :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}], :pop=>0.08},
        {:dt=>1623967200, :temp=>80.6, :feels_like=>79.48, :pressure=>1011, :humidity=>29, :dew_point=>45.32, :uvi=>3.67, :clouds=>84, :visibility=>10000, :wind_speed=>10, :wind_deg=>220, :wind_gust=>13.13, :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}], :pop=>0.36, :rain=>{:"1h"=>0.11}},
        {:dt=>1623970800, :temp=>82.8, :feels_like=>80.74, :pressure=>1011, :humidity=>26, :dew_point=>44.56, :uvi=>2.15, :clouds=>87, :visibility=>10000, :wind_speed=>5.26, :wind_deg=>245, :wind_gust=>7.99, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.12},
        {:dt=>1623974400, :temp=>85.32, :feels_like=>82.47, :pressure=>1010, :humidity=>23, :dew_point=>43.07, :uvi=>0.99, :clouds=>89, :visibility=>10000, :wind_speed=>10.07, :wind_deg=>192, :wind_gust=>15.7, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.12},
        {:dt=>1623978000, :temp=>84.33, :feels_like=>81.75, :pressure=>1010, :humidity=>24, :dew_point=>43.75, :uvi=>0.4, :clouds=>100, :visibility=>10000, :wind_speed=>17.52, :wind_deg=>211, :wind_gust=>23.71, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.2},
        {:dt=>1623981600, :temp=>81.45, :feels_like=>79.83, :pressure=>1011, :humidity=>26, :dew_point=>43.3, :uvi=>0, :clouds=>100, :visibility=>10000, :wind_speed=>12.68, :wind_deg=>225, :wind_gust=>25.17, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}], :pop=>0.2}],
      :daily=>
       [{:dt=>1623783600,
         :sunrise=>1623756687,
         :sunset=>1623810579,
         :moonrise=>1623773580,
         :moonset=>1623737100,
         :moon_phase=>0.17,
         :temp=>{:day=>97.5, :min=>72.9, :max=>100.36, :night=>81.88, :eve=>86.45, :morn=>75.27},
         :feels_like=>{:day=>92.82, :night=>80.56, :eve=>83.91, :morn=>74.05},
         :pressure=>1010,
         :humidity=>13,
         :dew_point=>38.89,
         :wind_speed=>12.71,
         :wind_deg=>163,
         :wind_gust=>16.73,
         :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
         :clouds=>0,
         :pop=>0,
         :uvi=>11.67},
        {:dt=>1623870000,
         :sunrise=>1623843090,
         :sunset=>1623897001,
         :moonrise=>1623864000,
         :moonset=>1623825420,
         :moon_phase=>0.2,
         :temp=>{:day=>98.28, :min=>74.3, :max=>98.28, :night=>76.55, :eve=>82.94, :morn=>77.02},
         :feels_like=>{:day=>93.04, :night=>75.45, :eve=>80.92, :morn=>75.65},
         :pressure=>1010,
         :humidity=>9,
         :dew_point=>29.48,
         :wind_speed=>18.57,
         :wind_deg=>4,
         :wind_gust=>24.27,
         :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}],
         :clouds=>100,
         :pop=>0.2,
         :uvi=>10.21},
        {:dt=>1623956400,
         :sunrise=>1623929495,
         :sunset=>1623983420,
         :moonrise=>1623954420,
         :moonset=>1623913620,
         :moon_phase=>0.25,
         :temp=>{:day=>98.06, :min=>71.87, :max=>98.64, :night=>77.31, :eve=>84.33, :morn=>74.28},
         :feels_like=>{:day=>92.86, :night=>76.33, :eve=>81.75, :morn=>72.86},
         :pressure=>1008,
         :humidity=>9,
         :dew_point=>30.51,
         :wind_speed=>18.68,
         :wind_deg=>210,
         :wind_gust=>25.17,
         :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
         :clouds=>35,
         :pop=>0.36,
         :rain=>0.11,
         :uvi=>10.13},
        {:dt=>1624042800,
         :sunrise=>1624015901,
         :sunset=>1624069838,
         :moonrise=>1624044900,
         :moonset=>1624001640,
         :moon_phase=>0.27,
         :temp=>{:day=>82.85, :min=>70.59, :max=>88.99, :night=>70.59, :eve=>88.83, :morn=>73.42},
         :feels_like=>{:day=>81.01, :night=>69.98, :eve=>85.24, :morn=>71.96},
         :pressure=>1013,
         :humidity=>29,
         :dew_point=>47.17,
         :wind_speed=>11.81,
         :wind_deg=>92,
         :wind_gust=>15.26,
         :weather=>[{:id=>501, :main=>"Rain", :description=>"moderate rain", :icon=>"10d"}],
         :clouds=>100,
         :pop=>1,
         :rain=>5.04,
         :uvi=>10.87},
        {:dt=>1624129200,
         :sunrise=>1624102310,
         :sunset=>1624156254,
         :moonrise=>1624135500,
         :moonset=>1624089600,
         :moon_phase=>0.31,
         :temp=>{:day=>88.72, :min=>67.51, :max=>88.72, :night=>74.84, :eve=>77.09, :morn=>67.51},
         :feels_like=>{:day=>85.24, :night=>73.9, :eve=>76.51, :morn=>66.54},
         :pressure=>1005,
         :humidity=>21,
         :dew_point=>44.26,
         :wind_speed=>18.57,
         :wind_deg=>232,
         :wind_gust=>32.7,
         :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
         :clouds=>73,
         :pop=>0.87,
         :rain=>3.26,
         :uvi=>10.08},
        {:dt=>1624215600,
         :sunrise=>1624188720,
         :sunset=>1624242668,
         :moonrise=>1624226340,
         :moonset=>1624177680,
         :moon_phase=>0.34,
         :temp=>{:day=>92.16, :min=>64.81, :max=>96.33, :night=>64.81, :eve=>93.49, :morn=>68.2},
         :feels_like=>{:day=>87.8, :night=>63.48, :eve=>89.01, :morn=>66.65},
         :pressure=>1000,
         :humidity=>13,
         :dew_point=>33.76,
         :wind_speed=>18.01,
         :wind_deg=>15,
         :wind_gust=>21.83,
         :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
         :clouds=>0,
         :pop=>0.36,
         :rain=>0.52,
         :uvi=>11},
        {:dt=>1624302000,
         :sunrise=>1624275132,
         :sunset=>1624329081,
         :moonrise=>1624317300,
         :moonset=>1624265940,
         :moon_phase=>0.38,
         :temp=>{:day=>63.66, :min=>55.36, :max=>71.98, :night=>68, :eve=>71.98, :morn=>55.36},
         :feels_like=>{:day=>61.61, :night=>66.43, :eve=>70.47, :morn=>53.1},
         :pressure=>1019,
         :humidity=>40,
         :dew_point=>38.66,
         :wind_speed=>10.94,
         :wind_deg=>136,
         :wind_gust=>13.24,
         :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}],
         :clouds=>89,
         :pop=>0,
         :uvi=>11},
        {:dt=>1624388400,
         :sunrise=>1624361545,
         :sunset=>1624415492,
         :moonrise=>1624408320,
         :moonset=>1624354500,
         :moon_phase=>0.42,
         :temp=>{:day=>85.5, :min=>59.74, :max=>92.8, :night=>80.62, :eve=>88.81, :morn=>59.74},
         :feels_like=>{:day=>82.27, :night=>79.25, :eve=>84.99, :morn=>57.99},
         :pressure=>1005,
         :humidity=>16,
         :dew_point=>35.04,
         :wind_speed=>16.58,
         :wind_deg=>79,
         :wind_gust=>15.03,
         :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
         :clouds=>0,
         :pop=>0,
         :uvi=>11}]}
    @forecast = Forecast.new(data)
  end

  describe 'city forecast poro' do
    it '#current_weather', :vcr do
      expect(@forecast.id).to eq(nil)
      expect(@forecast.current_weather).to be_a Hash

      expect(@forecast.current_weather).to have_key :datetime
      expect(@forecast.current_weather[:datetime]).to be_a Time
      expect(@forecast.current_weather).to have_key :sunrise
      expect(@forecast.current_weather[:sunrise]).to be_a Time
      expect(@forecast.current_weather).to have_key :sunset
      expect(@forecast.current_weather[:sunset]).to be_a Time
      expect(@forecast.current_weather).to have_key :temperature
      expect(@forecast.current_weather[:temperature]).to be_a Float
      expect(@forecast.current_weather).to have_key :feels_like
      expect(@forecast.current_weather[:feels_like]).to be_a Float
      expect(@forecast.current_weather).to have_key :humidity
      expect(@forecast.current_weather[:humidity]).to be_a Integer
      expect(@forecast.current_weather).to have_key :uvi
      expect(@forecast.current_weather[:uvi]).to be_a Integer
      expect(@forecast.current_weather).to have_key :visibility
      expect(@forecast.current_weather[:visibility]).to be_a Integer
      expect(@forecast.current_weather).to have_key :conditions
      expect(@forecast.current_weather[:conditions]).to be_a String
      expect(@forecast.current_weather).to have_key :icon
      expect(@forecast.current_weather[:icon]).to be_a String
    end

    it '#daily_weather', :vcr do
      expect(@forecast.daily_weather).to be_a Array
      
      @forecast.daily_weather.each do |day|
        expect(day).to have_key :date
        expect(day[:date]).to be_a String
        expect(day).to have_key :sunrise
        expect(day[:sunrise]).to be_a Time
        expect(day).to have_key :sunset
        expect(day[:sunset]).to be_a Time
        expect(day).to have_key :max_temp
        expect(day[:max_temp]).to be_a Float
        expect(day).to have_key :min_temp
        expect(day[:min_temp]).to be_a Float
        expect(day).to have_key :conditions
        expect(day[:conditions]).to be_a String
        expect(day).to have_key :icon
        expect(day[:icon]).to be_a String
      end
    end

    it '#hourly_weather', :vcr do
      expect(@forecast.hourly_weather).to be_a Array
      
      @forecast.hourly_weather.each do |hour|
        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_a Float
        expect(hour).to have_key :conditions
        expect(hour[:conditions]).to be_a String
        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_a String
      end
    end

    it '#trip_weather', :vcr do
      expect(@forecast.trip_weather).to be_a Array
      
      @forecast.hourly_weather.each do |hour|
        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_a Float
        expect(hour).to have_key :conditions
        expect(hour[:conditions]).to be_a String
        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_a String
      end
    end
  end
end