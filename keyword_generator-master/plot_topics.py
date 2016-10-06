import numpy as np
import matplotlib.pyplot as plt

# Source: https://de.dariah.eu/tatom/visualizing_trends.html
# Source: http://chrisstrelioff.ws/sandbox/2014/11/13/getting_started_with_latent_dirichlet_allocation_in_python.html

def plot_stacked_bar(topics, distributions):
    """
    Source: https://de.dariah.eu/tatom/topic_model_visualization.html
    See: http://matplotlib.org/examples/pylab_examples/bar_stacked.html
    """
    print(distributions)
    N, K = len(distributions), len(topics)  # N documents, K topics
    docnames = [distribution[0] for distribution in distributions[0]]
    print(docnames)
    doctopic = []
    for distribution in distributions:
        dist_topics = [distribution[1] for distribution in distribution]
        doctopic.append(dist_topics)
    doctopic = np.array(doctopic)
    ind = np.arange(N)  # the x-axis locations for the documents
    width = 0.5  # the width of the bars
    plots = []
    height_cumulative = np.zeros(N)
    for k in range(K):
        color = plt.cm.coolwarm(k/K, 1)
        if k == 0:
            p = plt.bar(ind, doctopic[:, k], width, color=color)
        else:
            p = plt.bar(ind, doctopic[:, k], width, bottom=height_cumulative, color=color)
            height_cumulative += doctopic[:, k]
            plots.append(p)

    plt.ylim((0, 1))  # proportions sum to 1, so the height of the stacked bars is 1
    plt.ylabel('Topics')
    plt.title('Topics in documents')
    plt.xticks(ind+width/2, docnames)
    plt.yticks(np.arange(0, 1, 10))
    topic_labels = ['Topic #{}'.format(k) for k in range(K)]

    # see http://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.legend for details
    # on making a legend in matplotlib
    plt.legend([p[0] for p in plots], topic_labels)
    plt.show()
