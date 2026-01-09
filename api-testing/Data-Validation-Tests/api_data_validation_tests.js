/* ==========================================================================
   API RESPONSE & DATA VALIDATION
   Target: REST API Endpoints (e.g., JSONPlaceholder or Internal Staging)
   Focus: Schema validation, Data types, and Business Logic assertions.
   ========================================================================== */

// 1. STATUS & PERFORMANCE VALIDATION
pm.test("Status code is 200 OK", function () {
    pm.response.to.have.status(200);
});

pm.test("Response time is less than 500ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(500);
});

// 2. SCHEMA & DATA TYPE VALIDATION
// Ensures the API isn't returning strings where integers are expected.
const responseJson = pm.response.json();

pm.test("Validate Data Schema: User Object", function () {
    pm.expect(responseJson).to.be.an('object');
    pm.expect(responseJson.id).to.be.a('number');
    pm.expect(responseJson.email).to.include("@"); // Basic format check
});

// 3. COMPLEX DATA CONSISTENCY (Business Logic)
// Scenario: If this is an 'Orders' API, the 'total_price' must match 'sum(items)'.
pm.test("Business Logic: Total Price matches Item Sum", function () {
    let calculatedSum = 0;
    responseJson.items.forEach(item => {
        calculatedSum += item.price;
    });
    pm.expect(responseJson.total_price).to.eql(calculatedSum);
});

// 4. NEGATIVE TESTING (Error Handling)
// Use this in a separate request where you send INVALID data.
/*
pm.test("Returns 400 for Invalid Payload", function () {
    pm.response.to.have.status(400);
    pm.expect(pm.response.json().error).to.eql("Invalid User ID");
});
*/
