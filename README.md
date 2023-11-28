# Clustering Homework
I chose to complete my clustering homework on my project data set, instead of the class assignment. After building and running the Docker container (below), please run ```make full_data``` and ```make pca``` to create two plots for this assignment. Specifically, the plots are variance as a function of number of components and the data graphed as a function of pc1 and pc2. From the latter figure, there are not clear clusters of the data. There do seem to be numerous, small sets of data, but it is unclear if these are significant clusters.

# BIOS 611 Project
## Abby Foes

Hello! This is my semester project for BIOS 611 in Fall 2023. My analysis focuses on crime data from the city of Chicago, Illinois between the years 2001 and 2023. I will focus on data from 2020. Variables observed include date of incident, type of crime, precinct, ward, address, crime description, and more. In addition to detailed data on 2020, I will briefly analyze time trends for the entire time-span, focusing on crime frequency, not specific to a certain type. The necessary data is already within the Docker container and does not need to be loaded from an external source.

### Launch Docker container and RStudio
To access this analysis, you will need to access Docker and build the container from a terminal with the following commands.

First, build the Docker container with: 
```
docker build . --build-arg USER_ID=$(id -u) -t 611
```
Next, for Mac and Linux users, execute the following to launch a local RStudio window:
```
docker run --rm -v $(pwd):/home/rstudio/work -p 8787:8787 -it 611
```
Next, visit the following address in your preferred browser: http://localhost:8787/ and input the username "rstudio" and password "611proj".


### Build data and create figures
In the command line of the local RStudio window, execute the following commands to build derived data sets, create figures, and execute R scripts:
```{r}
make time_figures
make full_data
make pca
make fplot
```

To clear all output and start over, execute the following command in the terminal of RStudio:
```{r}
make clean
```

To view the final report as an html file, execute the following command in the RStudio terminal:
```
make report
```