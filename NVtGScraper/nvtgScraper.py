#!/usr/bin/env python

"""nvtgScraper.py:
Scrape all the pdf files from www.ntvg.nl
"""


import os
import string
import unicodedata

import requests
import bs4


validFilenameChars = "-_.() {}{}".format(string.ascii_letters, string.digits)

BASE_FOLDER = "/NVtG/"
# Where to find the article files.
SEARCH_BOX_URL = ("https://www.ntvg.nl/search/advanced?search=&page=", "&in=full&author_options=0")
ARTICLE_INFO_URL = ("https://www.ntvg.nl/artikelen/", "/artikelinfo")
ARTICLE_INFO_SELECTOR = "#block-system-main > div > div > div > div.field.field-name-field-year.field-type-number-integer.field-label-hidden > div > div"
DOWNLOAD_URL_SELECTOR = "#block-ntvgmod-print > div > div > ul > li.last > a"
DOWNLOAD_CLASS = "download jquery-once-1-processed"

# Scrape only these pages.
BEGIN_PAGE = 0
# This is the first page with a downloadable PDF. This will change as articles
# are being added.
BEGIN_PAGE = 593
# Update the end page to the current end page.
END_PAGE = 31046
ARTICLES_PER_PAGE = 10

#https://www.ntvg.nl/search/advanced?search=&page=593&in=full&author_options=0
#https://www.ntvg.nl/artikelen/een-meisje-met-rugklachten/artikelinfo

def removeDisallowedFilenameChars(filename):
    cleanedFilename = str(unicodedata.normalize('NFKD', filename).encode('ASCII', 'ignore'))
    return ''.join(c for c in cleanedFilename[1:] if c in validFilenameChars)


def checkWebsiteAvailability(url):
    """Check whether the given website is online.
    Return the request if it succeeds.
    """
    res = requests.get(url)
    res.raise_for_status()

    return res


def findArticleNames(page, verbose=False):
    """Find the article names on this page.
    """
    article_url = SEARCH_BOX_URL[0] + str(page) + SEARCH_BOX_URL[1]
    res = checkWebsiteAvailability(article_url)

    soup = bs4.BeautifulSoup(res.text, 'html.parser')

    articleNames = []
    for ul in soup.findAll('ul', class_='content-list'):
        for a in ul.findAll('a'):
            articleNames.append(a.attrs['href'].split('/')[-1])
    if verbose:
        print("On page {}, found article names {}.".format(page, articleNames))

    return articleNames


def getArticleInfo(articleName, verbose=False):
    """Return the article ID and publishing year based on an article name.
    The article ID is usually of the form VOLUME;ISSUE, but this might introduce
    errors while saving.
    The files are thus stored as VOLUME-ISSUE.
    """
    article_info_url = ARTICLE_INFO_URL[0] + articleName + ARTICLE_INFO_URL[1]
    res = checkWebsiteAvailability(article_info_url)

    articleId = ""
    year = ""

    soup = bs4.BeautifulSoup(res.text, 'html.parser')

    try:
        articleInfo = soup.select(ARTICLE_INFO_SELECTOR)[0]
        splitText = articleInfo.text.split(';')
        articleId = removeDisallowedFilenameChars(splitText[-1].replace(' ', '').replace(':', '-'))
        year = splitText[0].split()[-1]

        if verbose:
            print("Found article ID [{}] in year [{}].".format(articleId, year))
    except IndexError:
        if verbose:
            print("Skipping this article [{}]: no information available.".format(articleName))
    print(articleName)
    return articleId, year


def getDownloadUrl(articleName, verbose=False):
    article_url = ARTICLE_INFO_URL[0] + articleName
    res = checkWebsiteAvailability(article_url)

    soup = bs4.BeautifulSoup(res.text, 'html.parser')

    try:
        download_url = soup.find('a', class_='download').attrs['href']
        if verbose:
            print("Found download url [{}].".format(download_url))
    except:
        download_url = ""
        if verbose:
            print("Skipping this article [{}]: no downloadable PDF found.".format(articleName))

    return download_url

def downloadFromUrl(url, file_name, verbose=False):
    # Open in binary mode.
    with open(file_name, "wb") as file:
        response = checkWebsiteAvailability(url)
        file.write(response.content)
    if verbose:
        print("File successfully downloaded: {}".format(file_name))


def downloadFile(articleName, path=".", verbose=False):
    """Download the file to the downloads folder."""
    articleId, year = getArticleInfo(articleName, verbose)
    file_path = path + BASE_FOLDER + str(year)
    file_name =  "/" + articleId + ".pdf"

    if os.path.isfile(file_path + file_name):
        if verbose:
            print("File already exists: {}".format(file_path + file_name))
        return
    try:
        os.makedirs(file_path)
    except OSError:
        if not os.path.isdir(file_path):
            raise

    download_url = getDownloadUrl(articleName, verbose)
    if download_url:
        if verbose:
            print("Downloading to: {}".format(file_path + file_name))
        downloadFromUrl(download_url, file_path + file_name, verbose)


if __name__ == "__main__":
    verbose = False
    for page in range(BEGIN_PAGE, END_PAGE):
        if page % 10 == 0:
            print("Now at page {}...".format(page))
        articleNames = findArticleNames(page, verbose)
        for articleName in articleNames:
            downloadFile(articleName, verbose=verbose)

    print("All articles from Nederlands Tijdschrift voor Geneeskunde are scraped.")
