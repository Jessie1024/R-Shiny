FROM rocker/verse
MAINTAINER Qianhui Yang<jessy1024qh@gmail.com>
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('pdp')"