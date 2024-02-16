library (dplyr)
trav_Pitt <- read.csv("PittTravel.csv")
trav_Sea <- read.csv("SeaTravel.csv")
P_Penguins_results <- read.csv("PittRes.csv")
S_Kraken_results <- read.csv("SeaRes.csv")

bindres_pitt_sea <- rbind(P_Penguins_results, S_Kraken_results)
bindtrav <-rbind(trav_Pitt, trav_Sea)

trav_and_res <- left_join(bindtrav, bindres_pitt_sea, join_by(Location, Sea.or.Pitt))

#new continuous variable
trav_and_res <- trav_and_res %>%
  mutate(estimated_flight_duration_in_hours = distance.from.arena.in.miles/500)

#new categorical variable
trav_and_res$flight_time <- as.factor(ifelse(trav_and_res$estimated_flight_duration_in_hours <= 3.5, 'quick', 'long'))

#summarize
#how much both teams travel on average to a game
trav_and_res_mean_miles<-summarise(trav_and_res, mean(distance.from.arena.in.miles))

#saving the csv trav and res that contains the joined csvs
write.csv(trav_and_res, file="trav_and_res.csv")