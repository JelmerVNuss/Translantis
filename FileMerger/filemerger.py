"""filemerger.py: Find all files in nested folders starting from a root and
merge them.

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
                filepath = os.path.join(path, name)
                with open(filepath, 'r') as f:
                    document.append(f.read())

            directory = path.split(os.path.sep)[-1]
            filename = '{}.{}'.format(str(directory), str(extension))
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

    merge(root)

    print("Done: Files merged in root {}.".format(root))


if __name__ == "__main__":
    main(sys.argv[1:])
