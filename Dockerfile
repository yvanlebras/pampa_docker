FROM rocker/shiny:3.6.3 AS init

# Installing packages needed for check traffic on the container and kill if none
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
    apt-get --allow-releaseinfo-change update && \
    apt-get -qq update && apt-get install --no-install-recommends -y net-tools procps libgdal-dev libproj-dev libudunits2-dev libssl-dev tk-dev
# Installing R package dedicated to the shniy app
##RUN    Rscript -e "install.packages('gamlss')"
##RUN    Rscript -e "install.packages('geosphere')"
##RUN    Rscript -e "install.packages('dplyr')"
##RUN    Rscript -e "install.packages('leafpop')"
##RUN    Rscript -e "install.packages('maptools')"
##RUN    Rscript -e "install.packages('multcomp')"
##RUN    Rscript -e "install.packages('rgdal')"
##RUN    Rscript -e "install.packages('rgeos')"
##RUN    Rscript -e "install.packages('rpart')"
##RUN    Rscript -e "install.packages('sp')"
##RUN    Rscript -e "install.packages('tcltk')"
##RUN    Rscript -e "install.packages('tkrplot')"
##RUN    Rscript -e "install.packages('vegan')"
##RUN    Rscript -e "install.packages('vegan')"
##RUN    Rscript -e "install.packages('svDialogs')"
RUN    Rscript -e "install.packages('devtools')"
RUN    Rscript -e "install.packages('golem')"
RUN    Rscript -e "install.packages(c('shinyjs', 'shinyWidgets', 'shinyFiles', 'leaflet', 'shinyFeedback'))"
RUN    Rscript -e "install.packages('colourpicker')"
RUN    Rscript -e "install.packages('bsplus')"
RUN    Rscript -e "install.packages('shinycssloaders')"
RUN    Rscript -e "install.packages('bsplus')"
RUN    Rscript -e "install.packages('shinycssloaders')"
RUN    Rscript -e "remotes::install_github('madelinm/Package_PAMPA',INSTALL_opts='--no-staged-install')"

# Bash script to check traffic
COPY Application_PAMPA-main/PampaApp/ /srv/shiny-server/sample-apps/PAMPA/
RUN chmod -R 777  /srv/shiny-server/sample-apps/PAMPA
RUN chmod -R 777  /opt/shiny-server/samples/sample-apps/PAMPA

RUN cd /srv/shiny-server/sample-apps/PAMPA/inst/
RUN    Rscript -e "golem::run_dev()"

