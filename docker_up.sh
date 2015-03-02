function rstudioUp(){
    dockername=${USER}_rstudio
    declare -i rstudioport="8787"

    docker run -d -P \
      --name $dockername \
      -v $HOME:/home/rstudio \
      rocker/rstudio

    ipWithPort=$(docker port $dockername $rstudioport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "CONTAINER_NAME: $dockername"
    echo "Open 120.126.36.164:$openport in your browser."
    echo "Login with account: rstudio and password: rstudio."
    echo "$HOME is mounted on /home/rstudio."
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

    echo "CONTAINER_NAME: $dockername"
    echo "Open 120.126.36.164:$openport in your browser."
    echo "Login with password: ipython."
    echo "$HOME is mounted on /notebooks."
    echo "To stop server, please execute:"
    echo "./docker_stop.sh $dockername"
}

function shinyUp(){
    # if [ -z "$1" ]; then echo "var is unset"; fi
    dockername=${USER}_shiny
    declare -i shinyport="3838"

    docker run -d -P \
      --name $dockername \
      -v $1:/srv/shiny-server/ \  # $1 is where you place shinyapps
      -v /srv/shinylog/:/var/log/ \
      -v $HOME:$HOME \
      rocker/shiny:latest

    ipWithPort=$(docker port $dockername $shinyport)
    declare -i openport=${ipWithPort#0.0.0.0:}

    echo "CONTAINER_NAME: $dockername"
    echo "Open 120.126.36.164:$openport in your browser."
    echo "$HOME is mounted on $HOME."
    echo "Write logs in /srv/shinylog/"
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
