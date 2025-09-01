import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class MagicSumSolver {

    private static final int MATRIX_SIZE = 7; //Number of rows and columns (7x7=49)
    private static int targetSum;
    private static final int[][] matrix = new int[MATRIX_SIZE][MATRIX_SIZE];
    private static final boolean[][] solutionMatrix = new boolean[MATRIX_SIZE][MATRIX_SIZE];
    private static int numberOfSolutions;

    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        // Read the 7x7 matrix
        for (int i = 0; i < MATRIX_SIZE; i++) {
            String line = reader.readLine();
            if (line == null) {
                // Handle end of input stream gracefully
                System.err.println("Error: Insufficient data in the input file.");
                return;
            }
            String[] numbers = line.trim().split("\\s+");
            for (int j = 0; j < MATRIX_SIZE; j++) {
                matrix[i][j] = Integer.parseInt(numbers[j]);
            }
        }

        // Read the target sum
        String targetSumLine = reader.readLine();
        if (targetSumLine == null) {
            System.err.println("Error: Target sum is missing from the input file.");
            return;
        }
        targetSum = Integer.parseInt(targetSumLine.trim());

        // Find all solutions
        findSolutions();

        // Print the result to standard output, which will be captured by the script
        printResult();
    }

    private static void findSolutions() {
        for (int i = 0; i < MATRIX_SIZE; i++) {
            for (int j = 0; j < MATRIX_SIZE; j++) {
                // Check horizontal, vertical, and diagonal directions
                checkDirection(i, j, 0, 1);  // Horizontal
                checkDirection(i, j, 1, 0);  // Vertical
                checkDirection(i, j, 1, 1);  // Diagonal down-right
                checkDirection(i, j, 1, -1); // Diagonal down-left
            }
        }
    }

    private static void checkDirection(int startRow, int startCol, int dRow, int dCol) {
        List<int[]> currentPath = new ArrayList<>();
        int currentSum = 0;
        int currentRow = startRow;
        int currentCol = startCol;

        while (currentRow >= 0 && currentRow < MATRIX_SIZE && currentCol >= 0 && currentCol < MATRIX_SIZE) {
            currentSum += matrix[currentRow][currentCol];
            currentPath.add(new int[]{currentRow, currentCol});

            if (currentSum == targetSum) {
                for (int[] pos : currentPath) {
                    solutionMatrix[pos[0]][pos[1]] = true;
                }
                numberOfSolutions+=1;
            }

            // Move to the next number in the path
            currentRow += dRow;
            currentCol += dCol;
        }
    }

    private static void printResult() throws IOException, IOException {
        Writer writer = new OutputStreamWriter(System.out);
        writer.write("--- Solution ---\n");
        for (int i = 0; i < MATRIX_SIZE; i++) {
            for (int j = 0; j < MATRIX_SIZE; j++) {
                if (solutionMatrix[i][j]) {
                    writer.write(" X ");
                } else {
                    writer.write(String.format("%2d ", matrix[i][j]));
                }
            }
            writer.write("\n");
        }
        writer.write("The number of solutions are : " + numberOfSolutions + "\n");
        writer.flush();
    }
}
