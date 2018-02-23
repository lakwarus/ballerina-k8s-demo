import ballerina.docker;
import ballerina.net.http;

@docker:configuration {
    push:true,
    registry:"index.docker.io/anuruddhal",
    username:"anuruddhal",
    password:"**********"
}
@http:configuration {
    basePath:"/helloWorld"
}
service<http> helloWorld {
    resource sayHello (http:Connection conn, http:InRequest req) {
        http:OutResponse res = {};
        res.setStringPayload("Hello, World from service helloWorld !");
        _ = conn.respond(res);
    }
}

