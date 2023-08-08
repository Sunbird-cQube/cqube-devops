import requests
import os
base_url = f"https://80-{os.environ.get('GITPOD_WORKSPACE_URL')[8:]}"

jwt_url = f"{base_url}/api/ingestion/generatejwt"
jwt_token = requests.request("GET", jwt_url).text

ingest_url = f'{base_url}/api/ingestion'

print("=================== Starting Dimension Ingestion ===================\n\n")
for file in os.listdir('JH_data_Jun_8/dimensions'):
    if not file.endswith('.csv'):
        print("Ignoring ", file)
        pass
    
    print("Ingesting dimension", file)
    payload = {
        'ingestion_type': 'dimension',
        'ingestion_name': file.split('-')[0]
    }
    files=[('file',(file ,open(f'JH_data_Jun_8/dimensions/{file}','rb'),'text/csv'))]
    headers = {'Authorization': f'Bearer {jwt_token}'}
    response = requests.request("POST", ingest_url + '/new_programs', headers=headers, data=payload, files=files)
    print(response.text)


print("=================== Starting Event Data Ingestion ===================\n\n")
for file in os.listdir('JH_data_Jun_8/state_programs/teacher_attendance'):
    if not file.endswith('.csv'):
        print("Ignoring ", file)
        pass
    
    print("Ingesting event data ", file)
    payload = {
        'ingestion_type': 'event',
        'ingestion_name': file.split('-')[0],
        'program_name': 'school-attendance'
    }
    files=[('file',(file ,open(f'JH_data_Jun_8/state_programs/teacher_attendance/{file}','rb'),'text/csv'))]
    headers = {'Authorization': f'Bearer {jwt_token}'}
    response = requests.request("POST", ingest_url + '/new_programs', headers=headers, data=payload, files=files)
    print(response.text)


print("=================== Starting National Program Data Ingestion ===================\n\n")
for file in os.listdir('JH_data_Jun_8/vsk_programs'):
    if not file.endswith('.zip'):
        print("Ignoring ", file)
        pass
    
    print("Ingesting national programs data data ", file)
    payload = {}
    
    files=[('file',(file ,open(f'JH_data_Jun_8/vsk_programs/{file}','rb'),'text/csv'))]
    headers = {'Authorization': f'Bearer {jwt_token}'}
    response = requests.request("POST", ingest_url + '/national_programs', headers=headers, data=payload, files=files)
    print(response.text)
