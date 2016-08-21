#!/bin/sh

APP_HOME=target/netty-demo-1.0-SNAPSHOT
CLASSPATH=$APP_HOME/lib
for i in "$APP_HOME"/lib/*.jar; do
   CLASSPATH="$CLASSPATH":"$i"
done

case "$1" in

  start)
    nohup java -Xms128m -Xmx128m -cp $CLASSPATH com.zr.NettyServer >> server.log 2>&1 &
    echo $! > server.pid
    echo "start java application with pid `cat server.pid`"
    ;;

  stop)
    echo "shutting down java application with pid `cat server.pid`"
    kill `cat server.pid`
    rm -rf server.pid
    ;;

  restart)
    $0 stop
    sleep 1
    $0 start
    ;;

  *)
    echo "Usage: run.sh {start|stop|restart}"
    ;;

esac

exit 0
