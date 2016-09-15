import os

OPTIONS = ["TOPIC", "YEAR"]


def merge(root, option, values, extension="txt"):
    """Merge all files in nested subfolders based on an option (topic or year),
    where all files containing the search term are piled in a single file in the
    root folder.
    """
    if option.upper() not in OPTIONS:
        raise ValueError("Options is not implemented: {}".format(option))
    elif option.upper() == "TOPIC":
        searchTerms = values
    elif option.upper() == "YEAR":
        startYear, endYear = values
        searchTerms = range(startYear, endYear+1)
    else:
        raise ValueError("Update merge OPTIONS, option is not included: {}".format(option))

    for searchTerm in searchTerms:
        document = mergeSimilarDocuments(root, searchTerm)

        filename = '{}.{}'.format(str(searchTerm), str(extension))
        with open(filename, 'w+') as f:
            f.write(document)

def mergeSimilarDocuments(root, searchTerm):
    """Retrieve and merge all documents in nested subfolders that contain the
    search term in the filename.
    """
    searchTerm = str(searchTerm).lower()

    document = []

    for root, directories, files in os.walk(root):
        for name in files:
            filepath = os.path.join(root, name)
            if searchTerm in filepath.lower():
                with open(filepath, 'r') as f:
                    document.append(f.read())

    return ''.join(document)


if __name__ == "__main__":
    root = "./test/"
    option = "year"
    values = (1990, 2010)
    merge(root, option, values)
    #topics = ['Python', 'C#']
    #merge(root, option="topic", values=topics)

    print("Done: Files merged by {} in root {}.".format(option, root))
