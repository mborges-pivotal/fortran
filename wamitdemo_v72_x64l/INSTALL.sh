#!/bin/bash
# INSTALL.sh

INSTDIR=/usr/local/wamitdemo
LIBINST=true
PROFINST=false
INHOME=false

while getopts "d:lph" opt; do
   case $opt in
      d)
        echo "installing into: $OPTARG"
	if [ -z $OPTARG ]
	then
	  echo "Please give the install directory root: -d <dirname>" 
	  exit 1
	fi
	  
	INSTDIR=$OPTARG/wamitdemo
	;; 
      l)
	LIBINST=false
	;;
      p)
	PROFINST=true
	;;
      h)
        echo "installing into home directory with no root privileges"
        INSTDIR=$HOME/wamitdemo
        LIBINST=true
        PROFINST=true
        INHOME=true
        ;;
      :)
	;;
   esac
done

echo "installing WAMIT v7 demonstration into: $INSTDIR"

# check if INSTDIR exists; if not create;
if [ -d "$INSTDIR" ]; then rm -rf $INSTDIR; fi
if [ ! -d "$INSTDIR" ]; then mkdir $INSTDIR; fi

# create directory structure, if it doesn't exist already
if [ ! -d "$INSTDIR"/bin ]; then mkdir $INSTDIR/bin; fi
if [ ! -d "$INSTDIR"/lib ]; then mkdir $INSTDIR/lib; fi

# copy files to where they belong
cp -p ./bin/wamit_demo $INSTDIR/bin
cp -pR ./testruns $INSTDIR
cp -p README.txt $INSTDIR

# link to /usr/local/bin and /usr/local/lib
LOCALBIN=/usr/local/bin
LOCALLIB=/usr/local/lib
ln -sf $INSTDIR/bin/wamit_demo /usr/local/bin/wamit_demo
if [ -d /usr/local/lib64 ]; then LOCALLIB=/usr/local/lib64; fi
if [ ! $INHOME ]; then ln -sf $INSTDIR/bin/wamit_demo $LOCALBIN/wamit_demo; fi
if $INHOME; then LOCALLIB=$HOME/wamitdemo/lib; fi

if $LIBINST; then
echo "Installing Intel Fortran Compilers..."
INTELLIBS="libiomp5.so libifcoremt.so.5 libimf.so libsvml.so libintlc.so.5 libifport.so.5" 
for library in $INTELLIBS
do
	cp -p ./redist/$library $INSTDIR/lib
	if [ ! $INHOME ]; then ln -sf $INSTDIR/lib/$library $LOCALLIB/$library; fi
done
fi

if $PROFINST; then
	echo "Added by WAMIT INC during install of WAMITv7" >> /etc/profile
	echo "export LD_LIBRARY_PATH=$LOCALLIB:LD_LIBRARY_PATH" >> /etc/profile
fi

if $INHOME; then
	echo
	echo "WAMIT installed in home directory."
	echo "Please add $HOME/wamitdemo/bin to your path statement."
	echo "Please add $LOCALLIB to your LD_LIBRARY_PATH variable."
	echo
fi


echo "Installation complete.  Please consult the README.txt file for further configuration notes"

exit 0
