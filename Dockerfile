FROM neoky/passenger-with-rails
MAINTAINER Martin Cox

ENV HOME /root

#the next 2 lines are unnecessary as long as we build with -no-cache
#if we switch to trusted builds, uncomment these 2 lines
#ADD https://github.com/Neoky/BMU/archive/master.tar.gz /home/app/master.tar.gz
#RUN rm /home/app/master.tar.gz

RUN git clone https://github.com/Neoky/BMU.git /home/app/github/BMU 
RUN cd /home/app/github/BMU && bundle install
WORKDIR /home/app/github/BMU
CMD ["/sbin/my_init"]
EXPOSE 3000

