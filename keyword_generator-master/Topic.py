class Topic:
    def __init__(self, id, content=[]):
        self.id = id
        self.content = content

    def __repr__(self):
        return "Topic {0}: {1}".format(self.id, self.content)

    @property
    def words(self):
        return [topic[0] for topic in self.content]

    @property
    def percentages(self):
        return [topic[1] for topic in self.content]

    def addWord(self, word, percentage):
        self.content.append((word, percentage))
