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

final hscommunications:Client baseClient = check new (config);

final string COMMUNICATION_CHANNEL_TYPE = "WHATS_APP";
final string COMMUNICATION_LOGGED_FROM = "CRM";
final string HUBSPOT_OWNER_ID = "77366318";
final string HUBSPOT_ASSOCIATE_ID_1 = "83849040631";
final string HUBSPOT_ASSOCIATE_ID_2 = "83849299661";

string communicationId = "";

public function main() returns error? {
    hscommunications:SimplePublicObject postCommunication = check baseClient->/.post(
        payload = {
            properties: {
                "hs_communication_channel_type": COMMUNICATION_CHANNEL_TYPE,
                "hs_communication_logged_from": COMMUNICATION_LOGGED_FROM,
                "hs_communication_body": "Check our latest products with 20% off!",
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
                },
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
    );

    communicationId = postCommunication.id;
    io:println("Posted communication: ", postCommunication, "\n");

    hscommunications:BatchResponseSimplePublicObject postBatchOfCommunications = check baseClient->/batch/create.post(
        payload = {
            inputs: [
                {
                    properties: {
                        "hs_communication_channel_type": COMMUNICATION_CHANNEL_TYPE,
                        "hs_communication_logged_from": COMMUNICATION_LOGGED_FROM,
                        "hs_communication_body": "Check our latest products with 20% off!",
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
                        },
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
                },
                {
                    properties: {
                        "hs_communication_channel_type": COMMUNICATION_CHANNEL_TYPE,
                        "hs_communication_logged_from": COMMUNICATION_LOGGED_FROM,
                        "hs_communication_body": "Don't miss our new year offers! Visit nearest showroom now.",
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

    io:println("Posted batch of communications: ", postBatchOfCommunications, "\n");

    hscommunications:CollectionResponseWithTotalSimplePublicObjectForwardPaging getWhatsappMessages = check baseClient->/search.post(
        payload = {
            filterGroups: [
                {
                    filters: [
                        {
                            propertyName: "hs_communication_channel_type",
                            value: COMMUNICATION_CHANNEL_TYPE,
                            operator: "EQ"
                        }
                    ]
                }
            ],
            'limit: 5
        }
    );

    io:println("Logged batch of communications: ", getWhatsappMessages, "\n");
}
