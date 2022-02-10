# install.packages("quanteda")
# install.packages("quanteda.textmodels")
# install.packages("quanteda.textstats")
# install.packages("quanteda.textplots")
# install.packages("readtext")
# install.packages("devtools") # get devtools to install quanteda.corpora
# devtools::install_github("quanteda/quanteda.corpora")
# install.packages("spacyr")
# install.packages("newsmap")
# install.packages("seededlda")
# install.packages("newsmap")

library(quanteda)
library(quanteda.textmodels)
library(quanteda.textstats)
library(quanteda.textplots)
library(readtext)
library(devtools)
library(quanteda.corpora)
library(spacyr)
library(newsmap)
library(seededlda)
library(newsmap)

# objets numériques
2 + 2

a <- 1
a

b <- 2

a + b

class(a)

# objets textuels
mot <- "Bonjour"
mot

class(mot)

# les vecteurs
vec_num <- c(1, 5, 6, 3)
vec_num

vec_char <- c("pomme", "banane", "mandarine", "melon")
vec_char[3]

class(vec_char)

# obtenir la longueur d'un vecteur
length(vec_num)

# sélectionner des éléments
vec_char[1]
vec_char[2]
vec_char[2:4]

# créer un vecteur logique
vec_char == "pomme"

# additionner des vecteurs
vec_char2 <- c("test", "lol", "XD", "wow")
vec_char3 <- c(vec_char, vec_char2)
vec_char3

# joindre des vecteurs
paste(vec_char, vec_char2)

# nommer les éléments d'un vecteur
names(vec_num) <- vec_char
vec_num

# créer un jeu de données
data.frame(name = vec_char, count = vec_num)

# importer un document ou un corpus
path_data <- system.file("extdata/", package = "readtext")
dat_inaug <- read.csv(paste0(path_data, "/csv/inaugCorpus.csv"))

# trois types d'objets quanteda (corpus, tokens, document-feature matrix)

# types de corpus: 
# 1. Un vecteur de caractères composé d'un document par élément
# 2. Un bloc de données composé d'un vecteur de caractères pour les documents et 
# de vecteurs supplémentaires pour les variables au niveau du document


# British election manifestos on immigration and asylum
corp_immig <- corpus(data_char_ukimmig2010, 
                     docvars = data.frame(party = names(data_char_ukimmig2010)))

class(corp_immig)

corp_immig %>% head()

corp_immig[1]

corp_immig[[1]]

# corpus_reshape() permet de changer l'unité des textes entre les documents, les paragraphes et les phrases
corpus <- corpus(data_char_ukimmig2010)
ndoc(corpus)
corpus[[3]]

corpus <- corpus_reshape(corpus, to = "sentences")
ndoc(corpus)
corpus[[3]]


# Journal des débats de l'Assemblée nationale 15 septembre 2021
journal_debats <- readtext("Corpus/Journal des débats.txt", cache = FALSE)
journal_debats <- corpus(journal_debats)
journal_debats

# tokens() segmente les textes d'un corpus en tokens (mots ou phrases)
journal_debats[1]
journal_debats <- tokens(journal_debats)
journal_debats[1]

# voir comment les mots-clés sont utilisés dans les contextes réels dans une vue de concordance
toks <- tokens(journal_debats)
kwic(toks, pattern =  "duplessis", window = 10)[1]
kwic(toks, pattern =  "woke", window = 8)[1]

# trouver des expressions composées de plusieurs mots
kwic(toks, pattern = phrase("Québec solidaire")) %>% head()

# pour segmenter et retirer la ponctuation
toks_nopunct <- tokens(toks, remove_punct = TRUE)
toks_nopunct[1]

# retirer les stopwords
stopwords("fr")
toks_nostop <- tokens_remove(toks_nopunct, pattern = stopwords("fr"))
toks_nostop[1]

# tokens_compound()??????. https://tutorials.quanteda.io/basic-operations/tokens/tokens_compound/

# utiliser un dictionnaire
dict <- dictionary(file = "Dictionnaires/frlsd.cat")
length(dict)
names(dict)

tokens_lookup(toks_nostop, dictionary = dict)

kwic(toks_nostop, dict["POSITIVE"]) %>% head()

# créer son propre dictionnaire
dict <- dictionary(list(pandémie = c("virus", "contagion", "covid", "confinement"),
                        économie = c("PIB", "emploi", "croissance économique")))

kwic(toks_nostop, dict, window = 5) %>% head()
kwic(toks_nostop, dict["pandémie"], window = 3) %>% head()

# construire un DFM (document-feature matrix)
dfmat_journal_debats <- dfm(toks_nostop)
dfmat_journal_debats

# les mots les plus utilisés peuvent être trouvées en utilisant topfeatures()
topfeatures(dfmat_journal_debats, 10)


# ATTENTION LES PROCHAINES ÉTAPES NÉCESSITENT UN CORPUS PLUTÔT QU'UN SEUL DOCUMENT

# convertir le nombre d'occurences en une proportion dans les documents, utilisez dfm_weight(scheme = "prop")
dfmat_journal_debats_prop <- dfm_weight(dfmat_journal_debats, scheme  = "prop")

# pondérer le score de fréquence par unicité des caractéristiques dans les documents à l'aide de dfm_tfidf()
dfmat_journal_debats_tfidf <- dfm_tfidf(dfmat_journal_debats)
dfmat_journal_debats_tfidf



