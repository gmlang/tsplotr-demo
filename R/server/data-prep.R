# remove NAs
rm_NAs = reactive({
        dat = datafile()
        drop_idx = unique(c(which(is.na(dat[[pick_y()]])), 
                            which(is.na(dat[[pick_x()]]))))
        dat[-drop_idx, ]
})
