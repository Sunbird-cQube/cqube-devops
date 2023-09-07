jwtToken=$(curl --location --request GET "https://80-${GITPOD_WORKSPACE_URL:8}/api/ingestion/generateJWT")

echo "Generated JWT TOKEN $jwtToken"

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_etb_learning-session",
    "input": {
        "type": "object",
        "properties": {
            "board": {
                "type": "string",
                "shouldnotnull": true
            },
            "subject": {
                "type": "string",
                "shouldnotnull": true
            },
            "content_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "mime_type": {
                "type": "string",
                "shouldnotnull": true
            },
            "total_no_of_plays(App and Portal)": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_play_time(App and Portal)": {
                "type": "number",
                "shouldnotnull": true
            },
            "grade": {
                "type": "string",
                "shouldnotnull": true
            },
            "medium": {
                "type": "string",
                "shouldnotnull": true
            },
            "category": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            }
        },
        "required": [
            "board",
            "subject",
            "content_name",
            "mime_type",
            "total_no_of_plays(App and Portal)",
            "total_play_time(App and Portal)",
            "grade",
            "medium",
            "category",
            "state_name",
            "state_code"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_etb_plays-per-capita",
    "input": {
        "type": "object",
        "properties": {
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "plays_per_capita": {
                "type": "number",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": true
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "state_name",
            "plays_per_capita",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_nishtha_consumption-by-course",
    "input": {
        "type": "object",
        "properties": {
            "published_by": {
                "type": "string",
                "shouldnotnull": true
            },
            "user_state": {
                "type": "string",
                "shouldnotnull": true
            },
            "course_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "program": {
                "type": "string",
                "shouldnotnull": true
            },
            "enrollments": {
                "type": "number",
                "shouldnotnull": true
            },
            "completion": {
                "type": "number",
                "shouldnotnull": true
            },
            "certification": {
                "type": "number",
                "shouldnotnull": true
            },
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "published_by",
            "user_state",
            "course_name",
            "program",
            "enrollments",
            "completion",
            "certification",
            "state_name",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_nishtha_consumption-by-district",
    "input": {
        "type": "object",
        "properties": {
            "program": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_name": {
                "type": "string",
                "shouldnotnull": true
            },
             "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "total_enrollments": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_completion": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_certifications": {
                "type": "number",
                "shouldnotnull": true
            },
            "certification%": {
                "type": "number",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "program",
            "district_name",
            "state_name",
            "total_enrollments",
            "total_completion",
            "total_certifications",
            "certification%",
            "state_code",
            "district_code",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_nishtha_percentage-enrollment-certification",
    "input": {
        "type": "object",
        "properties": {
            "program": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "total_enrolments": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_completions": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_certificates_issued": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_courses": {
                "type": "number",
                "shouldnotnull": true
            },
            "doe": {
                "type": "number",
                "shouldnotnull": true
            },
            "local_body": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_target_achieved_enrolment": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_target_achieved_ertificates": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_target_remaining_enrolment": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_target_remaining_certificates": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_expected_enrolment": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_expected_certification": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "program",
            "state_name",
            "state_code",
            "latitude",
            "longitude",
            "total_enrolments",
            "total_completions",
            "total_certificates_issued",
            "total_courses",
            "doe",
            "local_body",
            "%_target_achieved_enrolment",
            "%_target_achieved_certificates",
            "%_target_remaining_enrolment",
            "%_target_remaining_certificates",
            "total_expected_enrolment",
            "total_expected_certification"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_nishtha_program-started",
    "input": {
        "type": "object",
        "properties": {
            "program": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "started": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "program",
            "state_name",
            "started",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "diksha_nishtha_tot-courses-medium",
    "input": {
        "type": "object",
        "properties": {
            "program_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "total_courses": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_medium": {
                "type": "number",
                "shouldnotnull": true
            },
            "state_ode": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "program_name",
            "state_name",
            "total_courses",
            "total_medium",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "nas_all-dashboard",
    "input": {
        "type": "object",
        "properties": {
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "number_of_schools": {
                "type": "number",
                "shouldnotnull": true
            },
            "number_of_teachers": {
                "type": "number",
                "shouldnotnull": true
            },
            "students_surveyed": {
                "type": "number",
                "shouldnotnull": true
            },
            "learning_outcome_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "performance": {
                "type": "number",
                "shouldnotnull": true
            },
            "subject": {
                "type": "string",
                "shouldnotnull": true
            },
            "grade": {
                "type": "string",
                "shouldnotnull": true
            },
            "learning_outcome": {
                "type": "string",
                "shouldnotnull": true
            }
        },
        "required": [
            "state_name",
            "district_name",
            "state_code",
            "district_code",
            "number_of_schools",
            "number_of_teachers",
            "students_surveyed",
            "learning_outcome_code",
            "performance",
            "subject",
            "grade",
            "learning_outcome"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "nas_program-started",
    "input": {
        "type": "object",
        "properties": {
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "started": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "state_name",
            "started",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "pgi_all-dashboard",
    "input": {
        "type": "object",
        "properties": {
             "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "outcome": {
                "type": "number",
                "shouldnotnull": true
            },
            "effective_classroom_transaction": {
                "type": "number",
                "shouldnotnull": true
            },
            "infrastructure_facilities_studententitlements": {
                "type": "number",
                "shouldnotnull": true
            },
            "school_safety_and_child_protection": {
                "type": "number",
                "shouldnotnull": true
            },
            "digital_learning": {
                "type": "number",
                "shouldnotnull": true
            },
            "governance_processes": {
                "type": "number",
                "shouldnotnull": true
            },
            "grand_total": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "state_name",
            "district_name",
            "state_code",
            "district_code",
            "latitude",
            "longitude",
            "outcome",
            "effective_classroom_transaction",
            "infrastructure_facilities_studententitlements",
            "school_safety_and_child_protection",
            "digital_learning",
            "governance_processes",
            "grand_total"
        ]
    }
}'



curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "pm-poshan_access-across-india",
    "input": {
        "type": "object",
        "properties": {
               "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "enrolled": {
                "type": "number",
                "shouldnotnull": true
            },
            "meal_served": {
                "type": "number",
                "shouldnotnull": false
            },
            "total_schools": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "state_name",
            "district_name",
            "state_code",
            "district_code",
            "latitude",
            "longitude",
            "enrolled",
            "total_schools"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "udise-all-dashboard",
    "input": {
        "type": "object",
        "properties": {
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "state_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "district_code": {
                "type": "string",
                "shouldnotnull": true
            },
            "latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "longitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "number_of_teachers": {
                "type": "number",
                "shouldnotnull": true
            },
            "number_of_schools": {
                "type": "number",
                "shouldnotnull": true
            },
            "number_of_tudents": {
                "type": "number",
                "shouldnotnull": true
            },
            "ptr": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_schools_having_toilet": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_schools_having_drinkingwater": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_schools_having_electricity": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_schools_having_library": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_govt_n_govtaided_schools_recieved_textbook": {
                "type": "number",
                "shouldnotnull": true
            },
            "Total Enrollment CWSN": {
                "type": "number",
                "shouldnotnull": true
            },
            "tot_schools_having_ramp": {
                "type": "number",
                "shouldnotnull": true
            },
            "% schools having toilet": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_schools_having_drinking_water": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_schools_having_electricity": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_schools_having_library": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_govt_aided_schools_received_textbook": {
                "type": "number",
                "shouldnotnull": true
            },
            "%_schools_with_ramp": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "state_name",
            "district_name",
            "state_code",
            "district_code",
            "latitude",
            "longitude",
            "number_of_teachers",
            "number_of_schools",
            "number_of_students",
            "ptr",
            "tot_schools_having_toilet",
            "tot_schools_having_drinkingwater",
            "tot_schools_having_electricity",
            "tot_schools_having_library",
            "tot_govt_n_govtaided_schools_recieved_textbook",
            "total_enrollment_cwsn",
            "tot_schools_having_ramp",
            "%_schools_having_toilet",
            "%_schools_having_drinking_water",
            "%_schools_having_electricity",
            "%_schools_having_library",
            "%_govt_aided_schools_received_textbook",
            "%_schools_with_ramp"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "udise_program-started",
    "input": {
        "type": "object",
        "properties": {
            "state_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "started": {
                "type": "string",
                "shouldnotnull": true
            },
            "State Code": {
                "type": "string",
                "shouldnotnull": true
            },
            "Latitude": {
                "type": "number",
                "shouldnotnull": false
            },
            "Longitude": {
                "type": "number",
                "shouldnotnull": false
            }
        },
        "required": [
            "state_name",
            "started",
            "state_code",
            "latitude",
            "longitude"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "vsk_diksha_etb_coverage-status",
    "input": {
        "type": "object",
        "properties": {
            "textbook_id": {
                "type": "string",
                "shouldnotnull": true
            },
            "medium": {
                "type": "string",
                "shouldnotnull": true
            },
            "grade": {
                "type": "string",
                "shouldnotnull": true
            },
            "subject": {
                "type": "string",
                "shouldnotnull": true
            },
            "linked_qr_count": {
                "type": "number",
                "shouldnotnull": true
            },
            "resource_count": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "textbook_id",
            "medium",
            "grade",
            "subject",
            "linked_qr_count",
            "resource_count"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "vsk_diksha_etb_qr-coverage",
    "input": {
        "type": "object",
        "properties": {
            "textbook_id": {
                "type": "string",
                "shouldnotnull": true
            },
            "textbook_name": {
                "type": "string",
                "shouldnotnull": true
            },
            "medium": {
                "type": "string",
                "shouldnotnull": true
            },
            "grade": {
                "type": "string",
                "shouldnotnull": true
            },
            "subject": {
                "type": "string",
                "shouldnotnull": true
            },
            "day_of_created_on": {
                "type": "string",
                "shouldnotnull": true
            },
            "qr_coverage": {
                "type": "number",
                "shouldnotnull": true
            },
            "qr_codes_linked_to_content": {
                "type": "number",
                "shouldnotnull": true
            },
            "total_qr_codes": {
                "type": "number",
                "shouldnotnull": true
            }
        },
        "required": [
            "textbook_id",
            "textbook_name",
            "medium",
            "grade",
            "subject",
            "day_of_created_on",
            "qr_coverage",
            "qr_codes_linked_to_content",
            "total_qr_codes"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "totalteachers",
    "input": {
        "type": "object",
        "properties": {
            "date": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "block_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "cluster_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "school_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
           
            "total_teachers": {
                "type": "number",
                "shouldNotNull": true
            }
        },
        "required": [
            "date",
            "district_id",
            "block_id",
            "cluster_id",
            "school_id",
            "total_teachers"
        ]
    }
}'

curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "teacherspresent",
    "input": {
        "type": "object",
        "properties": {
            "date": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "block_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "cluster_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "school_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "teachers_marked_present": {
                "type": "number",
                "shouldNotNull": true
            }
        },
        "required": [
            "date",
            "district_id",
            "block_id",
            "cluster_id",
            "school_id",
            "teachers_marked_present"
        ]
    }
}'


curl --location "https://80-${GITPOD_WORKSPACE_URL:8}/api/spec/event" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $jwtToken" \
--data '{
    "program": "teachersmarked",
    "input": {
        "type": "object",
        "properties": {
            "date": {
                "type": "string",
                "shouldNotNull": true
            },
            "district_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "block_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "cluster_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "school_id": {
                "type": "string",
                "shouldNotNull": true,
                "unique": true
            },
            "teachers_marked": {
                "type": "number",
                "shouldNotNull": true
            }
        },
        "required": [
            "date",
            "district_id",
            "block_id",
            "cluster_id",
            "school_id",
            "teachers_marked"
        ]
    }
}'