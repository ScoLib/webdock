FROM alpine

LABEL maintainer="klgd <slice1213@gmail.com>"

RUN apk update
RUN apk add beanstalkd

VOLUME /var/lib/beanstalkd/data

EXPOSE 11300

CMD ["/usr/bin/beanstalkd"]