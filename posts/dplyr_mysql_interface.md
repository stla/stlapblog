# dplyr: interface R pour SQL
2016-07-30  

***(latest update : 2016-07-30 16:05:55)***
<br/>






J'ai montré dans [un autre article](http://stla.github.io/stlapblog/posts/RMySQL.html) comment on utilise la librairie `RMySQL` pour se connecter à une base de données MySQL dans R, effectuer des requêtes SQL sur cette base de données à partir de R, et échanger des tableaux de données entre R et MySQL.

Ceci est aussi possible avec la librairie `dplyr`, et le propos du présent article est de montrer comment. 
Le principe n'est pas le même qu'avec `RMySQL` : avec `dplyr`, on manipule un tableau de données SQL de la même façon qu'on manipule un tableau de données R ; c'est-à-dire avec les fonctions `select`, `filter`, `mutate`, etc., dont j'ai donné des [exemples ici](http://stla.github.io/stlapblog/posts/dplyr_and_mysql_examples.html).

On peut se connecter à d'autres bases de données avec `dplyr` : SQL, SQLite, et d'autres. La [vignette Databases](https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html) contient les informations à ce propos. 
Un exemple d'utilisation avec SQLite est montré dans l'article [Working with databases in R](http://datascienceplus.com/working-with-databases-in-r/) du site [datascienceplus.com](http://datascienceplus.com/). 


## Connexion

Comme avec `RMySQL`, on commence par se connecter à une base de données. Celle à laquelle je me connecte avec la commande ci-dessous est nommée `mysql_dplyr`.


```r
library(dplyr)
my_db <- src_mysql("mysql_dplyr", password="hulk") 
```

Nous copions un tableau de données R dans la base de données MySQL :


```r
df1 <- data.frame(
  Name = c("Joe", "Joe", "Bill", "Jim", "Kate"),
  Value = c(10.1, 13, 9, 7.7, -3),
  Indic = c(0L, 1L, 1L, 2L, 2L),
  Status = c("A", "A", "A", "B", "B"), 
  stringsAsFactors = FALSE
)
copy_to(my_db, df1, name="dat1", temporary = FALSE)
## Source:   query [?? x 4]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status
##   <chr> <dbl> <int>  <chr>
## 1   Joe  10.1     0      A
## 2   Joe  13.0     1      A
## 3  Bill   9.0     1      A
## 4   Jim   7.7     2      B
## 5  Kate  -3.0     2      B
```

La commande suivante transmet le tableau de données de MySQL dans l'objet R `dat1` :



```r
dat1 <- tbl(my_db, "dat1") 
```

L'objet `dat1` est un tableau de données mais qui n'a pas la classe `data.frame` :


```r
dat1
## Source:   query [?? x 4]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status
##   <chr> <dbl> <int>  <chr>
## 1   Joe  10.1     0      A
## 2   Joe  13.0     1      A
## 3  Bill   9.0     1      A
## 4   Jim   7.7     2      B
## 5  Kate  -3.0     2      B
class(dat1)
## [1] "tbl_mysql" "tbl_sql"   "tbl_lazy"  "tbl"
```

Pour obtenir un tableau `data.frame`, il suffit d'appliquer la fonction `collect` à `dat1`. 

Une requête SQL est attachée à `dat1`, qu'on peut obtenir avec `show_query` :


```r
show_query(dat1)
## <SQL>
## SELECT *
## FROM `dat1`
```

Le tableau de la base de données SQL ne sera jamais affecté par les transformations que nous allons effectuer sur `dat1` dans la section suivante. 


## Manipulation du tableau de données

On peut appliquer les fonctions de `dplyr` sur `dat1`. 
La commande est alors traduite en une requête SQL, retournée par la fonction `show_query` :


```r
dd <- select(dat1, Name, Status)
show_query(dd) 
## <SQL>
## SELECT `Name` AS `Name`, `Status` AS `Status`
## FROM `dat1`
dd <- filter(dat1, Indic==2 && Value>0)
show_query(dd)
## <SQL>
## SELECT *
## FROM `dat1`
## WHERE (`Indic` = 2.0 AND `Value` > 0.0)
```

Les requêtes sont exécutées de la façon la plus paresseuse possible : lorsqu'on tape `dd <- select(dat1, Name, Status)`, la requête associée n'est pas exécutée. Elle est exécutée lorsqu'il y a besoin de l'exécuter, par exemple dès qu'on demande d'afficher le contenu de `dd`. 
On peut s'en apercevoir avec l'exemple suivant :



```r
dd1 <- select(dat1, Name, Value)
dd2 <- filter(dd1, Value>5)
show_query(dd2) 
## <SQL>
## SELECT *
## FROM (SELECT `Name` AS `Name`, `Value` AS `Value`
## FROM `dat1`) `nvszhdovah`
## WHERE (`Value` > 5.0)
```

On voit que la requête associée à `dd2` est le cumul des deux requêtes successives. De même :


```r
dd <- select(dat1, Name, Value)
dd <- filter(dd, Value>5)
show_query(dd)
## <SQL>
## SELECT *
## FROM (SELECT `Name` AS `Name`, `Value` AS `Value`
## FROM `dat1`) `oshpgchcbg`
## WHERE (`Value` > 5.0)
```



Le sucre syntaxique de la librairie `dplyr` fonctionne sur `dat1` :


```r
# select columns starting with "Sta"
dd <- select(dat1, starts_with("Sta"))
show_query(dd) 
## <SQL>
## SELECT `Status` AS `Status`
## FROM `dat1`
# reorder columns - "Status" column at first position
dd <- select(dat1, Status, everything())
show_query(dd) # pas de requête SQL spéciale !
## <SQL>
## SELECT `Status` AS `Status`, `Name` AS `Name`, `Value` AS `Value`, `Indic` AS `Indic`
## FROM `dat1`
```

Mais on ne peut pas appliquer n'importe quelle commande R qui fonctionnerait si `dat1` avait la classe `data.frame` :


```r
# select rows for which Name contains "J"
library(stringr)
filter(dat1, str_detect(Name, "J")) 
## Source:   query [?? x 4]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## Error in .local(conn, statement, ...): could not run statement: FUNCTION mysql_dplyr.STR_DETECT does not exist
# create a new column with given values 
mutate(dat1, y=1:5) 
## Source:   query [?? x 5]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## Error in .local(conn, statement, ...): could not run statement: Operand should contain 1 column(s)
```

On peut envoyer une requête écrite en code SQL ainsi :


```r
tbl(my_db, sql("SELECT * FROM dat1 WHERE Name LIKE '%J%'"))
## Source:   query [?? x 4]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status
##   <chr> <dbl> <int>  <chr>
## 1   Joe  10.1     0      A
## 2   Joe  13.0     1      A
## 3   Jim   7.7     2      B
```

L'enchaînement d'instructions avec l'opérateur `%>%` fonctionne :


```r
dd <- dat1 %>% select(-Status) %>% filter(Value>0)
show_query(dd)
## <SQL>
## SELECT *
## FROM (SELECT `Name` AS `Name`, `Value` AS `Value`, `Indic` AS `Indic`
## FROM `dat1`) `cpdluwzsyu`
## WHERE (`Value` > 0.0)
```

Ainsi que l'aggrégation : 


```r
dat1 %>% group_by(Name) %>% summarise(MeanValue=mean(Value), Count=n()) %>% filter(Count == 1)
## Source:   query [?? x 3]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name MeanValue Count
##   <chr>     <dbl> <dbl>
## 1  Bill       9.0     1
## 2   Jim       7.7     1
## 3  Kate      -3.0     1
```



## Jonction de deux tableaux

Nous copions un deuxième tableau dans la base de données pour illustrer la jonction.


```r
df2 <- data.frame(
  Name = c("Bill", "Brian"),
  Country = c("USA", "Scotland"),
  stringsAsFactors = FALSE
)
copy_to(my_db, df2, name="dat2", temporary = FALSE)
## Source:   query [?? x 2]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name  Country
##   <chr>    <chr>
## 1  Bill      USA
## 2 Brian Scotland
dat2 <- tbl(my_db, "dat2")
```

Jonction interne, jonction à gauche et jonction à droite donnent les mêmes résultats que lorsqu'on les effectue sur des tableaux R classiques : 


```r
inner_join(dat1, dat2, by="Name")
## Source:   query [?? x 5]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## Auto-disconnecting mysql connection (0, 7)
##    Name Value Indic Status Country
##   <chr> <dbl> <int>  <chr>   <chr>
## 1  Bill     9     1      A     USA
left_join(dat1, dat2, by="Name")
## Source:   query [?? x 5]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status Country
##   <chr> <dbl> <int>  <chr>   <chr>
## 1   Joe  10.1     0      A    <NA>
## 2   Joe  13.0     1      A    <NA>
## 3  Bill   9.0     1      A     USA
## 4   Jim   7.7     2      B    <NA>
## 5  Kate  -3.0     2      B    <NA>
right_join(dat1, dat2, by="Name")
## Source:   query [?? x 5]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name  Country Value Indic Status
##   <chr>    <chr> <dbl> <int>  <chr>
## 1  Bill      USA     9     1      A
## 2 Brian Scotland    NA    NA   <NA>
```

Par contre, la jonction complète donne un résultat différent :


```r
full_join(dat1, dat2, by="Name")
## Source:   query [?? x 5]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status Country
##   <chr> <dbl> <int>  <chr>   <chr>
## 1  Bill     9     1      A     USA
full_join(df1, df2, by="Name")
##    Name Value Indic Status  Country
## 1   Joe  10.1     0      A     <NA>
## 2   Joe  13.0     1      A     <NA>
## 3  Bill   9.0     1      A      USA
## 4   Jim   7.7     2      B     <NA>
## 5  Kate  -3.0     2      B     <NA>
## 6 Brian    NA    NA   <NA> Scotland
```

Mais c'est bien la requête `FULL JOIN` qui est envoyée à la base de données :


```r
full_join(dat1, dat2, by="Name") %>% show_query
## <SQL>
## SELECT * FROM `dat1`
## 
## FULL JOIN
## 
## `dat2`
## 
## USING (`Name`)
```


## Exécuter des actions sur la base de données 

La librairie `dplyr` fournit aussi des fonctions permettant d'agir sur la base de données. On obtient la liste de ces fonctions avec `?backend_db`. 

Par exemple, la fonction `db_insert_into` permet d'ajouter des lignes :


```r
newrows <- data.frame(
  Name = c("Mike", "Steven"),
  Value = c(7, 19),
  Indic = c(3L, 2L),
  Status = c("A", "B"), 
  stringsAsFactors = FALSE
)
db_insert_into(con = my_db$con, table = "dat1", values = newrows)
tbl(my_db, "dat1")
## Source:   query [?? x 4]
## Database: mysql 5.5.50-0ubuntu0.14.04.1 [root@localhost:/mysql_dplyr]
## 
##    Name Value Indic Status
##   <chr> <dbl> <int>  <chr>
## 1   Joe  10.1     0      A
## 2   Joe  13.0     1      A
## 3  Bill   9.0     1      A
## 4   Jim   7.7     2      B
## 5  Kate  -3.0     2      B
## 6  Mike   7.0     3      A
## 7  Stev  19.0     2      B
```


