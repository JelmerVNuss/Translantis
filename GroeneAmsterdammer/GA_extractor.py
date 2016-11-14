import os
import re
import codecs

from bs4 import BeautifulSoup
import xml.etree.ElementTree as ET


def extractFolder(path):
    """Find all files and folders in this directory.
    Extract all the files, and recursively go through the subfolders.
    """
    files = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))]
    directories = [d for d in os.listdir(path) if os.path.isdir(os.path.join(path, d))]

    for file in files:
        if file[-4:].lower() == ".xml":
            extractFile(os.path.join(path, file))

    # Recursively combine the subfolders.
    for directory in directories:
        extractFolder(os.path.join(path, directory))

def extractFile(path):
    """Read the XML file and extract the <text> element.
    The result will be stored in a newly created folder structure in text files
    containing only the text of the file in the folder YY under MMDD-i.txt
    where i is the index of the article of that day (in case of multiple articles).
    """
    tree = ET.parse(path)
    root = tree.getroot()

    # Try to find a year and date for this file, otherwise skip it.
    year = ""
    date = ""
    try:
        for datum in root.iter('Datum'):
            year = datum.text[:4]
            date = datum.text[4:]
    except:
        return

    if not year or not date:
        return

    content = ""
    for text in root.iter('text'):
        content = text.text.strip()

    directory = os.path.join('groene-xml_processed', year)
    filename = date

    # Create the new directories for the processed data.
    if not os.path.exists(directory):
        os.makedirs(directory)

    i = 1
    newPath = os.path.join(directory, filename + "-{}.txt".format(i))

    while os.path.isfile(newPath):
        i += 1
        newPath = os.path.join(directory, filename + "-{}.txt".format(i))

    with open(newPath, 'w+', encoding='utf-8') as f:
        f.write(content)


def main():
    # Scrape all the XML files in the following folder and its subfolders.
    path = "./groene-xml"
    extractFolder(path)
    print("All XML files in {0} extracted to {0}_processed".format(path))

if __name__ == "__main__":
    main()
