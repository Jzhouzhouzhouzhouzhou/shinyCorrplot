 <h1><center> Help of shinyCorrplot </center></h1>

This is the help for the Shiny application presented in "shinyCorrplot": make corrplot display in R with shiny .This document can solve some common problems encountered by users

*****


#	What is shinyCorrplot?

This is a tool for making correlation matrix diagrams. This tool is a interactive graphical display of a correlation matrix, confidence interval. It also contains some algorithms to do matrix reordering.In addition, corrplot is good at details, including choosing color, text labels, color labels, layout, etc.It also supports you to download PDF or SVG files.

*****

#	How to use shinyCorrplot? 

Under the corrplot option, you can click the "Browse" button in the left menu to select the data to be uploaded.

**1.The uploaded text needs to be in matrix format.**

About the data to be uploaded, the first row and the first column of the uploaded file must have corresponding row and column names.

**2.Is it a correlation matrix**

Based on the data you upload,The diagonal element of correlation matrix is 1, which is symmetric matrix. if it's not a correlation matrix, select No.

**3.choose a visualization method to display**

There are seven visualization methods (parameter method) in options, named "circle", "square", "ellipse", "number", "share", "color" and "pie".Default: circular color gradient effect display correlation coefficient.Positive correlations are displayed in blue and negative correlations in red color. Color intensity and the size of the circle are proportional to the correlation coefficients.

**4.choose a Layout to display**

There are three layout types (parameter types): "full" (default): display the full correlation matrix, "upper": display the upper triangle of the correlation matrix, "lower": display the lower triangle of the correlation matrix

**5.choose a method to reorder**

The correlation matrix can be reordered according to the correlation coefficient. This is important to identify the hidden structure and pattern in the matrix.There are four methods in the corolot (parameter order), which are "AOE", "FPC", "hclust" and "alphabet".

**6.choose color**

The color of the correlogram can be customized,you can Choose the different color spectra you want.

**7.addrect**

Addrect is to add a grouping rectangle, you can customize the grouping class.It is used to express the classifiable characteristics of research objects, so as to facilitate further classified discussion or research.You can choose the number from 1 to 15.

**8.When you upload all the data,click the "GO!" button to generate the picture**

*****

#	Launch shinyCorrplot directly from R

User can choose to run shinyCorrplot installed on local computers (Windows, Mac or Linux) for a more preferable experience.

**Step 1: Install R and RStudio**

Before running the app you will need to have R and RStudio installed (tested with <font color="red">R 3.5.0</font> and RStudio 1.1.419).  
Please check CRAN (https://cran.r-project.org/) for the installation of R.  
Please check https://www.rstudio.com/ for the installation of RStudio.  

**Step 2: Install the R Shiny package and other packages required by shinyCorrplot**

Start an R session using RStudio and run these lines:  
```
# try an http CRAN mirror if https CRAN mirror doesn't work
library(shiny)
library(corrplot)
library(shinyBS)
library(RColorBrewer)
library(shinythemes)
```

**Step 3: Start the app**  

Start an R session using RStudioun these lines:  
```
shiny::runGitHub(", "")  
``` 
*****

#	Deploy shinyCorrplot on local or web Linux server

**Step 1: Install R**  

Please check CRAN (https://cran.r-project.org/) for the installation of R.

**Step 2: Install the R Shiny package and other packages required by shinyCorrplot**  

Start an R session and run these lines in R:  
```
# try an http CRAN mirror if https CRAN mirror doesn't work  
library(shiny)
library(corrplot)
library(shinyBS)
library(RColorBrewer)
library(shinythemes)
```

For more information, please check the following pages:  
https://cran.r-project.org/web/packages/shiny/index.html  
https://github.com/rstudio/shiny  
https://shiny.rstudio.com/  

**Step 3: Install Shiny-Server**

Please check the following pages for the installation of shiny-server.  
https://www.rstudio.com/products/shiny/download-server/  
https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source  

**Step 4: Upload files of shinyCorrplot**

Put the directory containing the code and data of shinyCorrplot to /srv/shiny-server.  

**Step 5: Configure shiny server (/etc/shiny-server/shiny-server.conf)**

```
# Define the user to spawn R Shiny processes
run_as shiny;

# Define a top-level server which will listen on a port
server {  
  # Use port 3838  
  listen 3838;  
  # Define the location available at the base URL  
  location /shinyCorrplot {  
    # Directory containing the code and data of shinyCorrplot  
    app_dir /srv/shiny-server/shinyCorrplot;  
    # Directory to store the log files  
    log_dir /var/log/shiny-server;  
  }  
}  
```

**Step 6: Change the owner of the shinyCorrplot directory**

```
$ chown -R shiny /srv/shiny-server/shinyCorrplot  
```

**Step 7: Start Shiny-Server**

```
$ start shiny-server  
```

Now, the shinyPie app is available at http://IPAddress/.  



