library(recommenderlab)
library(ggplot2)
library(data.table)
library(reshape2)



setwd("/home/lokesh/Desktop/Github/R - Projects/Movie-Recommend")
movie_data = read.csv("movies.csv", stringsAsFactors = FALSE)
rating_data = read.csv("ratings.csv")
str(movie_data)
summary(movie_data)
head(movie_data)
summary(rating_data)
head(rating_data)


movie_genre = as.data.frame(movie_data$genres, stringsAsFactors = FALSE)
str(movie_genre)

movie_genre2 = as.data.frame(tstrsplit(movie_genre[,1], '[|]', type.convert = TRUE), stringsAsFactors = FALSE)
str(movie_genre2)

colnames(movie_genre2) = c(1:10)
colnames(movie_genre2)

list_genre = c("Action", "Adventure", "Animation", "Children", "Comedy", 
               "Crime", "Documentary", "Drama", "Fantasy", "Film-Noir", "Horror",
               "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western")

genre_mat1 = matrix(0, 10330, 18)

genre_mat1

genre_mat1[1,] =  list_genre

genre_mat1[1,]

colnames(genre_mat1) = list_genre

genre_mat1

for (index in 1:nrow(movie_genre2)){
  for (col in 1:ncol(movie_genre2)) {
    
    gen_col = which(genre_mat1[1,] == movie_genre2[index, col])
    genre_mat1[index+1, gen_col] = 1
    
  }
}


genre_mat2 = as.data.frame(genre_mat1[-1,], stringsAsFactors = FALSE)    # removing first row, which was genre list

genre_mat2

for(col in 1:ncol(genre_mat2)){
  
  genre_mat2[,col] = as.integer(genre_mat2[ ,col])          # convert from characters to integers

}


str(genre_mat2)


SearchMatrix = cbind(movie_data[,1:2], genre_mat2[])

head(movie_data[,1:2])

head(SearchMatrix)

ratingMatrix = dcast(rating_data, userId~movieId, value.var = "rating", na.rm = FALSE)

ratingMatrix = as.matrix(ratingMatrix[,-1])    # removing userIds

# converting rating matrix into a recommenderlab sparse matrix

ratingMatrix = as(ratingMatrix, "realRatingMatrix")


recommendation_model = recommenderRegistry$get_entries(dataType = "realRatingMatrix")
names(recommendation_model)

lapply(recommendation_model, "[[", "description")


recommendation_model$IBCF_realRatingMatrix$parameters


# similarity between first few users

similarity_mat = similarity(ratingMatrix[1:4, ], method = "cosine", which = "users")

similarity_mat

as.matrix(similarity_mat)

image(as.matrix(similarity_mat), main = "User's Similarities")


# similarity between first few items(movies)

movie_similarity = similarity(ratingMatrix[ , 1:4], method = "cosine", which = "items")

as.matrix(movie_similarity)

image(as.matrix(movie_similarity), main = "Movies similarity")


# most unique ratings

rating_values = as.vector(ratingMatrix@data)

unique(rating_values)

# Table of ratings

Table_of_Ratings = table(rating_values)

Table_of_Ratings



# Visualization 

library(ggplot2)

movie_views = colCounts(ratingMatrix)

table_views = data.frame(movie = names(movie_views), views = movie_views)

table_views = table_views[order(table_views$views, decreasing = TRUE), ]

table_views$title = NA

for (index in 1:10325){
  
  table_views[index, 3] = as.character(subset(movie_data, movie_data$movieId == table_views[index, 1])$title)
  
}


table_views[1:6, ]


# visualizing in bar plot

ggplot(table_views[1:6, ], aes(x = title, y = views)) +
  geom_bar(stat = "identity", fill = "steelblue") + 
  geom_text(aes(label = views), vjust = -0.3, size = 3.5) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  ggtitle("Total views of the top films")


# Heatmap of movie ratings

image(ratingMatrix[1:20, 1:25], axes = FALSE, main = "Heatmap of the first 25 rows and 25 columns")


# Performing data preparation

movie_ratings = ratingMatrix[rowCounts(ratingMatrix) > 50, colCounts(ratingMatrix) > 50]

movie_ratings


minimum_movies = quantile(rowCounts(movie_ratings), 0.98)

minimum_users = quantile(colCounts(movie_ratings), 0.98)

image(movie_ratings[rowCounts(movie_ratings) > minimum_movies, colCounts(movie_ratings) > minimum_users], 
main = "Heatmap of the top users and movies")


average_ratings = rowMeans(movie_ratings)

qplot(average_ratings, fill = I("steelblue"), col = I("red")) + 
  ggtitle("Distribution of the average rating per user")



# Data Normalization

normalized_ratings = normalize(movie_ratings)
sum(rowMeans(normalized_ratings) > 0.00001)

image(noralized_ratings[rowCounts(normalized_ratings) > minimum_movies, colCounts(normalized_ratings) > minimum_users], 
      main = "Normalized Ratings of the Top Users")



# Performing Data Binarization

binary_minimum_movies = quantile(rowCounts(movie_ratings), 0.95)

binary_minimum_users = quantile(colCounts(movie_ratings), 0.95)

good_rated_films = binarize(movie_ratings, minRating = 3)

image(good_rated_films[rowCounts(movie_ratings) > binary_minimum_movies, 
                       colCounts(movie_ratings) > binary_minimum_users], 
                       main = "Heatmap of the top users and movies") 
