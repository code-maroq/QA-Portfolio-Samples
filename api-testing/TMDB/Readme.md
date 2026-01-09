API Testing Samples
===================

This folder contains Postman collections for testing the TMDB API. These samples demonstrate professional API testing methodologies, including automated assertions, environment variable management, and request chaining.

### How to use these:

1.  **Download the Collections:** Download the .json files (Basic and Advanced) provided in this repository.
    
2.  **Import to Postman:** Open Postman and click the **Import** button in the top-left corner. Select the downloaded files.
    
3.  **Configure API Key:**
    
    *   Obtain a free API key from [themoviedb.org](https://www.themoviedb.org/).
        
    *   In Postman, click on the Collection name, navigate to the **Variables** tab, and paste your key into the api\_key value field.
        
4.  **Execute Tests:**
    
    *   Run **Step 1 (Search)** to find a movie.
        
    *   Run **Step 2 (Details)** to see how the ID from Step 1 is dynamically passed to the next request.
        

### Key Features Demonstrated:

*   **Status Code Validation:** Scripts verify that the API returns the expected HTTP response codes (e.g., 200 OK for successful requests and 404 for invalid IDs).
    
*   **Dynamic Variables (API Chaining):** Demonstrates the use of pm.collectionVariables.set to extract data from a JSON response body and reuse it in subsequent API calls.
    
*   **Schema & Data Validation:** Ensures that the response structure matches expectations, checking for specific properties and data types (e.g., verifying that "results" is an array).
    
*   **Performance Benchmarking:** Includes tests to validate that response times stay within acceptable thresholds (e.g., < 800ms).
    

_Note: These tests are built against the TMDB Public API for demonstration purposes._
