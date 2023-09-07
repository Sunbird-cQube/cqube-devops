jwtToken=$(curl --location --request GET "https://80-${GITPOD_WORKSPACE_URL:8}/api/ingestion/generateJWT")

echo "Generated JWT TOKEN $jwtToken"

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "grade",
    "dimension_name": "grade",
    "input": {
        "type": "object",
        "properties": {
            "grade_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "grade": {
                "type": "string",
                "shouldNotNull": true
            }
        },
        "required":[
            "grade_id",
            "grade"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "medium",
    "input": {
        "type": "object",
        "properties": {
            "medium_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "medium": {
                "type": "string",
                "shouldNotNull": true
            }
        },
        "required":[
            "medium_id",
            "medium"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "state",
    "input": {
        "type": "object",
        "properties": {
            "state_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "state_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "latitude":{
                "type": "number",
                "shouldNotNull": false
            },
            "longitude":{
                "type": "number",
                "shouldNotNull": false
            }
        },
        "required":[
            "state_id",
            "state_name",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "school",
    "input": {
        "type": "object",
        "properties": {
            "school_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "udise_code": {
                "type": "string",
                "shouldNotNull": true
            },
            "school_name":{
                "type": "string",
                "shouldNotNull": true
            },
            "schoolcategory_id":{
                "type": "string",
                "shouldNotNull": false
            },
             "schoolmanagement_id":{
                "type": "string",
                "shouldNotNull": false
            },
            "school_statecategory_id":{
                "type": "string",
                "shouldNotNull": false
            },
            "cluster_id":{
                "type": "string",
                "shouldNotNull": true
            },
            "cluster_name":{
                "type": "string",
                "shouldNotNull": true
            },
            "block_id":{
                "type": "string",
                "shouldNotNull": true
            },
            "block_name":{
                "type": "string",
                "shouldNotNull": true
            },
            "district_id":{
                "type": "string",
                "shouldNotNull": true
            },
            "district_name":{
                "type": "string",
                "shouldNotNull": true
            },
            "latitude":{
                "type": "number",
                "shouldNotNull": false
            },
            "longitude":{
                "type": "number",
                "shouldNotNull": false
            }
        },
        "required":[
            "school_id",
            "udise_code",
            "school_name",
            "cluster_id",
            "cluster_name",
            "block_id",
            "block_name",
            "district_id",
            "district_name",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "subject",
    "input": {
        "type": "object",
        "properties": {
            "subject_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "subject": {
                "type": "string",
                "shouldNotNull": true
            }
        },
        "required":[
            "subject_id",
            "subject"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "exam",
    "input": {
        "type": "object",
        "properties": {
            "exam_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "academicyear_id": {
                "type": "string",
                "shouldNotNull": true
            },
             "exam_event": {
                "type": "string",
                "shouldNotNull": true
            }
        },
        "required":[
            "exam_id",
            "academicyear_id",
            "exam_event"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "district",
    "input": {
        "type": "object",
        "properties": {
            "district_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_name": {
                "type": "string",
                "shouldNotNull": true
            },
             "state_id": {
                "type": "string",
                "shouldNotNull": true
            },
             "state_name": {
                "type": "string",
                "shouldNotNull": true
            },
             "latitude": {
                "type": "number",
                "shouldNotNull": false
            },
             "longitude": {
                "type": "number",
                "shouldNotNull": false
            }
        },
        "required":[
            "district_id",
            "district_name",
            "state_id",
            "state_name",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "cluster",
    "input": {
        "type": "object",
        "properties": {
            "cluster_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "cluster_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "block_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "block_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "district_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "latitude": {
                "type": "number",
                "shouldNotNull": false
            },
            "longitude": {
                "type": "number",
                "shouldNotNull": false
            }
        },
        "required": [
            "cluster_id",
            "cluster_name",
            "block_id",
            "block_name",
            "district_id",
            "district_name",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "block",
    "input": {
        "type": "object",
        "properties": {
            "block_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "block_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "district_name": {
                "type": "string",
                "shouldNotNull": true
            },
            "latitude": {
                "type": "number",
                "shouldNotNull": false
            },
            "longitude": {
                "type": "number",
                "shouldNotNull": false
            }
        },
        "required": [
            "block_id",
            "block_name",
            "district_id",
            "district_name",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "academicyear",
    "input": {
        "type": "object",
        "properties": {
            "academicyear_id": {
                "type": "string",
                "shouldNotNull": true
            },
            "academicyear": {
                "type": "string",
                "shouldNotNull": true
            }
        },
        "required": [
            "academicyear_id",
            "academicyear"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "schoolcategory",
    "input": {
        "type": "object",
        "properties": {
            "schoolcategory_id": {
                "type": "string",
                "shouldnotnull": true
            },
            "schoolcategory_name": {
                "type": "string",
                "shouldnotnull": true
            },
             "grades": {
                "type": "string",
                "shouldnotnull": true
            }      
        },
        "required": [
            "schoolcategory_id",
            "schoolcategory_name"
           
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "statecategory",
    "input": {
        "type": "object",
        "properties": {
            "school_statecategory_id": {
                "type": "string",
                "shouldnotnull": true
            },
            "school_statecategory_name": {
                "type": "string",
                "shouldnotnull": true
            }   
        },
        "required": [
            "school_statecategory_id",
            "school_statecategory_name"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/dimension" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "schoolmanagement",
    "input": {
        "type": "object",
        "properties": {
            "schoolmanagement_id": {
                "type": "string",
                "shouldnotnull": true
            },
            "schoolmanagement_name": {
                "type": "string",
                "shouldnotnull": true
            }
        },
        "required": [
            "schoolmanagement_id",
            "schoolmanagement_name"
        ]
    }
}'


