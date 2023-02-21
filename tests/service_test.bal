import ballerina/io;
import ballerina/http;
import ballerina/test;

http:Client testClient = check new ("http://localhost:9090");

// Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("Starting test suite");
}

// Test function

@test:Config {}
function testCatalogAPI() returns error? {
    http:Client gqlEp = check new ("http://localhost:9090");
    json payload = {
        "query": "{\n  items {\n  name\n  description\n  includeDetail\n  includedFor\n  color\n  material\n  price}\n  }"
    };
    json response = check gqlEp->post("/snitemgraphql", payload);
    // test:assertEquals(response.data, expected);
    io:println(response.data);
}

// After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
    io:println("Ending test suite");
}
