#!/bin/bash

# Display an installation dialog
zenity --info --text="Welcome to ChatGPT Installation" --title="ChatGPT Installer"

# Check the exit status of the initial information dialog
if [ $? -ne 0 ]; then
    zenity --error --text="Installation canceled." --title="Installation Canceled"
    exit 1
fi

# Initialize a variable to track whether the installation is successful
installation_successful=false

# Create a loop to retry the installation in case of failure
while [ "$installation_successful" != "true" ]; do
    # Create a new directory with a dialog for the directory name
    directory_name=$(zenity --entry --text="Enter the directory name:" --title="Directory Name")
    if [ $? -eq 0 ]; then
        # Check if the directory already exists
        if [ ! -d "$directory_name" ]; then
            # Ask for confirmation to create the directory
            zenity --question --text="Directory '$directory_name' does not exist. Do you want to create it?"

            # Check the exit status of the confirmation dialog
            if [ $? -eq 0 ]; then
                mkdir -p "$directory_name"

                # Check if the directory creation was successful
                if [ $? -eq 0 ]; then
                    # Download a ZIP archive of the GitHub repository
                    wget -O "/home/joshua/Desktop/$directory_name/ChatGPT.zip" "https://github.com/0xacx/chatGPT-shell-cli/archive/main.zip" --progress=bar:force:noscroll

                    # Check if wget encountered any errors
                    if [ $? -eq 0 ]; then
                        # Unzip the downloaded archive
                        unzip "/home/joshua/Desktop/$directory_name/ChatGPT.zip" -d "/home/joshua/Desktop/$directory_name/"

                        # Set the installation status to successful
                        installation_successful=true

                        # Display an installation complete dialog
                        zenity --info --text="ChatGPT Installation Finished" --title="Installation Complete"
                    else
                        zenity --error --text="Download failed." --title="Error"
                    fi
                else
                    zenity --error --text="Directory creation failed." --title="Error"
                fi
            else
                zenity --error --text="Directory creation canceled." --title="Error"
            fi
        else
            # Directory already exists, proceed with installation
            # Download a ZIP archive of the GitHub repository
            wget -O "/home/joshua/Desktop/$directory_name/ChatGPT.zip" "https://github.com/0xacx/chatGPT-shell-cli/archive/main.zip" --progress=bar:force:noscroll

            # Check if wget encountered any errors
            if [ $? -eq 0 ]; then
                # Unzip the downloaded archive
                unzip "/home/joshua/Desktop/$directory_name/ChatGPT.zip" -d "/home/joshua/Desktop/$directory_name/"

                # Set the installation status to successful
                installation_successful=true

                # Display an installation complete dialog
                zenity --info --text="ChatGPT Installation Finished" --title="Installation Complete"
            else
                zenity --error --text="Download failed." --title="Error"
            fi
        fi
    else
        zenity --error --text="Directory creation canceled." --title="Error"
        exit 1
    fi

    # If installation is not successful, ask if the user wants to retry
    if [ "$installation_successful" != "true" ]; then
        zenity --question --text="Installation failed. Do you want to retry?"
        if [ $? -ne 0 ]; then
            zenity --info --text="Installation canceled." --title="Installation Canceled"
            exit 1
        fi
    fi
done


