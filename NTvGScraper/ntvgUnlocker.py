#!/usr/local/bin/python
import sys
import os
import getopt

from PyPDF2 import PdfFileReader, PdfFileWriter

PASSWORD = ""
EXTENSION = ".pdf"


def decryptFile(path):
    """Decrypt a single PDF with the password.
    """
    pdfFile = open(path, 'rb')
    try:
        pdfReader = PdfFileReader(pdfFile)
    except:
        return
    if pdfReader.isEncrypted:
        pdfReader.decrypt(PASSWORD)
        pdfWriter = PdfFileWriter()

        for pageNum in range(pdfReader.numPages):
            pdfWriter.addPage(pdfReader.getPage(pageNum))

        pdfFile.close()
        resultPdf = open(path, 'wb')
        pdfWriter.write(resultPdf)
        resultPdf.close()
    else:
        pdfFile.close()


def decryptFolder(root):
    """Decrypt all PDF files in nested subfolders with the password.
    """
    for path, directories, files in os.walk(root):
        for name in files:
            # Skip non-extension matching files.
            if not name.lower().endswith(EXTENSION):
                continue
            filepath = os.path.join(path, name)
            decryptFile(filepath)


def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hr:",["root="])
    except getopt.GetoptError:
        print('ntvgUnlocker.py -r <root>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('ntvgUnlocker.py -r <root>')
            sys.exit()
        elif opt in ("-r", "--root"):
            root = arg

    decryptFolder(root)

    print("Done: Files decrypted in root: {}".format(root))


if __name__ == "__main__":
    main(sys.argv[1:])
