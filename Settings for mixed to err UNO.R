t=rexp(1000);median(t)
c=rexp(1000,rate=3)
time=ifelse(t<c,t,c)
censor=t<c
mydf0=data.frame(time=time,censor=censor,type=0)
p1=plot(survfit(Surv(time, censor) ~ 1, data = mydf), 
     xlab = "Days", 
     ylab = "Overall survival probability")

#t=exp(rnorm(n=10000,mean = log(qexp(0.5)),sd=0.1));median(t)
t=rlnorm(n=1000,meanlog=log(qexp(0.5)),sdlog=0.25);median(t)
c=rexp(1000,rate=0.5)
time=ifelse(t<c,t,c)
censor=t<c
mydf1=data.frame(time=time,censor=censor,type=1)
p2=plot(survfit(Surv(time, censor) ~ 1, data = mydf), 
        xlab = "Days", 
        ylab = "Overall survival probability")

myboth=rbind(mydf0,mydf1)

plot(survfit(Surv(time, censor) ~ type, data = myboth), 
     xlab = "Days", 
     ylab = "Overall survival probability")
