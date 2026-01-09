# API Testing & Automated Data Validation

This directory contains a **Postman Collection** and automated test scripts designed to validate RESTful API integrity. The focus is on ensuring that backend changes do not break the "contract" between the API and the front-end.

## 📂 Key Features

### 1. Automated Schema Validation
* **The Goal:** To ensure every API response returns the correct data types (e.g., ensuring `user_id` is always a `number` and not a `string`).
* **Why it matters:** Prevents "Undefined" errors in the UI caused by unexpected data formats.

### 2. Business Logic Assertions
* **The Goal:** Validating that calculated values in the API response are mathematically correct.
* **Scenario:** Checking that the `total_price` field accurately reflects the sum of individual `item_prices` plus tax.

### 3. Response Performance & Reliability
* **The Goal:** Monitoring header integrity and latency.
* **Validation:** Ensuring all successful requests return a `200 OK` status and a response time under `500ms` to meet Performance SLAs.

---

## 🛠️ How to Run These Tests

To view and execute these tests locally, follow these steps:

1. **Install Postman:** Download it at [postman.com](https://www.postman.com/).
2. **Import the Collection:** * Click **Import** in the top-left corner of Postman.
   * Drag and drop the `data_validation_tests.postman_collection.json` file from this folder.
3. **Run the Suite:** * Select the collection in the sidebar.
   * Click **Run Collection** to see the automated pass/fail results for each assertion.

## 🚀 Technical Skills Demonstrated
* **Tooling:** Postman, Newman (CLI for CI/CD integration).
* **Languages:** JavaScript (Chai Assertion Library).
* **Testing Types:** Contract Testing, Functional Testing, and Negative Testing.
