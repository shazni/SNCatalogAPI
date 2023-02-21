import ballerina/graphql;

configurable int port = 9090;

service class ItemGphqlType {
    private final Item item;

    function init(Item item) {
        self.item = item;
    }

    resource function get id() returns int {
        return self.item.id;
    }

    resource function get name() returns string {
        return self.item.name;
    }

    resource function get description() returns string {
        return self.item.description;
    }

    resource function get includeDetail() returns string {
        return self.item.includeDetail;
    }

    resource function get includedFor() returns string {
        return self.item.includedFor;
    }

    resource function get color() returns string {
        return self.item.color;
    }

    resource function get material() returns string {
        return self.item.material;
    }

    resource function get price() returns decimal {
        return self.item.price;
    }
}

service /snitemgraphql on new graphql:Listener(port) {

    resource function get items() returns ItemGphqlType[]|error? {
        Item[]|error items = getAllItems();

        if items is error {
            return items;
        }

        ItemGphqlType[] itemGraphQLEntries = [];
        foreach Item? item in items {
            ItemGphqlType itemGraphQLEntry = new(item);
            itemGraphQLEntries.push(itemGraphQLEntry);
        }

        return itemGraphQLEntries;
    }
}
