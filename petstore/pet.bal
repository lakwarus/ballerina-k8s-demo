import ballerina.log;
import ballerina.data.sql;
import ballerina.net.http;

@http:configuration {basePath:"/pet"}
service<http> petService {

    endpoint<sql:ClientConnector> petDB {
        create sql:ClientConnector(
        sql:DB.MYSQL, "localhost", 3306, "petdb", "root", "root", {maximumPoolSize:5});
    }

    @http:resourceConfig {methods:["GET"], path:"/"}
    resource getAllPet (http:Connection conn, http:InRequest req) {
        log:printInfo("Retrieving All Pets");
        http:OutResponse resp = {};
        resp.setStringPayload("All Pets");
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["GET"], path:"/{id}"}
    resource getPet (http:Connection conn, http:InRequest req, string id) {
        log:printInfo("Retrieving a Pets");
        http:OutResponse resp = {};
        resp.setStringPayload("Get a Pet");
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["POST"], path:"/"}
    resource addPet (http:Connection conn, http:InRequest req) {
        log:printInfo("Adding Pet");
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Added");
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["DELETE"], path:"/"}
    resource deletePet (http:Connection conn, http:InRequest req) {
        log:printInfo("Adding Pet");
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Added");
        _ = conn.respond(resp);
    }

}
