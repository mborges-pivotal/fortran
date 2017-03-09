FROM nacyot/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN apt-get update
RUN apt-get install -y gfortran
RUN apt-get install -y default-jdk

# Set default WORKDIR
WORKDIR /source

# Compile fortran
ADD hello_world.f /source
ADD allocatable.f90 /source
ADD random_prb.f90 /source
RUN gfortran -o hello_world /source/hello_world.f
RUN gfortran -o allocatable /source/allocatable.f90
RUN gfortran -o random_prb /source/random_prb.f90

ADD run.sh /source
RUN chmod a+x run.sh

ADD java-shim /source/java-shim
RUN cd ./java-shim && ./mvnw package && cd .. && cp ./java-shim/target/java-shim-0.0.1-SNAPSHOT.jar /source/service.jar

ADD wamitdemo_v72_x64l /source/wamitdemo_v72_x64l
#RUN sh /source/INSTALL.sh
ENV LD_LIBRARY_PATH /source/wamitdemo_v72_x64l/redist/:$LD_LIBRARY_PATH
ENV PATH /source/wamitdemo_v72_x64l/bin:$PATH

CMD ./run.sh
