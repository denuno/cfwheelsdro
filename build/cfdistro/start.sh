if test -n "${JAVA_HOME}"; then
  if test -z "${JAVA_EXE}"; then
    JAVA_EXE=$JAVA_HOME/bin/java
  fi
fi

if test -z "${JAVA_EXE}"; then
  JAVA_EXE=java
fi  
cd $(dirname $0)
#exec $JAVA_EXE -jar ./lib/${jetty-runner.jar} $* > /dev/null 2>&1 &
exec $JAVA_EXE -jar ./lib/${jetty-runner.jar} --port 8181 --path /cfdistro $* .