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
