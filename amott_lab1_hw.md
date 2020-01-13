---
title: "Amott_Hw1"
output: 
  html_document: 
    keep_md: yes
---

## Load the libraries

```r
library("tidyverse")
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Questions
1. Navigate to the R console and calculate the following expressions.  
  + 5 - 3 * 2  
  + 8 / 2 ** 2  
  

```r
5 - 3 * 2
```

```
## [1] -1
```

```r
8 / 2 **2
```

```
## [1] 2
```
  
2. Did any of the results in #1 surprise you? Write two programs that calculate each expression such that the result for the first example is 4 and the second example is 16.  

```r
(5 - 3) * 2
```

```
## [1] 4
```

```r
(8 / 2)**2
```

```
## [1] 16
```

3. Make a new object `pi` as 3.14159265359. 

```r
pi <- 3.14159265359
```

4. Is `pi` an integer or numeric? Why? Show your code.  

```r
class(pi)
```

```
## [1] "numeric"
```

5. You have decided to use your new analytical powers in R to become a professional gambler. Here are your winnings and losses this week. Note that you don't gamble on the weekends!  

```r
blackjack <- c(140, -20, 70, -120, 240, NA, NA)
roulette <- c(60, 50, 120, -300, 10, NA, NA)
```

a. Build a new vector called `days` for the days of the week.  

```r
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
```

We will use `days` to name the elements in the poker and roulette vectors.

```r
names(blackjack) <- days
names(roulette) <- days
```

b. Calculate how much you won or lost in blackjack over the week. 

```r
sum(blackjack)
```

```
## [1] NA
```

c. The result was NA because there is missing data for saturday and sunday. We can recalculate it with the NA removed.

```r
sum(blackjack, na.rm=TRUE)
```

```
## [1] 310
```

Here is an alternate approach that can be helpful if you want to remove NA's more globally.

```r
blackjack2 <- na.omit(blackjack)
sum(blackjack2)
```

```
## [1] 310
```

d. Calculate how much you won or lost in roulette over the week. 

```r
sum(roulette, na.rm = TRUE)
```

```
## [1] -60
```

e. Build a `total_week` vector to show how much you lost or won on each day over the week. Which days seem lucky or unlucky for you?

```r
total_week <- c(days)
days[1]
```

```
## [1] "Monday"
```

```r
sum(blackjack[1]+roulette[1])
```

```
## [1] 200
```

```r
days[2]
```

```
## [1] "Tuesday"
```

```r
sum(blackjack[2]+roulette[2])
```

```
## [1] 30
```

```r
days[3]
```

```
## [1] "Wednesday"
```

```r
sum(blackjack[3]+roulette[3])
```

```
## [1] 190
```

```r
days[4]
```

```
## [1] "Thursday"
```

```r
sum(blackjack[4]+roulette[4])
```

```
## [1] -420
```

```r
days[5]
```

```
## [1] "Friday"
```

```r
sum(blackjack[5]+roulette[5])
```

```
## [1] 250
```
Monday, Wednesday, Friday are lucky days and thursday is very unlucky.

Here is an example using `na.omit()`

```r
total_week <- na.omit(blackjack + roulette)
total_week
```

```
## [1]  200   30  190 -420  250
## attr(,"na.action")
## [1] 6 7
## attr(,"class")
## [1] "omit"
```

f. Should you stick to blackjack or roulette? Write a program that verifies this below.  

```r
sum(blackjack, na.rm = TRUE)
```

```
## [1] 310
```

```r
sum(roulette, na.rm = TRUE)
```

```
## [1] -60
```

```r
sum(blackjack, na.rm = TRUE) > sum(roulette, na.rm = TRUE)
```

```
## [1] TRUE
```

Another option

```r
total_blackjack <- sum(blackjack, na.rm = TRUE)
total_roulette <- sum(roulette, na.rm = TRUE)
total_blackjack>total_roulette
```

```
## [1] TRUE
```

Stick to Blackjack!

## Nice work! I added a few options for you to consider. My only suggestion would be to use comments so you can remember what you were thinking for future reference. Also, don't  forget to knit!
