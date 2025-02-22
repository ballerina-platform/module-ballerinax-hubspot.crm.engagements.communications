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
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {
    # Archive a message
    #
    # + communicationId - The ID of the message to update.
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete [string communicationId]() returns http:NoContent {
        return http:NO_CONTENT;
    }

    # Retrieve messages
    #
    # + 'limit - The maximum number of results to display per page.
    # + after - The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored. Usage of this parameter will reduce the maximum number of objects that can be read by a single request.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get .(string? after, string[]? properties, string[]? propertiesWithHistory, string[]? associations, int:Signed32 'limit = 10, boolean archived = false) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging {
        CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = {
            results: [
                {
                    id: "77033252581",
                    properties: {
                        "hs_createdate": "2025-02-17T05:42:30.324Z",
                        "hs_lastmodifieddate": "2025-02-17T05:42:30.695Z",
                        "hs_object_id": "77033252581"
                    },
                    createdAt: "2025-02-17T05:42:30.324Z",
                    updatedAt: "2025-02-17T05:42:30.695Z",
                    archived: false
                },
                {
                    id: "77033659082",
                    properties: {
                        "hs_createdate": "2025-02-17T09:37:12.237Z",
                        "hs_lastmodifieddate": "2025-02-17T09:37:12.759Z",
                        "hs_object_id": "77033659082"
                    },
                    createdAt: "2025-02-17T09:37:12.237Z",
                    updatedAt: "2025-02-17T09:37:12.759Z",
                    archived: false
                },
                {
                    id: "77033660107",
                    properties: {
                        "hs_createdate": "2025-02-17T09:40:19.594Z",
                        "hs_lastmodifieddate": "2025-02-17T09:40:20.286Z",
                        "hs_object_id": "77033660107"
                    },
                    createdAt: "2025-02-17T09:40:19.594Z",
                    updatedAt: "2025-02-17T09:40:20.286Z",
                    archived: false
                },
                {
                    id: "77060898503",
                    properties: {
                        "hs_createdate": "2025-02-17T09:37:11.622Z",
                        "hs_lastmodifieddate": "2025-02-17T09:37:12.279Z",
                        "hs_object_id": "77060898503"
                    },
                    createdAt: "2025-02-17T09:37:11.622Z",
                    updatedAt: "2025-02-17T09:37:12.279Z",
                    archived: false
                },
                {
                    id: "77060898504",
                    properties: {
                        "hs_createdate": "2025-02-17T09:37:11.622Z",
                        "hs_lastmodifieddate": "2025-02-17T09:37:12.028Z",
                        "hs_object_id": "77060898504"
                    },
                    createdAt: "2025-02-17T09:37:11.622Z",
                    updatedAt: "2025-02-17T09:37:12.028Z",
                    archived: false
                },
                {
                    id: "77060898505",
                    properties: {
                        "hs_createdate": "2025-02-17T09:37:11.622Z",
                        "hs_lastmodifieddate": "2025-02-17T09:37:12.279Z",
                        "hs_object_id": "77060898505"
                    },
                    createdAt: "2025-02-17T09:37:11.622Z",
                    updatedAt: "2025-02-17T09:37:12.279Z",
                    archived: false
                },
                {
                    id: "77060899528",
                    properties: {
                        "hs_createdate": "2025-02-17T09:40:19.079Z",
                        "hs_lastmodifieddate": "2025-02-17T09:40:19.715Z",
                        "hs_object_id": "77060899528"
                    },
                    createdAt: "2025-02-17T09:40:19.079Z",
                    updatedAt: "2025-02-17T09:40:19.715Z",
                    archived: false
                },
                {
                    id: "77064474346",
                    properties: {
                        "hs_createdate": "2025-02-17T05:40:33.136Z",
                        "hs_lastmodifieddate": "2025-02-17T05:40:33.797Z",
                        "hs_object_id": "77064474346"
                    },
                    createdAt: "2025-02-17T05:40:33.136Z",
                    updatedAt: "2025-02-17T05:40:33.797Z",
                    archived: false
                },
                {
                    id: "77064688348",
                    properties: {
                        "hs_createdate": "2025-02-17T11:17:33.698Z",
                        "hs_lastmodifieddate": "2025-02-17T11:17:34.155Z",
                        "hs_object_id": "77064688348"
                    },
                    createdAt: "2025-02-17T11:17:33.698Z",
                    updatedAt: "2025-02-17T11:17:34.155Z",
                    archived: false
                },
                {
                    id: "77082006227",
                    properties: {
                        "hs_createdate": "2025-02-17T08:43:21.034Z",
                        "hs_lastmodifieddate": "2025-02-17T08:43:21.518Z",
                        "hs_object_id": "77082006227"
                    },
                    createdAt: "2025-02-17T08:43:21.034Z",
                    updatedAt: "2025-02-17T08:43:21.518Z",
                    archived: false
                }
            ],
            paging: {
                next: {
                    after: "77082006228",
                    link: "https://api.hubapi.com/crm/v3/objects/communications?after=77082006228"
                }
            }
        };

        return response;
    }

    # Retrieve a message
    #
    # + communicationId - The ID of the message to retrieve.
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + idProperty - The name of a property whose values are unique.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get [string communicationId](string[]? properties, string[]? propertiesWithHistory, string[]? associations, string? idProperty, boolean archived = false) returns SimplePublicObjectWithAssociations|error {
        if communicationId == "77255754471" {
            SimplePublicObjectWithAssociations response = {
                id: "77255754471",
                properties: {
                    "hs_createdate": "2025-02-18T04:22:43.937Z",
                    "hs_lastmodifieddate": "2025-02-18T04:22:43.937Z",
                    "hs_object_id": "77255754471"
                },
                createdAt: "2025-02-17T05:42:30.324Z",
                updatedAt: "2025-02-17T05:42:30.695Z",
                archived: false
            };

            return response;
        }

        return error("Communication ID not found");
    }

    # Update a message
    #
    # + communicationId - The ID of the communication to update.
    # + idProperty - The name of a property whose values are unique for this object
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function patch [string communicationId](string? idProperty, @http:Payload SimplePublicObjectInput payload) returns SimplePublicObject {
        SimplePublicObject response = {
            id: "77255754471",
            properties: {
                "hs_all_owner_ids": "77366318",
                "hs_body_preview": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Texted Linda to confirm that we're ready to move forward with the contract.\n </body>\n</html>",
                "hs_body_preview_is_truncated": "false",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_createdate": "2025-02-18T04:22:43.937Z",
                "hs_lastmodifieddate": "2025-02-18T04:22:43.937Z",
                "hs_object_id": "77255754471",
                "hs_object_source": "INTEGRATION",
                "hs_object_source_id": "8113404",
                "hs_object_source_label": "INTEGRATION",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hs_user_ids_of_all_owners": "77366318",
                "hubspot_owner_assigneddate": "2025-02-18T04:22:43.937Z",
                "hubspot_owner_id": "77366318"
            },
            createdAt: "2025-02-18T04:22:43.937Z",
            updatedAt: "2025-02-18T04:22:43.937Z",
            archived: false
        };

        return response;
    }

    # Create a communication
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post .(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject {
        SimplePublicObject response = {
            id: "77255754471",
            properties: {
                "hs_all_owner_ids": "77366318",
                "hs_body_preview": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Texted Linda to confirm that we're ready to move forward with the contract.\n </body>\n</html>",
                "hs_body_preview_is_truncated": "false",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_createdate": "2025-02-18T04:22:43.937Z",
                "hs_lastmodifieddate": "2025-02-18T04:22:43.937Z",
                "hs_object_id": "77255754471",
                "hs_object_source": "INTEGRATION",
                "hs_object_source_id": "8113404",
                "hs_object_source_label": "INTEGRATION",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hs_user_ids_of_all_owners": "77366318",
                "hubspot_owner_assigneddate": "2025-02-18T04:22:43.937Z",
                "hubspot_owner_id": "77366318"
            },
            createdAt: "2025-02-18T04:22:43.937Z",
            updatedAt: "2025-02-18T04:22:43.937Z",
            archived: false
        };
        return response;
    }

    # Archive a batch of messages
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/archive(@http:Payload BatchInputSimplePublicObjectId payload) returns http:NoContent|http:BadRequest {
        if payload.inputs[0].id == "invalid-id" {
            return http:BAD_REQUEST;
        }
        return http:NO_CONTENT;
    }

    # Create a batch of messages
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/create(@http:Payload BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject {
        BatchResponseSimplePublicObject response = {
            status: "COMPLETE",
            results: [
                {
                    id: "77466931932",
                    properties: {
                        "hs_all_owner_ids": "77366318",
                        "hs_body_preview": "Called Harry to discuss the contract.",
                        "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Called Harry to discuss the contract.\n </body>\n</html>",
                        "hs_body_preview_is_truncated": "false",
                        "hs_communication_body": "Called Harry to discuss the contract.",
                        "hs_communication_channel_type": "SMS",
                        "hs_communication_logged_from": "CRM",
                        "hs_createdate": "2025-02-18T05:51:18.584Z",
                        "hs_lastmodifieddate": "2025-02-18T05:51:18.584Z",
                        "hs_object_id": "77466931932",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8113404",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hs_user_ids_of_all_owners": "77366318",
                        "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                        "hubspot_owner_id": "77366318"
                    },
                    createdAt: "2025-02-18T05:51:18.584Z",
                    updatedAt: "2025-02-18T05:51:18.584Z",
                    archived: false
                },
                {
                    id: "77466931934",
                    properties: {
                        "hs_all_owner_ids": "77366318",
                        "hs_body_preview": "Called Harry to discuss the contract.",
                        "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Called Harry to discuss the contract.\n </body>\n</html>",
                        "hs_body_preview_is_truncated": "false",
                        "hs_communication_body": "Called Harry to discuss the contract.",
                        "hs_communication_channel_type": "LINKEDIN_MESSAGE",
                        "hs_communication_logged_from": "CRM",
                        "hs_createdate": "2025-02-18T05:51:18.584Z",
                        "hs_lastmodifieddate": "2025-02-18T05:51:18.584Z",
                        "hs_object_id": "77466931934",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8113404",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hs_user_ids_of_all_owners": "77366318",
                        "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                        "hubspot_owner_id": "77366318"
                    },
                    createdAt: "2025-02-18T05:51:18.584Z",
                    updatedAt: "2025-02-18T05:51:18.584Z",
                    archived: false
                },
                {
                    id: "77466931933",
                    properties: {
                        "hs_all_owner_ids": "77366318",
                        "hs_body_preview": "Called Harry to discuss the contract.",
                        "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Called Harry to discuss the contract.\n </body>\n</html>",
                        "hs_body_preview_is_truncated": "false",
                        "hs_communication_body": "Called Harry to discuss the contract.",
                        "hs_communication_channel_type": "WHATS_APP",
                        "hs_communication_logged_from": "CRM",
                        "hs_createdate": "2025-02-18T05:51:18.584Z",
                        "hs_lastmodifieddate": "2025-02-18T05:51:18.584Z",
                        "hs_object_id": "77466931933",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8113404",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_timestamp": "2022-11-12T15:48:22Z",
                        "hs_user_ids_of_all_owners": "77366318",
                        "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                        "hubspot_owner_id": "77366318"
                    },
                    createdAt: "2025-02-18T05:51:18.584Z",
                    updatedAt: "2025-02-18T05:51:18.584Z",
                    archived: false
                }
            ],
            startedAt: "2025-02-18T05:51:18.568Z",
            completedAt: "2025-02-18T05:51:18.955Z"
        };

        return response;
    }

    # Retrieve a batch of messages
    #
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/read(@http:Payload BatchReadInputSimplePublicObjectId payload, boolean archived = false) returns BatchResponseSimplePublicObject|error {
        BatchResponseSimplePublicObject response;
        if payload.inputs[0].id == "invalid-id" {
            response = {
                status: "COMPLETE",
                results: [],
                "numErrors": 1,
                "errors": [
                    {
                        status: "error",
                        category: "OBJECT_NOT_FOUND",
                        message: "Could not get some COMMUNICATION objects, they may be deleted or not exist. Check that ids are valid.",
                        context: {
                            ids: [
                                "invalid"
                            ]
                        }
                    }
                ],
                startedAt: "2025-02-18T09:12:17Z",
                completedAt: "2025-02-18T09:12:17.006Z"
            };
        } else {
            response = {
                status: "COMPLETE",
                results: [
                    {
                        id: "77466931933",
                        properties: {
                            "hs_communication_channel_type": "WHATS_APP",
                            "hs_lastmodifieddate": "2025-02-18T05:51:19.141Z",
                            "hs_object_id": "77466931933",
                            "hs_timestamp": "2022-11-12T15:48:22Z"
                        },
                        propertiesWithHistory: {
                            "hs_communication_body": [
                                {
                                    value: "Called Harry to discuss the contract.",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ],
                            "hs_createdate": [
                                {
                                    value: "2025-02-18T05:51:18.584Z",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ]
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T05:51:19.141Z",
                        archived: false
                    },
                    {
                        id: "77466931932",
                        properties: {
                            "hs_communication_channel_type": "SMS",
                            "hs_lastmodifieddate": "2025-02-18T05:51:19.141Z",
                            "hs_object_id": "77466931932",
                            "hs_timestamp": "2022-11-12T15:48:22Z"
                        },
                        propertiesWithHistory: {
                            "hs_communication_body": [
                                {
                                    value: "Called Harry to discuss the contract.",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ],
                            "hs_createdate": [
                                {
                                    value: "2025-02-18T05:51:18.584Z",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ]
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T05:51:19.141Z",
                        archived: false
                    },
                    {
                        id: "77466931934",
                        properties: {
                            "hs_communication_channel_type": "LINKEDIN_MESSAGE",
                            "hs_lastmodifieddate": "2025-02-18T05:51:19.141Z",
                            "hs_object_id": "77466931934",
                            "hs_timestamp": "2022-11-12T15:48:22Z"
                        },
                        propertiesWithHistory: {
                            "hs_communication_body": [
                                {
                                    value: "Called Harry to discuss the contract.",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ],
                            "hs_createdate": [
                                {
                                    value: "2025-02-18T05:51:18.584Z",
                                    timestamp: "2025-02-18T05:51:18.584Z",
                                    sourceType: "INTEGRATION",
                                    sourceId: "8113404"
                                }
                            ]
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T05:51:19.141Z",
                        archived: false
                    }
                ],
                startedAt: "2025-02-18T06:05:18.015Z",
                completedAt: "2025-02-18T06:05:18.031Z"
            };
        }
        return response;
    }

    # Update a batch of messages
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/update(@http:Payload BatchInputSimplePublicObjectBatchInput payload) returns BatchResponseSimplePublicObject|error {
        BatchResponseSimplePublicObject response;

        if payload.inputs[0].id == "invalid-id" {
            response = {
                status: "COMPLETE",
                results: [],
                "numErrors": 1,
                "errors": [
                    {
                        status: "error",
                        category: "OBJECT_NOT_FOUND",
                        message: "Could not get some COMMUNICATION objects, they may be deleted or not exist. Check that ids are valid.",
                        context: {
                            ids: [
                                "invalid"
                            ]
                        }
                    }
                ],
                startedAt: "2025-02-18T09:17:15.266Z",
                completedAt: "2025-02-18T09:17:15.273Z"
            };
        } else {
            response = {
                status: "COMPLETE",
                results: [
                    {
                        id: "77466931932",
                        properties: {
                            "hs_all_owner_ids": "77366318",
                            "hs_body_preview": "Called Linda to discuss the contract.",
                            "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Called Linda to discuss the contract.\n </body>\n</html>",
                            "hs_body_preview_is_truncated": "false",
                            "hs_communication_body": "Called Linda to discuss the contract.",
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:07:54.506Z",
                            "hs_object_id": "77466931932",
                            "hs_object_source": "INTEGRATION",
                            "hs_object_source_id": "8113404",
                            "hs_object_source_label": "INTEGRATION",
                            "hs_user_ids_of_all_owners": "77366318",
                            "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                            "hubspot_owner_id": "77366318"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:07:54.506Z",
                        archived: false
                    },
                    {
                        id: "77466931933",
                        properties: {
                            "hs_all_owner_ids": "77366318",
                            "hs_body_preview": "Sent an email to Linda to discuss the contract.",
                            "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Sent an email to Linda to discuss the contract.\n </body>\n</html>",
                            "hs_body_preview_is_truncated": "false",
                            "hs_communication_body": "Sent an email to Linda to discuss the contract.",
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:09:21.372Z",
                            "hs_object_id": "77466931933",
                            "hs_object_source": "INTEGRATION",
                            "hs_object_source_id": "8113404",
                            "hs_object_source_label": "INTEGRATION",
                            "hs_user_ids_of_all_owners": "77366318",
                            "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                            "hubspot_owner_id": "77366318"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:09:21.372Z",
                        archived: false
                    },
                    {
                        id: "77466931934",
                        properties: {
                            "hs_all_owner_ids": "77366318",
                            "hs_body_preview": "Sent an email to Linda to discuss the contract.",
                            "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Sent an email to Linda to discuss the contract.\n </body>\n</html>",
                            "hs_body_preview_is_truncated": "false",
                            "hs_communication_body": "Sent an email to Linda to discuss the contract.",
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:09:21.372Z",
                            "hs_object_id": "77466931934",
                            "hs_object_source": "INTEGRATION",
                            "hs_object_source_id": "8113404",
                            "hs_object_source_label": "INTEGRATION",
                            "hs_user_ids_of_all_owners": "77366318",
                            "hubspot_owner_assigneddate": "2025-02-18T05:51:18.584Z",
                            "hubspot_owner_id": "77366318"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:09:21.372Z",
                        archived: false
                    }
                ],
                startedAt: "2025-02-18T06:09:21.352Z",
                completedAt: "2025-02-18T06:09:21.484Z"
            };
        }
        return response;
    }

    # Create and and update a batch of messages
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    // resource function post batch/upsert(@http:Payload BatchInputSimplePublicObjectBatchInputUpsert payload) returns BatchResponseSimplePublicObject {
    // }

    # Search for messages
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post search(@http:Payload PublicObjectSearchRequest payload) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error {
        CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response;
        if payload.query == "invalid-query" {
            response = {
                "total": 0,
                results: []
            };
        } else {
            response = {
                "total": 3,
                results: [
                    {
                        id: "77466931932",
                        properties: {
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:07:54.506Z",
                            "hs_object_id": "77466931932"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:07:54.506Z",
                        archived: false
                    },
                    {
                        id: "77466931933",
                        properties: {
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:09:21.372Z",
                            "hs_object_id": "77466931933"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:09:21.372Z",
                        archived: false
                    },
                    {
                        id: "77466931934",
                        properties: {
                            "hs_createdate": "2025-02-18T05:51:18.584Z",
                            "hs_lastmodifieddate": "2025-02-18T06:09:21.372Z",
                            "hs_object_id": "77466931934"
                        },
                        createdAt: "2025-02-18T05:51:18.584Z",
                        updatedAt: "2025-02-18T06:09:21.372Z",
                        archived: false
                    }
                ]
            };
        }
        return response;
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock service initialization. Tests are configured to run against live server.");
        return;
    }
    log:printInfo("Tests are configured to run against mock server. Initializing mock service...");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
