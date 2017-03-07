import os
import shutil


# Defines how many characters of the first line of an article should be taken
# as the searchstring field.
SEARCHSTRING_LENGTH = 50


def extractMetadata(dataset, root):
    dates = {}
    searchstrings = {}

    if dataset == "elsevier":
        folders = [root] + ["{}/{}".format(root, year) for year in range(2007, 2011+1)]
    elif dataset == "esb":
        folders = [root]
    elif dataset == "accountant":
        folders = [root]
    else:
        raise ValueError("Dataset not implemented: {}".format(dataset))

    for folder in folders:
        for filename in os.listdir(folder):
            filename, extension = os.path.splitext(filename)
            if extension == ".txt":
                if dataset == "elsevier":
                    year, month, day = filename[-8:-4], filename[-4:-2], filename[-2:]
                elif dataset == "esb":
                    year, month, day = filename[:4], None, None
                elif dataset == "accountant":
                    year, month, day = filename, None, None
                else:
                    raise ValueError("Dataset not implemented: {}".format(dataset))
                date = [year, month, day]
                date = [element for element in date if element]
                dates[filename] = "-".join(date)

                with open("{}/{}{}".format(folder, filename, extension), "r", encoding="utf-8") as f:
                    try:
                        searchstring = f.readline()[:SEARCHSTRING_LENGTH]
                    except KeyError:
                        searchsting = f.readline()
                    searchstrings[filename] = searchstring
    metadata = [dates, searchstrings]
    return metadata

def createBookwormFolders(dataset):
    if not os.path.exists('{}/metadata'.format(dataset)):
        os.makedirs('{}/metadata'.format(dataset))
    if not os.path.exists('{}/texts/raw'.format(dataset)):
        os.makedirs('{}/texts/raw'.format(dataset))

def createFieldDescriptionsFile(dataset):
    with open('{}/metadata/field_descriptions.json'.format(dataset), 'w+') as fieldDescriptionsFile:
        text = """[
        {"datatype": "searchstring", "field": "searchstring", "unique": true, "type": "text"},
        {"datatype": "categorical", "field": "type", "unique": false, "type": "text"},
        {"datatype": "categorical", "field": "author", "unique": false, "type": "text"},
        {"datatype": "categorical", "field": "genre", "unique": false, "type": "text"},
        {"datatype": "time", "field": "date_month", "unique": true, "type": "integer"}
    ]"""
        fieldDescriptionsFile.write(text)

def createJsonCatalogFile(dataset, root, metadata):
    dates, searchstrings = metadata
    for filename in os.listdir(root):
        filename, extension = os.path.splitext(filename)
        if extension == ".txt":
            with open('{}/metadata/jsoncatalog.txt'.format(dataset), 'a+') as jsonFile:
                filenameMeta = '"filename": "{}"'.format(filename)
                dateMeta = '"date": "{}"'.format(dates[filename])
                searchstringMeta = '"searchstring": "{}"'.format(searchstrings[filename])
                metadata = [filenameMeta, dateMeta, searchstringMeta]
                jsonEntry = "{{{}}}\n".format(", ".join(metadata))
                jsonFile.write(jsonEntry)

def copyFilesToBookworm(dataset, root):
    for filename in os.listdir(root):
        filename, extension = os.path.splitext(filename)
        if extension == ".txt":
            originalPath = '{}/{}{}'.format(root, filename, extension)
            destinationPath = '{}/texts/raw/{}'.format(dataset, filename + '.txt')
            shutil.copyfile(originalPath, destinationPath)


if __name__ == "__main__":
    # Create Elsevier Bookworm
    #dataset = "elsevier"
    #root = "Elseviers_Magazine_txt"
    # Create ESB Bookworm
    dataset = "esb"
    root = "ESB_text"
    # Create Accountant Bookworm
    #dataset = "accountant"
    #root = "accountant_txt"

    metadata = extractMetadata(dataset, root)
    createBookwormFolders(dataset)
    createFieldDescriptionsFile(dataset)
    createJsonCatalogFile(dataset, root, metadata)
    copyFilesToBookworm(dataset, root)
