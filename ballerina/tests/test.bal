// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

configurable string clientId = "<HUBSPOT_CLIENT_ID>";
configurable string clientSecret = "<HUBSPOT_CLIENT_SECRET>";
configurable string refreshToken = "<HUBSPOT_REFRESH_TOKEN>";

configurable boolean isLiveServer = false;

final Client hubspot = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, "https://api.hubapi.com/crm/v3/objects/communications");
    }

    return check new ({
        auth: {
            token: "test-token"
        }
    }, "http://localhost:9090");
}

isolated string testCommunicationId = "";
isolated string[] testBatchIds = [];

final string testAssociateId1 = "83849040631";
final string testAssociateId2 = "83849299661";
final int contactAssociationTypeId = 81;
final string testOwnerId = "77366318";

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testCreateMessage() returns error? {
    SimplePublicObject response = check hubspot->/.post(
        payload = {
            properties: {
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hubspot_owner_id": testOwnerId
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
                        id: testAssociateId1
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
                        id: testAssociateId2
                    }
                }
            ]
        }
    );

    test:assertEquals(response?.properties["hs_communication_body"], "Texted Linda to confirm that we're ready to move forward with the contract.", "Response is not an instance of SimplePublicObject");

    lock {
        testCommunicationId = response.id;
    }

}

@test:Config {
    dependsOn: [testCreateMessage],
    groups: ["live_test", "mock_tests"]
}
isolated function testGetMessages() returns error? {

    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/.get();

    test:assertTrue(response?.results.length() > 0, "Response is not an array of BatchResponseSimplePublicObject");
}

@test:Config {
    dependsOn: [testCreateMessage],
    groups: ["live_test", "mock_tests"]
}
isolated function testGetMessageById() returns error? {

    string testId = "";

    lock {
        testId = testCommunicationId;
    }

    SimplePublicObjectWithAssociations response = check hubspot->/[testId].get();

    test:assertEquals(response?.properties["hs_object_id"], testId, "Response is not an instance of SimplePublicObjectWithAssociations");
}

@test:Config {
    dependsOn: [testCreateMessage],
    groups: ["live_test", "mock_tests"]
}
isolated function testUpdateMessage() returns error? {
    string testId = "";

    lock {
        testId = testCommunicationId;
    }

    SimplePublicObject response = check hubspot->/[testId].patch(
        payload = {
            properties: {
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hubspot_owner_id": testOwnerId
            }
        }
    );

    test:assertEquals(response?.properties["hs_communication_body"], "Texted Linda to confirm that we're ready to move forward with the contract.", "Response is not an instance of SimplePublicObject");
}

@test:Config {
    dependsOn: [testCreateMessage, testGetMessages, testGetMessageById, testUpdateMessage],
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteMessage() returns error? {
    string testId = "";

    lock {
        testId = testCommunicationId;
    }

    http:Response response = check hubspot->/[testId].delete();

    test:assertEquals(response.statusCode == 204, true, "Failed to delete the message");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testCreateBatchOfMessages() returns error? {

    BatchResponseSimplePublicObject response = check hubspot->/batch/create.post(
        payload = {
            inputs: [
                {
                    properties: {
                        "hs_communication_channel_type": "SMS",
                        "hs_communication_logged_from": "CRM",
                        "hs_communication_body": "Called Harry to discuss the contract.",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hubspot_owner_id": testOwnerId
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
                                id: testAssociateId1
                            }
                        }
                    ]
                },
                {
                    properties: {
                        "hs_communication_channel_type": "WHATS_APP",
                        "hs_communication_logged_from": "CRM",
                        "hs_communication_body": "Sent an email to Harry to discuss the contract.",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hubspot_owner_id": testOwnerId
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
                                id: testAssociateId2
                            }
                        }
                    ]
                },
                {
                    properties: {
                        "hs_communication_channel_type": "LINKEDIN_MESSAGE",
                        "hs_communication_logged_from": "CRM",
                        "hs_communication_body": "Sent an email to Harry to discuss the contract.",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hubspot_owner_id": testOwnerId
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
                                id: testAssociateId1
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
                                id: testAssociateId2
                            }
                        }
                    ]
                }
            ]
        }
    );

    string[] batchIds = response.results.map((result) => result.id);
    lock {
        testBatchIds = batchIds.clone();
    }

    test:assertTrue(response?.results.length() > 0, "Response is not an instance of BatchResponseSimplePublicObject");
}

@test:Config {
    dependsOn: [testCreateBatchOfMessages],
    groups: ["live_test", "mock_tests"]
}
isolated function testRetrieveBatchOfMessages() returns error? {

    string[] testIds = [];

    lock {
        testIds = testBatchIds.clone();
    }

    BatchResponseSimplePublicObject response = check hubspot->/batch/read.post(
        payload = {
            properties: ["hs_timestamp", "hs_communication_channel_type"],
            propertiesWithHistory: ["hs_communication_body", "hs_createdate"],
            inputs: [
                {id: testIds[0]},
                {id: testIds[1]},
                {id: testIds[2]}
            ]
        }
    );

    test:assertTrue(response?.results.length() > 0, "Response is not an instance of BatchResponseSimplePublicObject");
};

@test:Config {
    dependsOn: [testCreateBatchOfMessages, testRetrieveBatchOfMessages],
    groups: ["live_test", "mock_tests"]
}
isolated function testUpdateBatchOfMessages() returns error? {
    string[] testIds = [];

    lock {
        testIds = testBatchIds.clone();
    }

    BatchResponseSimplePublicObject response = check hubspot->/batch/update.post(
        payload = {
            inputs: [
                {
                    properties: {
                        "hs_communication_body": "Called Linda to discuss the contract."
                    },
                    id: testIds[0]
                },
                {
                    properties: {
                        "hs_communication_body": "Sent an email to Linda to discuss the contract."
                    },
                    id: testIds[1]
                },
                {
                    properties: {
                        "hs_communication_body": "Sent an email to Linda to discuss the contract."
                    },
                    id: testIds[2]
                }
            ]
        }
    );

    test:assertTrue(response?.results.length() > 0, "Response is not an instance of BatchResponseSimplePublicObject");
}

@test:Config {
    dependsOn: [testCreateBatchOfMessages, testRetrieveBatchOfMessages, testUpdateBatchOfMessages],
    groups: ["mock_tests"]
}
isolated function testArchiveBatchOfMessages() returns error? {
    string[] testIds = [];

    lock {
        testIds = testBatchIds.clone();
    }

    http:Response response = check hubspot->/batch/archive.post(
        payload = {
            inputs: [
                {id: testIds[0]},
                {id: testIds[1]},
                {id: testIds[2]}
            ]
        }
    );

    test:assertEquals(response.statusCode == 204, true, "Failed to delete the batch of messages");
}

@test:Config {
    dependsOn: [testCreateBatchOfMessages],
    groups: ["live_test", "mock_tests"]
}
isolated function testSearchMessage() returns error? {
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspot->/search.post(
        payload = {
            query: "Linda"
        }
    );

    test:assertTrue(response?.results.length() > 0, "Response is not an instance of CollectionResponseSimplePublicObject");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testInvalidMessageId() returns error? {
    string testId = "invalid-id";

    SimplePublicObjectWithAssociations|error response = hubspot->/[testId].get();

    test:assertTrue(response is error, "Response is not an error");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testInvalidBatchId() returns error? {
    string testId = "invalid-id";

    BatchResponseSimplePublicObject response = check hubspot->/batch/read.post(
        payload = {
            properties: ["hs_timestamp", "hs_communication_channel_type"],
            propertiesWithHistory: ["hs_communication_body", "hs_createdate"],
            inputs: [
                {id: testId}
            ]
        }
    );

    test:assertEquals(response?.results.length(), 0, "Response is not an error");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testInvalidBatchUpdate() returns error? {
    string testId = "invalid-id";

    BatchResponseSimplePublicObject response = check hubspot->/batch/update.post(
        payload = {
            inputs: [
                {
                    properties: {
                        "hs_communication_body": "Called Linda to discuss the contract."
                    },
                    id: testId
                }
            ]
        }
    );

    test:assertEquals(response?.results.length(), 0, "Response is not an error");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testInvalidBatchArchive() returns error? {
    string testId = "invalid-id";

    http:Response response = check hubspot->/batch/archive.post(
        payload = {
            inputs: [
                {id: testId}
            ]
        }
    );

    test:assertEquals(response.statusCode == 400, true, "Response is not an error");
}

@test:Config {
    groups: ["live_test", "mock_tests"]
}
isolated function testInvalidSearch() returns error? {
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspot->/search.post(
        payload = {
            query: "invalid-query"
        }
    );

    test:assertEquals(response?.total, 0, "Response is not an error");
}
