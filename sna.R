#Akshay Jain


#install.packages("dplyr")
#install.packages("igraph")
library(dplyr) # dplyr package is used for data manipulation; it uses pipes: %>%
library(igraph) # used to do social network analysis

scripts <- read.csv("Final_script.csv")
scripts <- scripts %>% select(Speaker, Listener)
#scripts <- scripts %>% filter(Speaker == "Malfoy")

length(unique(scripts$Speaker))
unique(scripts$Speaker)

length(unique(scripts$Listener))
unique(scripts$Listener)

scripts <- scripts %>% select(Speaker, Listener)
conversations <- scripts %>% group_by(Speaker, Listener) %>% summarise(counts = n())
set.seed(22) 
conversations <- conversations[sample(nrow(conversations), 50), ]
nodes <- c(as.character(conversations$Speaker), as.character(conversations$Listener))
nodes <- unique(nodes)

my_graph <- graph_from_data_frame(d=conversations, vertices=nodes, directed=FALSE)
my_graph 

V(my_graph)$name

E(my_graph)
plot(my_graph, vertex.label.color = "black")

w1 <- E(my_graph)$counts

plot(my_graph, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = sqrt(w1),  # put w1 in sqrt() so that the lines don't become too wide
     layout = layout_nicely(my_graph))



# create a new igraph object by keeping just the pairs that have at least 2 conversations 
my_graph_2more_conv <- delete_edges(my_graph, E(my_graph)[counts < 2])

# plot the new graph 
plot(my_graph_2more_conv, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = sqrt(E(my_graph_2more_conv)$counts),
     layout = layout_nicely(my_graph_2more_conv))

# create a new graph that takes into consideration the direction of the conversation
g <- graph_from_data_frame(conversations, directed = TRUE)
g
# Is the graph directed?
is.directed(g)

# plot the directed network; notice the direction of the arrows, they show the direction of the conversation
plot(g, 
     vertex.label.color = "black", 
     edge.color = 'orange',
     vertex.size = 0,
     edge.arrow.size = 0.03,
     layout = layout_nicely(g))


# identify all neighbors of 'Harry' regardless of direction
neighbors(g, 'Harry', mode = c('all'))

# identify the nodes that go towards 'Harry'
neighbors(g, 'Harry', mode = c('in'))

# identify the nodes that go from 'Harry'
neighbors(g, 'Harry', mode = c('out'))


# identify any vertices that receive an edge from 'Harry' and direct an edge to 'Hagrid'
n1 <- neighbors(g, 'Harry', mode = c('out'))
n2 <- neighbors(g, 'Hagrid', mode = c('in'))
intersection(n1, n2)


# determine which 2 vertices are the furthest apart in the graph
farthest_vertices(g) 
# shows the path sequence between two furthest apart vertices
get_diameter(g)  


# identify vertices that are reachable within two connections from 'Harry'
ego(g, 2, 'Snape', mode = c('out'))

# identify vertices that can reach Harry' within two connections
ego(g, 2, 'Snape', mode = c('in'))


# calculate the out-degree of each vertex
# out-degree represents the number of vertices that are leaving from a particular node
g.outd <- degree(g, mode = c("out"))
g.outd

# find the vertex that has the maximum out-degree
which.max(g.outd)

# calculate betweenness of each vertex
# betweeness is an index of how frequently the vertex lies on shortest paths between any two vertices 
  # in the network. It can be thought of as how critical the vertex is to the flow of information 
  # through a network. Individuals with high betweenness are key bridges between different parts of 
  # a network.
g.b <- betweenness(g, directed = TRUE)
g.b

# Create plot with vertex size determined by betweenness score
plot(g, 
     vertex.label.color = 'black',
     edge.color = 'black',
     vertex.size = sqrt(g.b) / 1.2,
     edge.arrow.size = 0.03,
     layout = layout_nicely(g))

