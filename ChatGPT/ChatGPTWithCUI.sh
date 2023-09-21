#!/bin/bash

echo "Installing ChatGPT..."

# Define the directory name
directory_name="/home/joshua/Desktop/ChatGPT"

# Create the directory
mkdir -p "$directory_name"

# Check if the directory creation was successful
if [ $? -eq 0 ]; then
   # Copy an existing file to the ChatGPT folder
   cp /home/joshua/Downloads/ChatGPT/ChatGPT.sh "$directory_name/"
   cd "$directory_name"
   mv ChatGPT.sh ChatGPT

   echo "ChatGPT Installation Finished"
else
   echo "Error: ChatGPT Installation Failed. Error Code: 0011x10001101"
fi

