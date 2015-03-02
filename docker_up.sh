function rstudioUp(){
    dockername=${USER}_rstudio
    declare -i rstudioport="8787"

    docker run -d -P \
      --name $dockername \
      -v $HOME:/home/rstudio \
      rocker/rstudio

    ipWithPort=$(docker port $dockername $rstudioport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "==========================="
    echo "CONTAINER_NAME: $dockername"
    echo "==========================="
    echo "Open 120.126.36.164:$openport in your browser."
    echo "Login with account: rstudio and password: rstudio."
    echo "$HOME is mounted on /home/rstudio."
    echo "==========================="
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
      -v $HOME:/notebooks \
      ipython/scipyserver

    ipWithPort=$(docker port $dockername $ipythonport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "==========================="
    echo "CONTAINER_NAME: $dockername"
    echo "==========================="
    echo "Open 120.126.36.164:$openport in your browser."
    echo "Login with password: ipython."
    echo "$HOME is mounted on /notebooks."
    echo "==========================="
    echo "To stop server, please execute:"
    echo "./docker_stop.sh $dockername"
}

function shinyUp(){
    dockername=${USER}_shiny
    declare -i shinyport="3838"

    docker run -d -P \
      --name $dockername \
      -v $1:/srv/shiny-server/ \  # $1 is where you place shinyapps
      -v /srv/shinylog/:/var/log/ \
      -v $HOME:$HOME \
      rocker/shiny

    ipWithPort=$(docker port $dockername $shinyport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "==========================="
    echo "CONTAINER_NAME: $dockername"
    echo "==========================="
    echo "Open 120.126.36.164:$openport in your browser."
    echo "$1 is mounted on /srv/shiny-server/."
    echo "/srv/shinylog/ is mounted on /var/log/ for logs."
    echo "$HOME is mounted on $HOME."
    echo "==========================="
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
    shiny)
        shinyUp $2
    ;;
esac
