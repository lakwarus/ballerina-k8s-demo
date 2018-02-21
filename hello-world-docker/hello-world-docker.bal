
import ballerina.net.http;
import ballerina.docker;

@docker:configuration{}
@http:configuration {basePath:"/helloWorld"}
service<http> helloWorld {
    resource sayHello (http:Connection conn, http:InRequest req) {
        http:OutResponse res = {};
        res.setStringPayload("Hello, World from service helloWorld !");
        _ = conn.respond(res);
    }
}

