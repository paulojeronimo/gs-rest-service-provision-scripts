cd ~/$op

create() {
  log Creating script $PWD/$1 ...
  cat - > $1
  chmod +x $1
}

create service.status <<'EOF'
#!/usr/bin/env bash
set +x

pid=$(jps | grep gs-rest-service | cut -d' ' -f1)
[ "$pid" ] && echo started: $pid || echo stopped
EOF

create service.build <<'EOF'
#!/usr/bin/env bash
set +x

BASE_DIR=`cd "$(dirname "$0")";pwd`
cd "$BASE_DIR"/complete

echo Building gs-rest-service on $PWD ...
./gradlew bootJar
EOF

create service.start <<'EOF'
#!/usr/bin/env bash
set +x

BASE_DIR=`cd "$(dirname "$0")";pwd`
cd "$BASE_DIR"

log=service.log
status=`./service.status`
case "$status" in
  started*)
    echo already $status
    ;;
  stopped)
    f=./complete/build/libs/gs-rest-service-0.1.0.jar
    if ! [ -r $f ]
    then
      ./service.build || exit $?
    fi
    echo Starting gs-rest-service ...
    java -jar $f &> $log &
    ./service.status
    ;;
esac
echo log: $PWD/$log
EOF

create service.stop <<'EOF'
#!/usr/bin/env bash
set +x

BASE_DIR=`cd "$(dirname "$0")";pwd`
cd "$BASE_DIR"

status=`./service.status`
case "$status" in
    started*)
        pid=`echo $status | cut -d: -f2 | xargs`
        echo killing gs-rest-service with pid $pid
        kill $pid
        ;;
    stopped)
        echo "gs-rest-service was'nt running"
        ;;
esac
EOF
