import ballerina.log;
import ballerina.data.sql;
import ballerina.net.http;

@http:configuration {basePath:"/pet"}
service<http> petService {

    endpoint<sql:ClientConnector> petDB {
        create sql:ClientConnector(
        sql:DB.MYSQL, "localhost", 3306, "petdb", "root", "root", {maximumPoolSize:5});
    }

    @http:resourceConfig {methods:["GET"], path:"/all"}
    resource getAllPet (http:Connection conn, http:InRequest req) {
        log:printInfo("Retrieving All Pets");
        table dt = petDB.select("SELECT * FROM pet",null,null);
        var jsonRes, err = <json>dt;
        http:OutResponse resp = {};
        resp.setJsonPayload(jsonRes);
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["GET"], path:"/{id}"}
    resource getPet (http:Connection conn, http:InRequest req, string id) {
        log:printInfo("Retrieving a Pets");
        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.INTEGER, value:id};
        params=[para1];
        table dt = petDB.select("SELECT * FROM pet WHERE id=? ",params,null);
        var jsonRes, err = <json>dt;
        http:OutResponse resp = {};
        resp.setJsonPayload(jsonRes);
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["POST"], path:"/"}
    resource addPet (http:Connection conn, http:InRequest req) {
        log:printInfo("Adding Pet");
        json jsonMsg = req.getJsonPayload();
        var category, _ = (string)jsonMsg.category;
        var ageMonths, _ = (string)jsonMsg.ageMonths;
        var price, _= (string)jsonMsg.price;
        var imageURL, _= (string)jsonMsg.image;

        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:category};
        sql:Parameter para2 = {sqlType:sql:Type.TINYINT, value:ageMonths};
        sql:Parameter para3 = {sqlType:sql:Type.DECIMAL, value:price};
        sql:Parameter para4 = {sqlType:sql:Type.VARCHAR, value:imageURL};
        params = [para1, para2, para3, para4];
        int ret = petDB.update("INSERT INTO pet (CATEGORY,AGE,PRICE,IMAGE) VALUES (?,?,?,?)", params);
        log:printInfo("Inserted a PET and affected row count :" + ret);
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Added");
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["DELETE"], path:"/{id}"}
    resource deletePet (http:Connection conn, http:InRequest req, string id) {
        log:printInfo("Deleting Pet");
        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:id};
        params = [para1];
        int ret = petDB.update("DELETE FROM pet WHERE id=?", params);
        log:printInfo("Deleted a PET and affected row count :" + ret);
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Deleted");
        _ = conn.respond(resp);
    }
}


@http:configuration {basePath:"/category"}
service<http> petCategoryService {

    endpoint<sql:ClientConnector> petDB {
        create sql:ClientConnector(
        sql:DB.MYSQL, "localhost", 3306, "petdb", "root", "root", {maximumPoolSize:5});
    }

    @http:resourceConfig {methods:["GET"], path:"/all"}
    resource getAllPetCategory (http:Connection conn,http:InRequest req) {
        log:printInfo("Retrieving All Category");
        table dt = petDB.select("SELECT * FROM category",null,null);
        var jsonRes, err = <json>dt;
        http:OutResponse resp = {};
        resp.setJsonPayload(jsonRes);
        _ = conn.respond(resp);
    }
    

    @http:resourceConfig {methods:["POST"], path:"/"}
    resource addPetCategory (http:Connection conn, http:InRequest req) {
        log:printInfo("Adding Pet");
        json jsonMsg = req.getJsonPayload();
        var categoryName, _ = (string)jsonMsg.name;

        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:categoryName};
        params = [para1];
        int ret = petDB.update("INSERT INTO category (NAME) VALUES (?)", params);
        log:printInfo("Inserted a pet category and row count:" + ret);
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Category Added");
        _ = conn.respond(resp);
    }

    @http:resourceConfig {methods:["DELETE"], path:"/{id}"}
    resource deletePetCategory (http:Connection conn, http:InRequest req, string id) {
        log:printInfo("Deleting Pet Category");
        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:id};
        params = [para1];
        int ret = petDB.update("DELETE FROM category WHERE id=?", params);
        log:printInfo("Deleted a pet category and affected row count :" + ret);
        http:OutResponse resp = {};
        resp.setStringPayload("Pet Category Deleted");
        _ = conn.respond(resp);
    }

}