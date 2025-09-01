#!/bin/bash

####################################################################################
# Check if the path to the Java source file is provided
# This section checks if you provided two command-line arguments when you ran the 
# script.
# The $1 and $2 variables represent the first and second arguments, respectively.
# The -z operator checks if a string is empty. If either of the arguments is 
# missing,
# it prints an error message and exits with a status code of 1, indicating an error.
# "If the first argument is empty then execute the code inside the if block."
# The name z can be thought of as standing for "zero length."
####################################################################################
if [ -z "$1" ]; then
    echo "Error , first argument is missing: /path_to_java_file.java"
    exit 1
fi
if [ -z "$2" ];then
    echo "Error , second argument is missing: /path_to_puzzle_file.txt>"
    exit 1
fi
JAVA_FILE_PATH="$1"
PUZZLE_FILE="$2"

####################################################################################
# Extract the directory and filename of java program
# dirname: This command extracts the directory path from the full file path.
####################################################################################
JAVA_DIR=$(dirname "$JAVA_FILE_PATH")

####################################################################################
# basename: This command extracts the filename without the directory path and,
# in this case, also removes the .java extension, leaving only the class name.
####################################################################################
JAVA_CLASS_NAME=$(basename "$JAVA_FILE_PATH" .java)

####################################################################################
# Check if the Java file exists
# -f "$JAVA_FILE_PATH": This checks if the value of the variable 
# JAVA_FILE_PATH points to a file that exists and is a regular file
# (e.g., a .java or .txt file), not a directory or other type of file.
####################################################################################
if [ ! -f "$JAVA_FILE_PATH" ]; then
    echo "Java file not found: $JAVA_FILE_PATH"
    exit 1
fi

####################################################################################
# Create a temporary directory for the compiled class file
# This line creates a temporary directory with a unique name.
# The -d option ensures a directory is created, and the command's output (the path 
# to the new directory)
# is stored in the TEMP_DIR variable.
# This is a good practice for preventing conflicts and keeping the file system clean.
####################################################################################
TEMP_DIR=$(mktemp -d)

####################################################################################
# Compile the Java program and place the .class file in the temporary directory
####################################################################################
echo "Compiling $JAVA_FILE_PATH..."
javac -d "$TEMP_DIR" "$JAVA_FILE_PATH"

####################################################################################
# This is a crucial error-checking step. The special variable "$?" holds the exit 
# status of the last executed command (javac in this case).
# A value of 0 indicates success, while any other number indicates an error.
# If compilation fails, the script reports the error and exits.
# "-ne": This is the comparison operator. It checks if the number on its left is not
# equal to the number on its right.
####################################################################################
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

####################################################################################
 # Check if the puzzle file exists
####################################################################################
if [ ! -f "$PUZZLE_FILE" ]; then
    echo "Puzzle file not found: $PUZZLE_FILE"
    exit 1
fi

####################################################################################
# Process the file and run the Java program
####################################################################################
echo "Processing and solving the puzzle from $PUZZLE_FILE..."

# Check if the puzzle file is empty before attempting to process it
if [ ! -s "$PUZZLE_FILE" ]; then
    echo "Error: The puzzle file '$PUZZLE_FILE' is empty."
    echo "Please check the script that generates this file to ensure it's working correctly."
    rm -r "$TEMP_DIR"
    exit 1
fi


# Run the Java program, setting the temporary directory as the classpath
# java: The command to run a Java class.
# -cp "$TEMP_DIR": The -cp (classpath) option tells the Java Virtual Machine (JVM)
# where to find the compiled class files. By pointing it to the temporary directory,
# the JVM knows where to find the JAVA_CLASS_NAME.class file.
# < "$PUZZLE_FILE": This is an input redirection.
# It takes the contents of the prepared puzzle file and
# feeds them to the Java program's standard input.
java -cp "$TEMP_DIR" "$JAVA_CLASS_NAME" < "$PUZZLE_FILE"

####################################################################################
# Clean up the temporary files
# rm -r "$TEMP_DIR": Recursively deletes the temporary directory and all its 
# contents (the compiled .class file).
# This ensures a clean exit.
####################################################################################
rm -r "$TEMP_DIR"

