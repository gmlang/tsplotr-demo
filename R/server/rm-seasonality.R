# remove seasonality
models = reactive({
        f = lazyeval::interp(quote(log(y) ~ factor(x)), 
                             y = as.name(pick_y()), 
                             x = as.name(pick_seasonality()))
        rm_NAs() %>% group_by_(pick_gp()) %>% do(mod = lm(f, data=.))
}) 

# get residuals
df_resid = reactive({
        df = models() %>% augment(mod) %>% select_(pick_gp(), ".resid") 
        df = cbind(rm_NAs()[[pick_x()]], data.frame(df))
        names(df)[1] = pick_x()
        names(df)[3] = "residuals"
        df
})

# get r-squared
df_rsqrd = reactive({
        models() %>% glance(mod) %>% select_(pick_gp(), "r.squared")
})

# get coef estimates
df_coefs = reactive({
        models() %>% tidy(mod) %>%
                filter(grepl("factor", term)) %>%
                extract(term, pick_seasonality(), "(\\d+)", convert = TRUE)
})

# get max coef estimate
df_maxcoef = reactive({
        df_coefs() %>% group_by_(pick_gp()) %>% summarise(max_coef = max(estimate))
})
