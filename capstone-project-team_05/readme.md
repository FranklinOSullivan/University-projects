# Capstone Project Starter

This repository contains the starter for your capstone project. It includes the files for the project project and final reports, plus an area for you to store your code and other artifacts.

## Structure

The repository has the following structure:

- [final-report](final-report): contains the files for the final report ([see Canvas assignment](https://canvas.auckland.ac.nz/courses/106044/assignments/376416)).
- [images](images): stores all the images for the reports (both reports).
- [project](project): a folder for storing all project artifacts, including source code.
- [proposal](proposal): contains the files for the project proposal report ([see Canvas assignment](https://canvas.auckland.ac.nz/courses/106044/assignments/376410)).
- [risk-analysis](risk-analysis): contains the files for the risk analysis report ([see Canvas assignment](https://canvas.auckland.ac.nz/courses/106044/assignments/376409)).

---

## Running the Backend

To run the backend of this application, follow these steps:

1. **Install Dependencies**: Before running the backend, make sure you have installed all the required dependencies. You can install them using npm:

   ```bash
   npm install
   ```

2. **Start the Server**: Once the dependencies are installed, you can start the server using Node.js. If you want automatic restarts on file changes during development, it's recommended to use `nodemon`. If you haven't installed `nodemon` globally, you can do so by running:

   ```bash
   npm install -g nodemon
   ```

   Then, start the server using `nodemon`:

   ```bash
   nodemon ./bin/www
   ```

   If you prefer not to use `nodemon`, you can start the server with Node.js directly:

   ```bash
   node ./bin/www
   ```

3. **Accessing the Backend**: Once the server is running, you can access the backend API using the provided endpoints. By default, the backend will be accessible at `http://localhost:3000`.

4. **Testing the API**: You can use tools like Postman or curl to test the API endpoints. Make requests to the appropriate routes according to the functionality you want to test.

5. **Shutting Down the Server**: To shut down the server, you can press `Ctrl + C` in the terminal where the server is running. This will stop the server and free up the port it was using.

---
