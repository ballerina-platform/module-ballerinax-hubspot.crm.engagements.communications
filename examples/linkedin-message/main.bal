import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerina/time;
import ballerinax/hubspot.crm.engagements.communications as hscommunications;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

hscommunications:ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};

final hscommunications:Client hubspot = check new (config);

const string COMMUNICATION_CHANNEL_TYPE = "LINKEDIN_MESSAGE";
const string COMMUNICATION_LOGGED_FROM = "CRM";
const string HUBSPOT_OWNER_ID = "77366318";
const string HUBSPOT_ASSOCIATE_ID_1 = "83849040631";
const string HUBSPOT_ASSOCIATE_ID_2 = "83849299661";

public function main() returns error? {
    hscommunications:BatchResponseSimplePublicObject postBatchOfCommunications = check hubspot->/batch/create.post(
        {
            inputs: [
                {
                    properties: {
                        "hs_communication_channel_type": COMMUNICATION_CHANNEL_TYPE,
                        "hs_communication_logged_from": COMMUNICATION_LOGGED_FROM,
                        "hs_communication_body": "Hello Maria, you can find the requested product catalog attached here.",
                        "hs_timestamp": time:utcToString(time:utcNow()),
                        "hubspot_owner_id": HUBSPOT_OWNER_ID
                    },
                    associations: [
                        {
                            types: [
                                {
                                    associationCategory: "HUBSPOT_DEFINED",
                                    associationTypeId: 81
                                }
                            ],
                            to: {
                                id: HUBSPOT_ASSOCIATE_ID_1
                            }
                        }
                    ]
                },
                {
                    properties: {
                        "hs_communication_channel_type": COMMUNICATION_CHANNEL_TYPE,
                        "hs_communication_logged_from": COMMUNICATION_LOGGED_FROM,
                        "hs_communication_body": "Hello John, you can find the requested product catalog attached here.",
                        "hs_timestamp": time:utcToString(time:utcNow()),
                        "hubspot_owner_id": HUBSPOT_OWNER_ID
                    },
                    associations: [
                        {
                            types: [
                                {
                                    associationCategory: "HUBSPOT_DEFINED",
                                    associationTypeId: 81
                                }
                            ],
                            to: {
                                id: HUBSPOT_ASSOCIATE_ID_2
                            }
                        }
                    ]
                }
            ]
        }
    );

    io:println("Posted communication: ", postBatchOfCommunications, "\n");

    hscommunications:BatchResponseSimplePublicObject updateBatchOfCommunications = check hubspot->/batch/update.post(
        {
            inputs: [
                {
                    id: postBatchOfCommunications.results[0].id,
                    properties: {
                        "hs_communication_body": "Hello Maria, you can find the requested product catalog attached here. Please let me know if you need any further information.",
                        "hs_timestamp": time:utcToString(time:utcNow())
                    }
                },
                {
                    id: postBatchOfCommunications.results[1].id,
                    properties: {
                        "hs_communication_body": "Hello John, you can find the requested product catalog attached here. Please let me know if you need any further information.",
                        "hs_timestamp": time:utcToString(time:utcNow())
                    }
                }
            ]
        }
    );

    io:println("Updated communication: ", updateBatchOfCommunications, "\n");

    hscommunications:BatchResponseSimplePublicObject getBatchOfCommunications = check hubspot->/batch/read.post(
        {
            propertiesWithHistory: ["hs_communication_body", "hs_timestamp"],
            properties: ["hs_communication_channel_type", "hs_communication_logged_from", "hubspot_owner_id"],
            inputs: [
                {
                    id: postBatchOfCommunications.results[0].id
                },
                {
                    id: postBatchOfCommunications.results[1].id
                }
            ]
        }
    );

    io:println("Retrieved communication: ", getBatchOfCommunications, "\n");

    http:Response deleteBatchOfCommunications = check hubspot->/batch/archive.post(
        {
            inputs: [
                {
                    id: postBatchOfCommunications.results[0].id
                },
                {
                    id: postBatchOfCommunications.results[1].id
                }
            ]
        }
    );

    if (deleteBatchOfCommunications.statusCode == 204) {
        io:println("Deleted communication successfully");
    } else {
        io:println("Failed to delete communication");
    }
}
