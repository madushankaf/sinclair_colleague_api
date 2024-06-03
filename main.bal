//import ballerinax/ellucian.student;
import ballerina/http;
import ballerina/log;
import ballerina/mime;

configurable string serviceUrl = "https://apitest.sinclair.edu/colleagueapi";
configurable string username = "";
configurable string password = "";

service /collegeapi on new http:Listener(9091) {


    resource function get students() returns json|http:Ok|http:InternalServerError|error? {

        http:Client clientEp = check new ("https://apitest.sinclair.edu/colleagueapi/");
        var basicAuth = mime:base64Encode(username + ":" + password);
        if basicAuth is string {
            json|error response = clientEp->/students({
                Authorization: "Basic " + basicAuth
            });
            if (response is error) {
                log:printError("Error from backend: ", err = response.message());
                return error("Error from backend: " + response.message());
            }

            return response;
        }
        else {
            log:printError("Error while encoding basic auth: ");
            return error("auth error");
        }

    }

}

