MagicSumSolver

It is a game called "Magic Sums" that implements several things : Bash script that runs a generator of file and after that a solver that makes a file solution + 2 Java pre-compiled classes( worked on IntelliJ IDEA Community Edition) ################################################################################################################# Description of the Game : Find,in each puzzle,three-digit or more numbers whose sums add up to the number indicated below each pattern. The sums can be horizontally,vertically or diagonally. #################################################################################################################

The porpuse of these scripts are to generate a matrix of NxN and then implements a search of a target sum number into the matrix. It could have several solutions (target sums) when it finish it create an output file called "matrix_dada" + The number of the generated file (like matrix_data1.txt , matrix_data2.txt ,etc) It can be tested running the run_solver.sh script from outside of the IDE and passing a file.txt as an argument in the format of 7x7 matrix :

2 3 1 6 4 5 7
6 5 7 3 1 4 2
4 6 2 5 7 3 1
1 7 3 4 2 6 5
7 4 6 1 5 2 3
3 1 5 2 6 7 4
5 2 4 7 3 1 6
19

//// The last number (19) below is the target sum number /////

or test directly in your java IDE.

################################################################################################################### The option that is more funny is running the "GenerateAndSolve.sh" script. It goes to the directories of the pre-compiled classes MatrixGenerator and then to the MagicSumSolver The first one generate a matrix_data with random numbers but the same size 7x7 ( which can be changed if you want to in the java code) And then this runs the MatrixSumSolver.java that evaluate the entire matrix accordingly to the input txt received. It resolves the problem and makes a new file with the characeters of the original matrix but with an "X" in the places where there are solutions. After the execution of these you can go to the "/IdeaProjects/Magic Sums/matrix generated files" directory and see the input generated files and then see in "/IdeaProjects/Magic Sums/matrix generated files/Matrix Generated Solved" directory to see the solved files.

####################################################################################################################

To execute the run_solver.sh script it is necessary to pass 2 arguments

    The first argument is the path where the .java file is located
    The second argument is the path where the file of the puzzle txt is located

For example: ./run_solver.sh src/MagicSumSolver.java data/puzzle.txt On my case :/run_solver.sh src/MagicSumSolver.java matrix_data.txt It is interesting because it compiles and put in a temporary directory the ".class" in order to execute it After this, the run_solver.sh script removes the temporary directory with its content (.class created)

######################################################################################################################## In the case of GenerateAndSolveMatrix.sh it just runs without arguments and it looks for pre-compiled java classes into the specified directories of the current project It generates each time is executed a file called matrix_data$NUMBER.txt that is read and solved . Then it creates an output solved file with the same name but with the extension "_solved.txt" and put it in a different directory (e.g. "/IdeaProjects/Magic Sums/matrix generated files/Matrix Generated Solved") This is because later it is possible to compare both files to see the input file and the output file with the results It is possible too prove the java code apart from an IDE but it is necessary to compile the java classes like javac MagicSumsSolver.java MatrixGenerator.java ( located on my case : "/IdeaProjects/Magic Sums/src/MagicSumsSolver.java" and "~/IdeaProjects/Magic Sums/src/MatrixGenerator.java") This is essencially what the previous run_solver.sh script does ( the line javac -d "$TEMP_DIR" "$JAVA_FILE_PATH" putting the result to a temporary file) And it is important that in the "GenerateAndSolveMatrix.sh" file you look into the line where is specified the CLASSES_DIR=$(find "$PROJECT_DIR" -type d -path "*/out/production/Magic Sums" | head -n 1) . Here ,when use IntelliJ IDEA, it put the directory where the .class are generated . Unfortunatelly the command "find" cannt be so dinamically in this case looking for subdirectories and it end up in error if not put literrally as I mentioned.

Well I hope it gives you some interesting features about Java , Bash Scripting and the IDE. =) Let's have fun!



To execute the bash script it is necessary to pass 2 arguments 
1) The first argument is the path where the java file is located
2) The second argument is the path where the file of the puzzle txt is located

For example: ./run_solver.sh src/MagicSumSolver.java data/puzzle.txt
On my case  : src/MagicSumSolver.java matrix_data.txt

In the case of GenerateAndSolveMatrix.sh it just runs without arguments and it looks for 
pre-compiled java classes into the specified directories of the current project
It generates each time is executed a file called matrix_data$NUMBER.txt that is read and solved . 
Then it creates an output solved file with the same name but with the extension "_solved.txt" and put it in a different directory 
This is because later it is possible to compare both files to see the input file and the output file with the results

It is possible too prove the java code apart from an IDE but it is necessary to compile the java classes like "javac nameOfCLass.java" and then run it =)
