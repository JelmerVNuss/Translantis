"""findFilemerger: Find all files in nested folders starting from a root that
contain the same search term and combine them into a single file.
The merged files are stored in a newly created folder: [root]_merged

Only considers files that contain the search term, all other files are disregarded.
Aim to be on the overextending side when the exact terms are unknown, take the
years (1950, 1980) for example over a possible exact amount of years (1956, 1967),
as all years not in (1956, 1967) just create empty files that either have no
influence in analysis, or can be removed manually.

Usage:
    findFilemerger.py -r <root> -o <option> -v <values>
where <root> is the specified path to the starting folder,
      <option> is a search option, either TOPIC or YEAR, and
      <values> is a comma-separated string of values.

A valid example is:
    filemerger.py -r ./test -o topic -v "test1,test2"
Or by year (only two values are allowed: the start and end year):
    filemerger.py -r ./test -o year -v "1990,2000"
"""

import sys
import os
import getopt

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

        filename = '{}/{}.{}'.format(root + '_merged', str(searchTerm), str(extension))
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
            # Skip non-extension matching files.
            if not name[-len(extension):] == extension:
                continue
            filepath = os.path.join(root, name)
            if searchTerm in filepath.lower():
                with open(filepath, 'r') as f:
                    document.append(f.read())

    return ''.join(document)


def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hr:o:v:",["root=","option=","values="])
    except getopt.GetoptError:
        print('filemerger.py -r <root> -o <option> -v <values>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('filemerger.py -r <root> -o <option> -v <values>')
            sys.exit()
        elif opt in ("-r", "--root"):
            root = arg
        elif opt in ("-o", "--option"):
            option = arg
        elif opt in ("-v", "--values"):
            values = arg.split(',')

    if option.upper() == "YEAR":
        values = [int(x) for x in values]

    newRoot = root + '_merged'
    if not os.path.exists(newRoot):
        os.makedirs(newRoot)

    merge(root, option, values)

    print("Done: Files merged by {} in root: {}\nStored in: {}".format(option, root, newRoot))


if __name__ == "__main__":
    main(sys.argv[1:])
