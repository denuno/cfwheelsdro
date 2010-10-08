#! /bin/bash
export ANT_HOME="build/cfdistro/ant/"
if [ -z "$1" ]; then
echo "cfwheelsdro control script"
OPTIONS="start stop help list-targets update exit"
select opt in $OPTIONS; do
if [ "$opt" = "start" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml build.start.launch
	exit
elif [ "$opt" = "stop" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml server.stop
	exit
elif [ "$opt" = "help" ]; then
	echo "usage (skips this prompt): cfwheelsdro.sh [start|stop|{target}]"
elif [ "$opt" = "list-targets" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml help
elif [ "$opt" = "update" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml project.update
elif [ "$opt" = "exit" ]; then
	exit
else
	#clear
	echo bad option
fi
done
fi
reldir=`dirname $0`
/bin/sh $reldir/build/cfdistro/ant/bin/ant -f $reldir/build/build.xml $*
	
			