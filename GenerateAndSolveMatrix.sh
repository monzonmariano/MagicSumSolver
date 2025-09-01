#!/bin/bash


####################################################################################

# Define the project's root directory and output directories

####################################################################################

PROJECT_DIR="$HOME/IdeaProjects/Magic Sums"
GENERATED_DIR="$PROJECT_DIR/matrix generated files"
SOLVED_DIR="$GENERATED_DIR/Matrix Generated Solved"

echo "--- Setting up directories ---"
mkdir -p "$GENERATED_DIR"
mkdir -p "$SOLVED_DIR"

####################################################################################

# --- Step 1: Generate a new unique file name ---

####################################################################################

echo "--- Step 1: Generating a unique file name for the new matrix ---"
COUNTER=1
while [ -f "$GENERATED_DIR/matrix_data${COUNTER}.txt" ]; do
    COUNTER=$((COUNTER + 1))
done

INPUT_FILE="$GENERATED_DIR/matrix_data${COUNTER}.txt"
SOLVED_FILE="$SOLVED_DIR/matrix_data${COUNTER}_solved.txt"

####################################################################################

# --- Step 2: Dynamically find the directory of the compiled classes ---

####################################################################################

echo "--- Step 2: Finding the compiled class directory ---"


####################################################################################

# This find command is more robust and specifically looks for the standard IntelliJ
# output directory.

####################################################################################

CLASSES_DIR=$(find "$PROJECT_DIR" -type d -path "*/out/production/Magic Sums" | head -n 1)

if [ -z "$CLASSES_DIR" ] || [ ! -d "$CLASSES_DIR" ]; then
        echo "Error: Could not find the directory containing your compiled Java classes."
        echo "Please ensure your Java files are compiled and located under your project's directory."
    exit 1
fi

echo "Found classes directory: ./${CLASSES_DIR#$PROJECT_DIR/}"
echo "----------------------------------------"

####################################################################################

# --- Step 3: Run MatrixGenerator.java from its class file ---

####################################################################################

echo "--- Step 3: Running the Matrix Generator ---"
(cd "$CLASSES_DIR" && java MatrixGenerator) > "$INPUT_FILE"
if [ $? -ne 0 ]; then
    echo "Execution of MatrixGenerator failed."
    rm -f "$INPUT_FILE"
    exit 1
fi
echo "Successfully generated new matrix file: ./${INPUT_FILE#$PROJECT_DIR/}"
echo "----------------------------------------"


####################################################################################

# --- Step 4: Run MagicSumSolver.java from its class file ---

####################################################################################

echo "--- Step 4: Running the Magic Sum Solver ---"
echo "Processing and solving the puzzle from ./${INPUT_FILE#$PROJECT_DIR/}..."
(cd "$CLASSES_DIR" && java MagicSumSolver < "$INPUT_FILE") > "$SOLVED_FILE"

if [ $? -ne 0 ]; then
    echo "Execution of MagicSumSolver failed."
    rm -f "$SOLVED_FILE"
    exit 1
fi

echo "Solution saved to: ./${SOLVED_FILE#$PROJECT_DIR/}"
echo "----------------------------------------"
echo "Workflow complete."
