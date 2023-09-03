Download the BMCA Brightspec software.
Plug brightspec MCA’s into USB port. Does not matter which port. 
Run Crabpot MCA. Enter threshold value: 1-100. It automatically inputs this as a percent value. 
The software will run until it starts to get files. 
Open two brightspec windows. Select connect device, connect one of two devices to each window.
Once MCA connected. Go to settings Set voltage to 700. Select voltage on. May need to adjust other settings, but this is the basic idea. 
Select MCA,  Batch save.
Turn on wait time.
NAVIGATE TO EACH FOLDER Independently!!! Save the file with tag “1” for files saved in MCA 1 and “2” for files saved in MCA 2.The file default will be saved as bMCA_1_%04d.SPE or bMCA_2_%04d.SPE.
Once files are saved in the sub folders, the Matlab files will run. Make sure to have all Scripts in Matlab directory. 
Keep in mind we only had 2 brightspec MCA’s. Therefore files in “MCA 3” are real data. However, it is not live data. DO NOT DELETE THESE for proper operation. 

Download and install CapeScint MCA software
Plug in Arduino and CapeScint into USB ports of computer. Open MatLab code. May need to change the COM Port Number based on what USBs identify on laptop.
Must be outside and in open away from buildings to get GPS Messages.
When connected to GPS data the script will continue to run. 
Will be running until it starts to receive .CSV files in the SAME folder.
Open Cape MCA software. File  Device  connect.
File  Auto Save .CSV Navigate to folder to save, but DO NOT enter a file name to save. The default is spectrum%04d.csv.
 Save interval of 3 seconds.
Check on “Zero Spectrum after every save” and “ Enable Auto Save.” 
Click “Okay”.
May take a few seconds for Matlab code to catch up, but should be analyzing data. # CRABS
