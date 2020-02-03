library(arules)
library(recommenderlab)
books.df <- read.csv("CharlesBookClub.csv")

## Create a Binary Incidence Matrix
count.books.df <- books.df[,8:18]
head(count.books.df,20)

## convert to 1 for all values greater thatn 0
incid.books.df <- ifelse(count.books.df > 0, 1, 0)

## drop first column and convert it to a matrix, Just for fun we are dropping first column
incid.books.mat <- as.matrix(incid.books.df[,-1])

## convert binary incidence matrix to transactions database
books.trans <- as(incid.books.mat, "transactions")
inspect(head(books.trans,10))

#plot data
itemFrequencyPlot(books.trans)

# run apriori function
rules <- apriori(books.trans, parameter= list(supp=0.05, conf=0.7, target ="rules"))

inspect(sort(rules, by="lift"))
