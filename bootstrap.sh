#!/bin/bash

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

function help(){
  echo "Bootstraps a new project "
  echo
  echo "Template : ./bootstrap.sh -{option} -{projectName}"
  echo "Bootstrap options "
  echo  
  echo "Options:"
  echo "-h     Print this Help."
  echo "-w     Sets the working directory to the project directory"
  echo "-i     Pass the project name"
  echo


  exit 1
}

function setupProject () {
 
  cd $SCRIPTPATH

  mkdir ./$1
  cd ./$1


  cp $SCRIPTPATH/.gitignore .
  mkdir ./src
  mkdir ./src/cores
  mkdir ./src/bin
  touch ./src/main.cpp
  touch ./README.md
  cd ./src
  echo $SCRIPTPATH
  cp $SCRIPTPATH/makefile .
  cd ../
  echo "@${1}: " 
  ls ./

  cd ~

}

projectName=""
setToProjectDirectory=0

while getopts "hi:w" option; do
  case $option in
    h) # display Help
     help
     exit;;
    i)
      projectName=$OPTARG
      ;;
    w) #Set working directory to new project
      setToProjectDirectory=1
      ;;
    \?) # Invalid option
      echo "Error: Invalid option"
      exit;;
  esac
done

if [ -z "$projectName" ]; 
then
  read -p "Project Name: " projectName
fi

setupProject "$projectName"

if [[ $setToProjectDirectory == 1 ]]; then
  cd $SCRIPTPATH  
  cd $projectName
  exec $SHELL
fi




