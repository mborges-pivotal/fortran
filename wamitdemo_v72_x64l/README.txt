  -----------------------------------------------------------------------

                                 WAMIT
                           Versions 7.2
        Copyright (c) 1999-2016  WAMIT Incorporated
        Copyright (c) 1998  Massachusetts Institute of Technology
                  FOR UPDATE NOTES SEE END OF FILE
  -----------------------------------------------------------------------


     The use and distribution of WAMIT and associated programs and
     documentation is limited by the conditions in the license
     agreement.

     Minimum requirements: kernel 2.6, glibc 2.3

     This program was compiled/linked with Intel Fortran Version 12.1
     on Centos6 with:
     Linux kernel: 2.6.32
     glibc: 2.12-1.47

     This program has been tested on:
     Centos6: linux kernel 2.6.43, glibc 2.12-1.47
     OpenSUSE11.4: linux kernel 2.6.37, glibc 2.6.37
     Ubuntu 11.10: linux kernel 3.0.0, glibc 2.13-1 

     The following is a listing of the files included in this tar file:
     INSTALL.sh	      		(basic install script, see INSTALLATION instructions)
     bin/wamit_demo		(main program)
     redist/*.so		(libifcoremt.so, libimf.so, libintlc.so, libiomp5.so, libsvml.so Intel Fortran redistributable libraries)
bject files in lib/)

     testruns/ (Contains input files for standard test runs)
     testruns/out (Contains output files for standard test runs)

     The use of WAMIT is documented in the comprehensive User Manual.
     The following notes are intended to provide supplementary information
     for installation and maintenance of WAMIT in the Linux environment.

INSTALLING V7Linux:

     It is recommended that this software be installed either as the root user
     or by a user with sudo privilege access to the location of installation.

     By default, the INSTALL.sh script installs only the WAMIT software and .so
     files to /usr/local/wamitdemo.  This can be done by running:

     sh ./INSTALL.sh

     in the directory where WAMITv7 was unpacked.  This will automatically link
     the wamit binaries and shared object libraries to the /usr/local Local File
     Hierarchy (/usr/local/bin, /usr/local/lib or /usr/local/lib64 if available).
     By default, the script will install the Intel Fortran redistributable 
     libraries.

     The INSTALL.sh script accepts the following options:
     	 -d <dirname> 	   where <dirname> is the root path other than 
	    		   /usr/local to install wamitv7
	 -l		   DO NOT install the INTEL Fortran redistributable 
	 		   libraries.  Use this option only if you have the
			   correct version of Intel Fortran already installed.
	 -p		   Add the local libraries to the environment variable:
	 		   LD_LIBRARY_PATH to the /etc/profile file.

     To install WAMIT and the Intel Fortran shared object files
     into /usr/local/wamitdemo:

     sh ./INSTALL.sh

     To install WAMIT and the Intel Fortran shared object files
     in a directory called /usr/local/foo:

     sh ./INSTALL.sh -d /usr/local/foo

     To install WAMIT, but not the Intel Fortran shared object files
      and set the LD_LIBRARY_PATH variable for all users via 
     /etc/profile:

     sh ./INSTALL.sh -lp

CONFIGURING V7Linux:

     The LD_LIBRARY_PATH variable must be set to point at the location where
     the WAMIT (and Intel Fortran, if applicable) shared object libraries were
     installed.

     For bash shells with the libraries installed in /usr/local/lib64:
     export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH

     For c shells with the libraries installed in /usr/local/lib64:
     setenv LD_LIBRARY_PATH /usr/local/lib64:$LD_LIBRARY_PATH

     will preserve any user settings and ensure that the Inel Fortran libraries
     compatible with WAMIT will be the first used in executing WAMIT.


RUNNING V7Linux:

     The scratch files are deleted by the program before a normal
     termination.  If the program is interrupted during execution by
     a power interruption, or end task command, some scratch files may
     remain on the disk, in two distinct forms.  The first form are
     named scratch files with the filenames SCRATCHn (n=A,B,C,...).

     These may be deleted with the linux delete command "rm SCRATCH*".
     It is likely that unnamed scratch files will exist, and will be
     reported as `lost clusters' by fsck.  When this occurs fsck -r may 
     be used to erase these files.

     Unnamed scratch files are stored in the temporary directory of the system
     and the named scratch files, SCRATCHn, are stored on the current directory.
     The latter may be changed using a parameter SCRATCH_PATH in CFG files
     to a separate partition on the current or another hard disk as explained
     in Chapter 3 of User Manual.

     Run times for POTEN depend primarily on the number of
     panels or patches, the water depth, and the number of cores
     and the clock speed of CPU. The first period computed in a run 
     requires extra time to evaluate the Rankine components of the influence
     function which are stored for subsequent use at each period.

     WAMIT V7 is compiled using FORTRAN 90 with dynamic dimensioning
     of most arrays at run time.  Thus there are no fixed limits on the
     numbers of panels, wave periods, headings, bodies, generalized
     modes, or field points.  In practice, on any system with finite RAM
     and hard disk space, practical limits will exist. The memory and
     diskspace requirements are explained in Chapter 14 of the User Manual.
     If the number of panels (especially) and other inputs becomes
     excessive the run time will increase and/or the execution may be
     terminated with an error message. It is impossible to give general
     information applicable to a variety of different systems, and users
     are advised to gain experience for their particular system to judge
     the practical limitations.

  -----------------------------------------------------------------------
