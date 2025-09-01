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
