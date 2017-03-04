import os
import shutil


ROOT = "Elseviers_Magazine_txt"


# Extract the metadata.
dates = {}
folders = [ROOT] + ["{}/{}".format(ROOT, year) for year in range(2007, 2011+1)]
for folder in folders:
    for filename in os.listdir(folder):
        filename, extension = os.path.splitext(filename)
        if extension == ".txt":
            year, month, day = filename[-8:-4], filename[-4:-2], filename[-2:]
            dates[filename] = "-".join([year, month, day])

if not os.path.exists('elsevier/metadata'):
    os.makedirs('elsevier/metadata')
if not os.path.exists('elsevier/texts/raw'):
    os.makedirs('elsevier/texts/raw')

# Create a field descriptions file.
with open('elsevier/metadata/field_descriptions.json', 'w+') as fieldDescriptionsFile:
    text = """[
    {"datatype": "searchstring", "field": "searchstring", "unique": true, "type": "text"},
    {"datatype": "categorical", "field": "type", "unique": false, "type": "text"},
    {"datatype": "categorical", "field": "author", "unique": false, "type": "text"},
    {"datatype": "categorical", "field": "genre", "unique": false, "type": "text"},
    {"datatype": "time", "field": "date_month", "unique": true, "type": "integer"}
]"""
    fieldDescriptionsFile.write(text)

# Create the json catalog file and copy text files.
for filename in os.listdir(ROOT):
    filename, extension = os.path.splitext(filename)
    if extension == ".txt":
        with open('elsevier/metadata/jsoncatalog.txt', 'a+') as jsonFile:
            filenameMeta = '"filename": "{}"'.format(filename)
            dateMeta = '"date": "{}"'.format(dates[filename])
            metadata = [filenameMeta, dateMeta]
            jsonEntry = "{{{}}}\n".format(", ".join(metadata))
            #(jsonEntry)
            jsonFile.write(jsonEntry)
        originalPath = '{}/{}{}'.format(ROOT, filename, extension)
        destinationPath = 'elsevier/texts/raw/{}'.format(filename + '.txt')
        shutil.copyfile(originalPath, destinationPath)
