import ballerinax/mysql;

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

public type Item record {
    int id;
    string name;
    string description;
    string includeDetail;
    string includedFor;
    string color;
    string material;
    decimal price;
};

final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database=DATABASE, connectionPool={maxOpenConnections: 3}
);

isolated function getAllItems() returns Item[]|error {
    stream<Item, error?> resultStream = dbClient->query(`    
        SELECT id, name, description, includeDetail, includedFor, color, material, price from SNStoreItem;
    `);

    Item[] products = [];
    check from Item product in resultStream
        do {
            products.push(product);
        };
    check resultStream.close();
    return products;
}