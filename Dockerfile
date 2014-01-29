FROM phusion/passenger-full
MAINTAINER Martin Cox

ENV HOME /root
RUN gem install rails --no-rdoc --no-ri
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'root:changeme' |chpasswd
RUN rails new /home/app/temp && rm -rf /home/app/temp
ADD https://github.com/Neoky/BMU/archive/master.tar.gz /home/app/master.tar.gz
RUN rm /home/app/master.tar.gz
RUN git clone https://github.com/Neoky/BMU.git /home/app/github/BMU 
RUN cd /home/app/github/BMU && bundle install
WORKDIR /home/app/github/BMU
CMD ["/sbin/my_init"]
EXPOSE 3000

