import ballerina.kubernetes;
import ballerina.net.http;

@kubernetes:deployment {
    name:"foodstore",
    replicas:3,
    labels:"location:SL,city:COLOMBO"
}
@kubernetes:svc {}
@kubernetes:ingress {
    hostname:"pizza.com",
    path:"/pizzastore",
    targetPath:"/"
}
@http:configuration {
    basePath:"/pizza",
    port:9099
}
service<http> PizzaAPI {
    @http:resourceConfig {
        methods:["GET"],
        path:"/menu"
    }
    resource getPizzaMenu (http:Connection conn, http:InRequest req) {
        http:OutResponse res = {};
        res.setStringPayload("Get pizza menu");
        _ = conn.respond(res);
    }
}

@kubernetes:svc {}
@kubernetes:ingress {
    hostname:"burger.com",
    path:"/burgerstore",
    targetPath:"/"
}
@http:configuration {
    basePath:"/burger",
    port:9096
}
service<http> BurgerAPI {
    @http:resourceConfig {
        methods:["GET"],
        path:"/menu"
    }
    resource getBurgerMenu (http:Connection conn, http:InRequest req) {
        http:OutResponse res = {};
        res.setStringPayload("Get burger menu");
        _ = conn.respond(res);
    }
}
