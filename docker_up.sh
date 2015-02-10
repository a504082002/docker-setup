function rstudioUp(){
    dockername=${USER}_rstudio
    declare -i rstudioport="8787"

    docker run -d -P \
      --name $dockername \
      -v $HOME:$HOME \
      rocker/rstudio

    ipWithPort=$(docker port $dockername $rstudioport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "CONTAINER_NAME: $dockername"
    echo "Open 120.126.36.164:$openport."
    echo "Login with account: rstudio and password: rstudio."
    echo "$HOME is mounted on $HOME."
    echo "To stop server, please execute:"
    echo "./docker_stop.sh $dockername"
}

function ipythonUp(){
    dockername=${USER}_ipython
    declare -i ipythonport="8888"

    docker run -d -P \
      --name $dockername \
      -e "PASSWORD=ipython" \
      -e "USE_HTTP=1" \
      -v $HOME:$HOME \
      ipython/scipyserver

    ipWithPort=$(docker port $dockername $ipythonport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "CONTAINER_NAME: $dockername"
    echo "Open 120.126.36.164:$openport."
    echo "Login with password: ipython."
    echo "$HOME is mounted on $HOME."
    echo "To stop server, please execute:"
    echo "./docker_stop.sh $dockername"
}


## main ##
case $1 in
    rstudio|Rstudio)
        rstudioUp
    ;;
    ipython)
        ipythonUp
    ;;
esac
