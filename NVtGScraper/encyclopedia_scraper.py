import os
import re
import codecs

from bs4 import BeautifulSoup


def combineFolder(path):
    """Find all files and folders in this directory.
    Scrape all the files, and recursively go through the subfolders.
    """
    files = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))]
    directories = [d for d in os.listdir(path) if os.path.isdir(os.path.join(path, d))]

    for file in files:
        scrapeFile(os.path.join(path, file))

    # Recursively combine the subfolders.
    for directory in directories:
        combineFolder(os.path.join(path, directory))

def scrapeFile(path):
    """Read the file and scrape the itemprop="articleBody" element.
    The result will be stored in a newly created folder structure in text files
    containing only the name of the file.
    """
    directory = os.path.dirname(path)
    newDirectory = re.sub('E1', 'E1_processed', directory)

    # Create the new directories for the processed data.
    if not os.path.exists(newDirectory):
        os.makedirs(newDirectory)

    filename = os.path.basename(path)
    # Remove the leading digits and dash from the filename.
    filename = re.sub('\d+-', '', filename)
    newPath = os.path.join(newDirectory, filename + ".txt")

    # Read the local HTML file and parse for the itemprop element.
    text = ""
    with codecs.open(path, 'rb', encoding='utf-8') as f:
        lines = f.read()
        soup = BeautifulSoup(lines, 'html.parser')
        # Some files don't contain the itemprop element.
        # Create an empty file for these files.
        try:
            text = [element.text.lstrip() for element in soup.find_all(itemprop="articleBody")]
            text = '\n'.join(text)
        except AttributeError:
            pass

    if not text:
        text = ""
    with open(newPath, 'w+', encoding='utf-8') as f:
        f.write(text)


def main():
    # Scrape all files in the following folder and its subfolders.
    path = "./E1"
    combineFolder(path)

if __name__ == "__main__":
    main()
