import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Random;

public class MatrixGenerator {
    private static final int MATRIX_SIZE = 7;

    public static void main(String[] args) {
        Random random = new Random();

        try (Writer writer = new OutputStreamWriter(System.out)) {
            // Generate and write the 7x7 matrix
            for (int i = 0; i < MATRIX_SIZE; i++) {
                for (int j = 0; j < MATRIX_SIZE; j++) {
                    // Generates a random number between 1 and the MATRIX_SIZE
                    int number = random.nextInt(MATRIX_SIZE) + 1;
                    writer.write(number + " ");
                }
                writer.write("\n"); // New line for each row
            }

            // Generate and write a random target sum
            int targetSum = random.nextInt(21) + 15;
            writer.write(String.valueOf(targetSum));
            writer.flush(); // Ensure all data is written immediately
        } catch (IOException e) {
            System.err.println("An error occurred while generating the matrix: " + e.getMessage());
            e.printStackTrace();
        }
    }
}