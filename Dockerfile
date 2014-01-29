FROM phusion/passenger-full
MAINTAINER Martin Cox
RUN gem install rails --no-rdoc --no-ri
EXPOSE 22 80 443 3000