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

const string COMMUNICATION_CHANNEL_TYPE = "WHATS_APP";
const string COMMUNICATION_LOGGED_FROM = "CRM";
const string HUBSPOT_OWNER_ID = "77366318";
const string HUBSPOT_ASSOCIATE_ID_1 = "83849040631";
const string HUBSPOT_ASSOCIATE_ID_2 = "83849299661";

public function main() returns error? {
    hscommunications:SimplePublicObject postCommunication = check hubspot->/.post(
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
        }
    );

    io:println("Posted communication: ", postCommunication, "\n");

    hscommunications:SimplePublicObject getCommunication = check hubspot->/[postCommunication?.id].get();

    io:println("Retrieved communication: ", getCommunication, "\n");

    hscommunications:CollectionResponseWithTotalSimplePublicObjectForwardPaging getWhatsappMessages = check hubspot->/search.post(
        {
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

    hscommunications:SimplePublicObject updateCommunication = check hubspot->/[postCommunication?.id].patch(
        {
            properties: {
                "hs_communication_body": "Hello Maria, you can find the requested product catalog attached here. Please let me know if you need any further assistance."
            }
        }
    );

    io:println("Updated communication: ", updateCommunication, "\n");

    http:Response deleteCommunication = check hubspot->/[postCommunication?.id].delete();

    if deleteCommunication.statusCode == 204 {
        io:println("Deleted communication successfully\n");
    } else {
        io:println("Failed to delete communication\n");
    }
}
