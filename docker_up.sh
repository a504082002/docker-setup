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
    # docker_stop.sh is not yet published.
    #echo "To stop server, please execute docker_stop.sh."
    echo "To stop server, please execute the following command:"
    echo "docker stop [CONTAINER_NAME] && docker rm [CONTAINER_NAME]"
}

function ipythonUp(){

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
