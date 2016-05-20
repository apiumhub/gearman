FROM docker.apiumtech.io/apiumbase:v-0.0.0

RUN apt-get update && \
    apt-get install -y git zip php-pear \
  	gearman-job-server libgearman-dev && apt-get clean all

EXPOSE 4730

ENTRYPOINT [ "gearmand" ]