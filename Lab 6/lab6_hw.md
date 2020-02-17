---
title: "Lab 6 Homework"
author: "Andrea Mott"
date: "2/16/2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run.  

## Libraries

```r
library(tidyverse)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we used for the practice midterm. You may want to load that assignment for reference.  

```r
#install.packages("gapminder")
library("gapminder")
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NAs are treated in the data.**  

```r
anyNA(gapminder)
```

```
## [1] FALSE
```

```r
gapminder %>% 
  na_if("-999") %>% 
  na_if("") %>% 
  na_if("\\") %>% 
  purrr::map_df(~ sum(is.na(.))) %>% 
  pivot_longer(everything(),
    names_to= "variables",
    values_to = "num_nas") %>% 
  arrange(desc(num_nas))
```

```
## # A tibble: 6 x 2
##   variables num_nas
##   <chr>       <int>
## 1 country         0
## 2 continent       0
## 3 year            0
## 4 lifeExp         0
## 5 pop             0
## 6 gdpPercap       0
```

```r
colnames(gapminder)
```

```
## [1] "country"   "continent" "year"      "lifeExp"   "pop"       "gdpPercap"
```

```r
glimpse(gapminder)
```

```
## Observations: 1,704
## Variables: 6
## $ country   <fct> Afghanistan, Afghanistan, Afghanistan, Afghanistan, Afghani…
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia,…
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997,…
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.…
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 1…
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134,…
```

```r
gapminder
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # … with 1,694 more rows
```


**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
gapminder %>% 
  group_by(year) %>% 
  summarise(global_exp = mean(lifeExp, na.rm = T)) %>% 
  ggplot(aes(x = year, y = global_exp)) +
  geom_bar(stat = "identity") +
  labs(title = "Global Life Expectancy: 1952-2007",
       x = "Year", y = "Average Life Expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


**3. How do the distributions of life expectancy compare for the years 1952 and 2007? _Challenge: Can you put both distributions on a single plot?_** 



```r
gapminder %>% 
  group_by(year) %>% 
  filter(year==1952 | year==2007) %>% 
  ggplot(aes(x = year, y = lifeExp, group = year)) +
  geom_boxplot()+
  labs(title = "Global Life Expectancy: 1952 vs 2007",
       x = "Year", y = "Age")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
lifeexp_continent <- 
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(
    lifeexp_min=min(lifeExp),
    lifeexp_max=max(lifeExp),
    lifeexp_mean=mean(lifeExp))
lifeexp_continent
```

```
## # A tibble: 60 x 5
## # Groups:   continent [5]
##    continent  year lifeexp_min lifeexp_max lifeexp_mean
##    <fct>     <int>       <dbl>       <dbl>        <dbl>
##  1 Africa     1952        30          52.7         39.1
##  2 Africa     1957        31.6        58.1         41.3
##  3 Africa     1962        32.8        60.2         43.3
##  4 Africa     1967        34.1        61.6         45.3
##  5 Africa     1972        35.4        64.3         47.5
##  6 Africa     1977        36.8        67.1         49.6
##  7 Africa     1982        38.4        69.9         51.6
##  8 Africa     1987        39.9        71.9         53.3
##  9 Africa     1992        23.6        73.6         53.6
## 10 Africa     1997        36.1        74.8         53.6
## # … with 50 more rows
```


**5. How has life expectancy changed between 1952-2007 for each continent? Try using `geom_line()` for this, including all continents on the same  plot.**

```r
lifeexp_continent %>% 
  ggplot(aes(x=year, y=lifeexp_mean, color=continent))+
  geom_line()+
  labs(title = "Life Expectancy by Continent: 1952-2007",
       x = "Year", y = "Age")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**


```r
gapminder %>% 
  filter(gdpPercap<60000) %>% 
  ggplot(mapping = aes(x=gdpPercap, y = lifeExp)) +
  geom_point() +
  labs(title = "Life Expectancy vs GDP per Capita",
       x = "GDP Per Capita",
       y = "Life Expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))+
  geom_smooth(method=lm, se=T)
```

![](lab6_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

**7. There is extreme disparity in per capita GDP. Rescale the x axis to make this easier to interpret. How would you characterize the relationship?**


```r
gapminder %>% 
  filter(gdpPercap<60000) %>% 
  mutate(gdpPercap_log10=log(gdpPercap)) %>% 
  ggplot(mapping = aes(x=gdpPercap_log10, y = lifeExp, color=continent))+
  geom_point()+
  labs(title = "Life Expectancy vs GDP per Capita",
       x = "GDP Per Capita (Log10)",
       y = "Life Expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
#I also wanted to see by continent

**8. Which countries have had the largest population growth since 1952?**

```r
Top5_popgrowth <- 
  gapminder %>% 
  group_by(country) %>% 
  summarize(growth=max(pop)-min(pop)) %>% 
  mutate(growth_mil=growth/1000000) %>% 
  arrange(desc(growth)) %>% 
  head(n=5)
Top5_popgrowth
```

```
## # A tibble: 5 x 3
##   country          growth growth_mil
##   <fct>             <int>      <dbl>
## 1 China         762419569       762.
## 2 India         738396331       738.
## 3 United States 143586947       144.
## 4 Indonesia     141495000       141.
## 5 Brazil        133408087       133.
```


**9. Use your results from the question above to plot population growth for the top five countries since 1952.**


```r
gapminder %>% 
  filter(country %in% c("China", "India", "United States", "Indonesia", "Brazil")) %>% 
  ggplot(aes(x=year, y=pop, color=country))+geom_line()+
  labs(title= "Population Growth by Country: 1952-2007",
    x= "Year",
    y= "Population")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->



**10. How does per capita GDP growth compare between these same five countries?**

```r
gapminder %>% 
  filter(country %in% c("China", "India", "United States", "Indonesia", "Brazil")) %>% 
  ggplot(aes(x=year, y=gdpPercap, color=country))+geom_line()+
  labs(title= "GDP Growth Per Capita by Country:1952-2007",
    x= "Year",
    y= "GDP per Capita")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->



## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
