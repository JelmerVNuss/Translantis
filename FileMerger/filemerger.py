"""filemerger.py: Find all files in nested folders starting from a root and
merge them.
The merged files are stored in a newly created folder: [root]_merged

Usage:
    filemerger.py -r <root>
where <root> is the specified path to the starting folder, either
             a relative or absolute path.

A valid example is:
    filemerger.py -r ./test"
"""

import sys
import os
import getopt


def merge(root, extension="txt"):
    """Merge all files in nested subfolders into a single file called
        [subfolder_name].txt.
    """
    for path, directories, files in os.walk(root):
        if not path == root:
            document = []
            for name in files:
                # Skip non-extension matching files.
                if not name[-len(extension):] == extension:
                    continue
                filepath = os.path.join(path, name)
                with open(filepath, 'r') as f:
                    document.append(f.read())

            directory = path.split(os.path.sep)[-1]
            filename = '{}/{}.{}'.format(root + '_merged', str(directory), str(extension))
            with open(filename, 'w+') as f:
                f.write(''.join(document))


def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hr:",["root="])
    except getopt.GetoptError:
        print('filemerger.py -r <root>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('filemerger.py -r <root>')
            sys.exit()
        elif opt in ("-r", "--root"):
            root = arg

    newRoot = root + '_merged'
    if not os.path.exists(newRoot):
        os.makedirs(newRoot)

    merge(root)

    print("Done: Files merged in root: {}\nStored in: {}".format(root, newRoot))


if __name__ == "__main__":
    main(sys.argv[1:])
