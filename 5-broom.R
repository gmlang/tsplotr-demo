library(tidyr)
library(dplyr)
library(ggplot2)
library(broom)

tx = readRDS("data/tx-housing.rds") %>%
        mutate(date = year + (month - 1) / 12) %>%
        filter(!(city %in% c("Texas Totals", "Palestine")))

# remove rows with NA sales
tx = tx[!is.na(tx$sales), ]


# Models as an artefact ---------------------------------------------------
models = tx %>% group_by(city) %>%
        do(mod = lm(log(sales) ~ factor(month), data = .))

tmp = models %>% augment(mod) 
names(tmp)
tmp = tmp %>% select(city, .resid) %>% mutate(resid = .resid, .resid=NULL)
dim(tmp)
tmp2 = cbind(date = tx$date, as.data.frame(tmp))
head(tmp2)




model_sum = models %>% glance(mod)
model_sum
ggplot(model_sum, aes(r.squared, reorder(city, r.squared))) + 
  geom_point() + labs(y = "")


coefs <- models %>% tidy(mod)
coefs

months <- coefs %>%
  filter(grepl("factor", term)) %>%
  extract(term, "month", "(\\d+)", convert = TRUE)
months

ggplot(months, aes(month, exp(estimate))) +
  geom_line(aes(group = city))

coef_sum <- months %>%
  group_by(city) %>%
  summarise(max = max(estimate))
ggplot(coef_sum, aes(max, reorder(city, max))) + 
  geom_point()





