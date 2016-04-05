FROM ubuntu:14.04.3
MAINTAINER Upendra Kumar Devisetty <upendra@cyverse>
LABEL Description"This is the Dockerfile for imaging CheckM-v1.0.5"
# To get rid of all the messages
RUN DEBIAN_FRONTEND=noninteractive
# To update the image
RUN apt-get update
# To install all the dependencies
RUN apt-get -y install wget python-pip libblas-dev liblapack-dev libatlas-base-dev gfortran unzip python-dev
RUN apt-get -y install libfreetype6-dev libxft-dev
RUN pip install numpy
RUN pip install checkm-genome
RUN pip install pandas
RUN mkdir CheckM && cd CheckM
RUN wget https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_v1.0.5.tar.gz
RUN tar xvf checkm_data_v1.0.5.tar.gz
RUN rm /usr/local/lib/python2.7/dist-packages/checkm/checkmData.py
RUN wget https://github.com/upendrak/CheckM/blob/master/checkmData.py 
RUN mv checkmData.py /usr/local/lib/python2.7/dist-packages/checkm/
RUN checkm data update
#RUN checkm data setRoot /CheckM/new_data
# hmmer
RUN wget http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz 
RUN tar xvf hmmer-3.1b2-linux-intel-x86_64.tar.gz
RUN cd hmmer* && ./configure && make && make install
RUN cd ../
# Prodigal
RUN wget https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux
RUN cp prodigal.linux prodigal
RUN chmod +x prodigal && cp prodigal /usr/bin
# PPlacer
RUN wget https://github.com/matsen/pplacer/releases/download/v1.1.alpha17/pplacer-Linux-v1.1.alpha17.zip
RUN unzip pplacer-Linux-v1.1.alpha17.zip
RUN cp pplacer-Linux-v1.1.alpha17/pplacer /usr/bin/
RUN cp pplacer-Linux-v1.1.alpha17/guppy /usr/bin/
RUN cp pplacer-Linux-v1.1.alpha17/rppr /usr/bin/
# Entrypoint
ENTRYPOINT ["checkm"]

