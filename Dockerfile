FROM nacyot/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN apt-get update
RUN apt-get install -y gfortran
RUN apt-get install -y default-jre

# Set default WORKDIR
WORKDIR /source

# Compile fortran
ADD hello_world.f /source
RUN gfortran -o hello_world /source/hello_world.f

ADD run.sh /source
ADD ./java-shim/target/demo-0.0.1-SNAPSHOT.jar /source/service.jar
RUN chmod a+x run.sh

CMD ./run.sh
