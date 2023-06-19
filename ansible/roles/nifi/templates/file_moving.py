import glob
import datetime
import shutil
import os
class FileMover:
    def __init__(self):
        # Get the current date
        self.current_date = datetime.datetime.now()
        # Format the current date
        self.formatted_date = self.current_date.strftime("%d-%b-%Y")
        self.processed_file_path = os.path.dirname(os.path.abspath(__file__)) + '/process_input/'
        self.path = glob.glob(self.processed_file_path + '*/*/*')
    def move_files(self):
        for paths in self.path:
            program_name = paths.split('/')[-3]
            file_destination = '/opt/nifi/nifi-current/Sunbird-cQube-processing-ms/impl/c-qube/ingest/{{state_name}}/programs/' + program_name + '/'
            dimension_file_location = '/opt/nifi/nifi-current/Sunbird-cQube-processing-ms/impl/c-qube/ingest/{{state_name}}/dimensions/'
            if not os.path.exists(file_destination):
                os.makedirs(file_destination)
            if paths.__contains__(self.formatted_date):
                if paths.__contains__('dimension'):
                    shutil.copy(paths, dimension_file_location)
                else:
                    shutil.copy(paths, file_destination)
                print('successfully moved the file to ' + file_destination)

file_mover = FileMover()
file_mover.move_files()
