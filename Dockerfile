FROM neoky/passenger-with-rails
MAINTAINER Martin Cox

ENV HOME /root
ADD https://github.com/Neoky/BMU/archive/master.tar.gz /home/app/master.tar.gz
RUN rm /home/app/master.tar.gz
RUN git clone https://github.com/Neoky/BMU.git /home/app/github/BMU 
RUN cd /home/app/github/BMU && bundle install
WORKDIR /home/app/github/BMU
CMD ["/sbin/my_init"]
EXPOSE 3000

