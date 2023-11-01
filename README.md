# BIOS 611 Project
## Fall 2023

Hello! This is my semester project for BIOS 611 in Fall 2023. My analysis focuses on crime data from the city of Chicago, Illinois between the years 2001 and 2023. I will focus on data from 2020. Variables observed include date of incident, type of crime, precinct, ward, address, crime description, and more. In addition to detailed data on 2020, I will briefly analyze time trends for the entire time-span, focusing on crime frequency, not specific to a certain type. 

To access this analysis, you will need to access Docker and build the container from a terminal with the following commands. 

First, build the Docker container with: 
```
docker build . --build-arg USER_ID=$(id -u) -t 611
```
Next, for Mac and Linux users, execute the following to launch a local RStudio window:
```
docker run --rm -v $(pwd):/home/rstudio/work -p 8787:8787 -it 611
```
Next, visit the following address in your preferred browser: http://localhost:8787/ and input the username "rstudio" and copy the password from the terminal in which you executed the previous commands. 