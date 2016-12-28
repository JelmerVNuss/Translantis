import os
import sys
import re


DOCUMENTS_FOLDER = "./documents"


lines = []
with open('dataset.txt', 'r') as f:
    lines = f.read()

# newDocumentExpression matches text of the form: "123 of 200 DOCUMENTS".
# \d matches digits [0-9].
newDocumentExpression = r"\b\d+\b of \d\d\d DOCUMENTS"

# Split the document in several documents based on the newDocumentExpression.
# Skip the first element (index 0) as it contains all text BEFORE the first document.
# Example:
#     Text before Article
#     1 of 200 DOCUMENTS
#     Title of Article
#     Body of Article
documents = re.split(newDocumentExpression, lines)[1:]
# Check if all documents are found.
# The length (amount) of list of documents should equal the amount of documents.
print("The amount of documents found is: {}".format(len(documents)))


documents = [document.strip() for document in documents]


if not os.path.exists(DOCUMENTS_FOLDER):
    os.makedirs(DOCUMENTS_FOLDER)

for document in documents:
    index = documents.index(document) + 1
    with open('{}/{}.txt'.format(DOCUMENTS_FOLDER, index), 'w+') as writeFile:
        writeFile.write(document)




MONTHS = "(januari|februari|maart|april|mei|juni|juli|augustus|september|oktober|november|december)"
MONTHS_ENGLISH = "(january|february|march|april|may|june|july|august|september|october|november|december)"
dateExpression = r"\d\d* \d\d \d\d\d\d"
dateExpression = r"\d\d* {} \d\d\d\d".format(MONTHS)

print(dateExpression)

for document in documents:
    print(re.findall(dateExpression, document))
