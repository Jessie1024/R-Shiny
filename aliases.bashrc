#this is my aliaes for RShiny
start_shiny(){
    docker run -p $2:$2 \
 -v /home/jessieyy/storage/bios611-project2:/home/rstudio \
 -e PASSWORD=mypassword \
 -it project2 sudo -H -u rstudio /bin/bash -c "cd ~/; PORT=$2 make $1"
}