//import ballerinax/ellucian.student;
import ballerina/http;
import ballerina/log;
import ballerina/mime;

configurable string serviceUrl = "https://apitest.sinclair.edu/colleagueapi";
configurable string token = "";
configurable string username = "api.choreo";
configurable string password = "Tucker23";

service /collegeapi on new http:Listener(9091) {

    // resource function get students(string[]? residencies, string[]? types, string[]? ids) returns student:Student|http:Ok|http:InternalServerError|error? {
    //     student:Client|error studentEp = new (clientConfig = {
    //         auth: {
    //             token: token
    //         }
    //     }, serviceUrl = serviceUrl);

    //     if studentEp is error {
    //         log:printError("Error while initializing client: ", err = studentEp.message());
    //         return http:INTERNAL_SERVER_ERROR;
    //     }

    //     student:Student|error student = studentEp->getStudents("application/vnd.hedtech.integration.v16+json", criteria = {
    //         "residencies": residencies == null ? [] : residencies.'map((r) => {"residency": r}),
    //         "types": types == null ? [] : types.'map((t) => {"type": t})
    //     }, personFilter = {
    //         "ids": ids == null ? [] : ids.'map((i) => {"id": i})
    //     });

    //     if student is student:Student {
    //         return student;
    //     } else {
    //         log:printError("Error while getting response message: ", err = student.message());
    //         return http:INTERNAL_SERVER_ERROR;
    //     }
    // }

    // resource function get student(string id) returns student:Student|http:Ok|http:InternalServerError|error? {
    //     student:Client|error studentEp = new (clientConfig = {
    //         auth: {
    //             token: token
    //         }
    //     }, serviceUrl = serviceUrl);

    //     if studentEp is error {
    //         log:printError("Error while initializing client: ", err = studentEp.message());
    //         return http:INTERNAL_SERVER_ERROR;
    //     }

    //     student:Student|error student = studentEp->getStudent(id);
    //     if student is student:Student {
    //         return student;
    //     } else {
    //         log:printError("Error while getting response message: ", err = student.message());
    //         return http:INTERNAL_SERVER_ERROR;
    //     }
    // }

    resource function get students() returns json|http:Ok|http:InternalServerError|error? {

        http:Client clientEp = check new ("https://apitest.sinclair.edu/colleagueapi/");
        var basicAuth = mime:base64Encode(username + ":" + password);
        if basicAuth is string {
            json|error response = clientEp->/students({
                Authorization: "Basic " + basicAuth
            });
            if (response is error) {
                log:printError("Error from backend: ", err = response.message());
                return http:INTERNAL_SERVER_ERROR;
            }

            return response;
        }
        else {
            log:printError("Error while encoding basic auth: ");
            return http:INTERNAL_SERVER_ERROR;
        }

    }

}

