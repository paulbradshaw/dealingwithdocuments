# How to convert one dataset into two (nodes and links) for a network analysis diagram

Network analysis and visualisation is great to help you see - and show - relationships between different things: it might be payments between companies, migration between areas, connections between people, or anything else where things (money, time, people, interactions) are being exchanged.

But when it comes to using network analysis and visualisation tools, you often hit a problem: most require data to be formatted in *two* separate sheets: one listing all the nodes (the points in the network); and another detailing all the connections between those (the links).

If you only have the second part of that - a dataset showing exchanges - then you have a problem to solve.

In this tutorial I will explain how to solve that problem. We will use Flourish for the resulting visualisation but you can use similar approaches for other tools such as Gephi.

## Introducing the dataset

The dataset I'm using shows the amount of time each character spends on screen in each of the Star Wars films. It has three columns:

* Name of film
* Name of character
* Time on screen

Each film, and most characters, appear multiple times.

This is a common structure for network analysis. We can use it to show:

* The total amount of time each character spends on screen (indicated by the size of their 'node')
* The characters that are most 'central' - that is, those with the connections to the most films
* The characters that are ''bridges' - that is, they connect different clusters of nodes 
* The films that are most 'central' - that is, those with the most connections 'in common' with other nodes.
