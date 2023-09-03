close all;
clear;
clc;

%% Initialization

%Create a serial object
port = 'COM4';
baud = 115200;
gpsObj = serialport(port,baud);
parserObj = nmeaParser("MessageId","GGA"); %GPS - parse NMEA sentences and extract GGA data



n = 9999;% number of files being processed
j = 1; %used to create an array for changing color bar of counts
k= 1;%used to create an array for GPS counter
an = [];
timeOut = 1;

%% Detetor Data

 
start = 1;
for i = 1:n



%% Establishes GPS coordinates when inside
 
%Start of GPS Mapping
    

    while i>=1
        
    
            %Read line by line from the serial object.
        
            data_GPS = readline(gpsObj);
            fprintf("attempt refresh");
            ggaData = parserObj(data_GPS);

        
                %GPS Coordinates
                lat = ggaData.Latitude ;
                long = ggaData.Longitude ;
                gpsTime = ggaData.UTCTime;
                disp(ggaData);

    
            for i= 1:n
    start=i;
    data_files = sprintf('spectrum%04d.csv', i);
    disp(data_files);
    disp(isfile(data_files));
    if ~isfile(data_files)
        
        break
    end

data_SIPM = {NaN(n-start-1)}; % data cell array
counts = [NaN(n-start-1)];

while i <=n
    data_files = sprintf('spectrum%04d.csv', i+start-1);
    parserObj = nmeaParser("MessageId","GGA"); %GPS - parse NMEA sentences and extract GGA data
    %Read line by line from the serial object.
            data_GPS = readline(gpsObj);
            ggaData = parserObj(data_GPS);
    if ~isfile(data_files)
        continue
    else
        SiPM_data = readtable(data_files);
        data_SIPM{i}= SiPM_data;
        counts(i) = sum(SiPM_data.Var2);
       
        disp(data_files);
          
        %delete(data_files)
    

H= counts(i);
        fprintf("The total Gamma count is: %d \n" , counts(i));
        newBars(i) = counts(i); % Update the live data on the graph
            % Now that we have new data, plot it.

       

        figure(2) %creates a live histogram of the counts data
       
        bar(1:i, newBars, 0.5,'b'); %plots the data in a histogram
        set(gca,'XGrid','on', 'YGrid', 'on', 'Fontsize', 16, 'linewidth', 1)

        ylim([0 500]) %keeps the grid steady 
        title("Crab Shell Counts");
        ylabel("counts");
        xlabel("time (seconds)");
        grid on; %Bar graph grid on
        drawnow;
   
         i=i+1; %incriments i by one to step the files
                    %Read line by line from the serial object.
                    
           %This GPS data is required
      
        
        ts = tic;

        while(toc(ts)<timeOut) %

            %Read line by line from the serial object.
            fprintf("Updated Data part 2")
            data = readline(gpsObj);
            ggaData = parserObj(data);

            if ggaData.Status == 0 % 0 indicates the input NMEA sentence is a VALID GGA.
                fixStatus = "A";
                
                %GPS Coordinates


                lat = ggaData.Latitude 
                long = ggaData.Longitude 
                gpsTime = ggaData.UTCTime
            end
        end
      
%GPS Plotting

        

        zoomLevel = 17; %Magnification of map

        rng('default') %Required for smooth transition of map steps (aka it knows where it is cause it knows where it isn't)


if H > 30 % Change value for threshold of counts
    
    j=j+1;
  CountsGPS(j-1,3) = H; %Creates a column for counts when greater than threshold
  CountsGPS(j-1,2) =lat; %Creates a column for latitude when greater than threshold
  CountsGPS(j-1,1)=long; %Creates a column for longitude when greater than threshold
  CountsGPS = [CountsGPS; nan(j,3)]; %Sets the value to NaN before it records the above values
  

else
CountsGPS(j,3) = 1; %Ensures if counts are below threshold, it moves the geoplot, but does not lay a colored dot.
CountsGPS(j,2) =lat;%Ensures if counts are below threshold, it moves the geoplot, but does not lay a colored dot.
CountsGPS(j,1)=long;%Ensures if counts are below threshold, it moves the geoplot, but does not lay a colored dot.
fprintf('%d',j); %Displays how many times counts were above threshold value
disp(i);


end
    
      

T = CountsGPS(1:j,2); % Latitude for Geo plot from Counts
G = CountsGPS(1:j,1); %Longitude for Geo plot from Counts
K =CountsGPS(1:j,3); %Counts for Geo plot


f1 = figure (1);

h = geoscatter(T,G,100,K,'filled','o'); %Creates a geoplot
s.ColorVariable = "Radiation Counts (CPS)"; %Creates a color bar corresponding to counts magnitude
c = colorbar; %Creates a color bar corresponding to counts magnitude
colormap(flipud(hot))
c.Label.String = "Radiation Counts (CPS)"; %Creates a color bar corresponding to counts magnitude
 geolimits([lat-0.0005,lat+0.0005],[long-0.0005,long+0.0005]); % sets the scale of the map to something reasonable
 geobasemap streets;  % Selects the basemap.
 drawnow; %Updates the live data on the geoplot
     

      end
   
    end
    
end    

end

    end

