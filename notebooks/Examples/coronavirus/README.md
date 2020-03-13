# Corona virus: Fact or Hype
<p align="center">
	<img src="figures/covid-19.jpg" width=500>
</p>

At the time of the writing of this notebook (March 9, 2020), the world has decended into mass panic, fueled by misinformation in the media.  In the stock market, the DOW-Jones Industrial Average dropped from 29,000 to 24,000 points, sending business and retirement accounts tumbling.

So, is this really a pandemic, or just hype?  According to the Centers for Disease Control and Prevention (CDC), this is no different than the [common flu](https://www.cdc.gov/coronavirus/2019-ncov/index.html).

If you are reading this notebook, you reaize that you are more than a lay-person.  You have powerful tools at your fingertips, and you likely have data to analyze and formulate your own opinion.  You realize that to be a Data Scientist requires you to be a creative and critical thinker, an individual.

Team DSBC had the same notion!

So we collected data from the CDC and [World Health Organization](https://www.who.int/csr/don/12-january-2020-novel-coronavirus-china/en/) (WHO) websites.  But we didn't stop there.  We are critical thinkers too.  We also colected data for:
- [Coronavirus international incidence dates](https://www.washington.edu/news/2020/02/07/interactive-map-shows-worldwide-spread-of-coronavirus/)
- [2009 H1N1 Swine Flu](https://academic.oup.com/cid/article/52/suppl_1/S75/499147#97947460), [here](https://www.cdc.gov/flu/spotlights/pandemic-global-estimates.htm), [here](http://www.cidrap.umn.edu/news-perspective/2011/08/study-puts-global-2009-h1n1-infection-rate-11-21), [here](https://www.cdc.gov/flu/pandemic-resources/2009-pandemic-timeline.html), [and here](https://en.wikipedia.org/wiki/2009_flu_pandemic_timeline#March_2009)
- [Ebola](https://www.cdc.gov/vhf/ebola/history/2014-2016-outbreak/case-counts.html)
- [SARS](https://www.who.int/csr/sars/country/en/)
- [MERS](https://hazards.colorado.edu/quick-response-report/dynamics-of-interorganizational-risk-management-networks-during-the-2015-mers-response-in-south-korea)
- [1918 Spanish Flu](https://www.cdc.gov/flu/pandemic-resources/1918-commemoration/pandemic-timeline-1918.htm) [and here](https://wwwnc.cdc.gov/eid/article/12/1/05-0979_article)


Just for completeness, we also collected data on:
- [Car crashes](https://www.asirt.org/safe-travel/road-safety-facts/)
- [Suicides](https://www.medicalnewstoday.com/articles/234219.php#1)
- [Cancer](https://www.who.int/news-room/fact-sheets/detail/cancer)
- [Ischemic Heart Disease](https://www.ahajournals.org/doi/10.1161/CIRCOUTCOMES.118.005375)
- [Generic US Flu](https://www.cdc.gov/flu/about/burden/preliminary-in-season-estimates.htm)
- [Stroke](http://www.strokecenter.org/patients/about-stroke/stroke-statistics/)
- [Drowning](https://www.who.int/news-room/fact-sheets/detail/drowning) 
- [Bed strangulation](https://www.businessinsider.com/weird-causes-of-death-2016-7#w75-accidental-suffocation-and-strangulation-in-bed--10206-deaths-7)
[also here](https://wonder.cdc.gov/controller/datarequest/D76)
- [SIDS](https://pediatrics.aappublications.org/content/pediatrics/122/3/660.full.pdf?download=true)
- [Domestic Violence](https://www.npr.org/sections/goatsandsoda/2018/11/30/671872574/u-n-report-50-000-women-a-year-are-killed-by-intimate-partners-family-members)
- [Animal deaths](https://www.businessinsider.com/worlds-deadliest-animals-2016-9/)
- [Alzheimer's](https://braintest.com/alzheimers-statistics-throughout-the-united-states-and-worldwide/)
- [Malaria](https://www.childfund.org/infographic/malaria/)
- [Homicide](https://ourworldindata.org/homicides)

So why did we go through all of this trouble?  Well, like any problem, we like to have as much data as possible to make good scientific decisions, and compare results where possible.  In this case, it is nice to compare COVID-19 to MERS and others.  As you will likely find, as we did, if you are [older than 5 and younger than 60](https://www.cdc.gov/coronavirus/2019-ncov/index.html), you are more likely to die of a car accident, than you are of COVID-19.

This notebook imports this data, and provides several plots with some analysis.  Use your judgement and make your own decision.

We will continue to update this notebook over the next several weeks, so stay tuned!
