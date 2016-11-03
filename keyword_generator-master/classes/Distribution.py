from .Topic import Topic

class Distribution:
    def __init__(self, filename, content=[]):
        self.filename = filename
        self.content = content

    def __repr__(self):
        return "Distribution {0}: {1}".format(self.filename, self.content)

    @property
    def topics(self):
        return [content[0] for content in self.content]

    @property
    def percentages(self):
        return [content[1] for content in self.content]

    def addTopic(self, topic, percentage):
        self.content.append(topic, percentage)
