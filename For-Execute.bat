REM Loop through each IP in IP_List.txt and call Job.bat with the IP as argument
for /F %%i in (IP_List.txt) do call Log_archive.bat %%i

exit

REM ------------------- og_ar.bat file -------------------
REM Job created for stopping specified service, renaming the backup log folder,
REM creating empty folder, and starting the service
REM Job Creation date : 11th April 2022
REM Created by Abhishek Getme version: 1.0.0