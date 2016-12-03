#!/usr/local/bin/python
"""pdf2txt.py: Find all files in nested folders starting from a root and
OCR them and store the result as a text file.
The text files are stored in a newly created folder: [root]_txt

This program is meant for Python 2.x and makes use of the PDFMiner module.
This module is not supported for Python 3.x.

Usage:
    pdf2txt --root <root> --language <language>
where <root> is the specified path to the starting folder, either
             a relative or absolute path, and
      <language> is the target language of the folder, can be used to specify
             better OCR methods.

A valid example is:
    pdf2txt.py --root "./test" --language "nld"
"""

import sys
import os
import getopt

from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from cStringIO import StringIO


# Source: https://stackoverflow.com/questions/5725278/how-do-i-use-pdfminer-as-a-library
def convertPdfToTxt(filepath, outtype='txt'):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)

    with file(filepath, 'rb') as pdfFile:
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        password = ""
        maxpages = 0
        caching = True
        pagenos=set()
        for page in PDFPage.get_pages(pdfFile, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
            interpreter.process_page(page)

    device.close()
    text = retstr.getvalue()
    retstr.close()
    return text


def getTextFromFile(filepath, language):
    text = ""
    extension = os.path.splitext(filepath)[-1].lower()
    if extension == ".pdf":
        text = convertPdfToTxt(filepath)
    else:
        raise ValueError("Extension not supported: {}".format(extension))
    return text

def ocrFolder(root, language):
    if not os.path.exists(root + "_txt"):
        os.makedirs(root + "_txt")
    for path, directories, files in os.walk(root):
        for name in files:
            filepath = os.path.join(path, name)
            ocrFile(filepath, language)

def ocrFile(filepath, language):
    text = getTextFromFile(filepath, language)

    filepathList = filepath.split(os.sep)
    filepathList = [filepathList[0] + "_txt"] + [folder for folder in filepathList[1:]]
    filepath = os.path.join(*filepathList)

    if not os.path.exists(os.path.dirname(filepath)):
        os.makedirs(os.path.dirname(filepath))

    with open(os.path.splitext(filepath)[0] + ".txt", "w+") as f:
        f.write(text)


def main(argv):
    root = ""
    language = ""
    try:
        opts, args = getopt.getopt(argv,"hrl:",["root=", "language="])
    except getopt.GetoptError:
        print('pdf2txt.py -r <root> -l <language>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('pdf2txt.py -r <root> -l <language>')
            sys.exit()
        elif opt in ("-r", "--root"):
            root = arg
        elif opt in ("-l", "--language"):
            language = arg

    if not root:
        raise ValueError("No root specified.")

    ocrFolder(root, language)

    newRoot = root + "_txt"
    print("Done: Files OCR'd in root: {}\nStored in: {}".format(root, newRoot))

if __name__ == "__main__":
    main(sys.argv[1:])
