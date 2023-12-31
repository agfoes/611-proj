# Clustering Homework
I chose to complete my clustering homework on my project data set, instead of the class assignment. After building and running the Docker container (below), please run ```make full_data``` and ```make pca``` to create two plots for this assignment. Specifically, the plots are variance as a function of number of components and the data graphed as a function of pc1 and pc2. From the latter figure, there are not clear clusters of the data. There do seem to be numerous, small sets of data, but it is unclear if these are significant clusters.

# BIOS 611 Project
## Abby Foes

Hello! This is my semester project for BIOS 611 in Fall 2023. My analysis focuses on crime data from the city of Chicago, Illinois between the years 2001 and 2023. I will focus on data from 2020. Variables observed include date of incident, type of crime, precinct, ward, address, crime description, and more. In addition to detailed data on 2020, I will briefly analyze time trends for the entire time-span, focusing on crime frequency, not specific to a certain type, for the years between 2018 and 2023. The necessary data is already within the Docker container and does not need to be loaded from an external source. However, the original data source is available at the following link: https://catalog.data.gov/dataset/crimes-2001-to-present. The data file was too large to study in its entirety, hence the selected subsections of data.

### Launch Docker container and RStudio
Note: this project was conducted in a BIOS VM.

To access this analysis, you will need to access Docker and build the container from a terminal with the following commands.

First, clone my GitHub repository and build the Docker container with: 
```
git clone https://github.com/agfoes/611-proj
```
```
cd 611-proj/
docker build . --build-arg USER_ID=$(id -u) -t 611
```
Next, for Mac and Linux users, execute the following to launch a local RStudio window:
```
docker run -v $(pwd):/home/rstudio/work -e PASSWORD=611proj -v $HOME/.ssh:/home/rstudio/.ssh -v $HOME/.git:/home/rstudio/.git -p 8787:8787 -it 611
```
Next, visit the following address in your preferred browser: http://localhost:8787/ and input the username "rstudio" and password "611proj".


### Build data and create figures
To view the final report as an html file, execute the following commands in the RStudio terminal and open the output file in your web browser from the file explorer:
```
make clean
make report
```
In order to properly execute any make commands and create desired figures, data, and reports, start by typing the following command in the terminal of RStudio:
```
cd work
```
Then, execute the following: 
```
make clean
```
In the command line of the local RStudio window, execute the following commands to build derived data sets, create figures, and execute R scripts:
```{r}
make time_figures
make full_data
make pca
make fplot
make geo
```
To clear all output and start over, execute the following command in the terminal of RStudio:
```{r}
make clean
```