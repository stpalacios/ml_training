% Start of script
close all;                   	% close all figures
clearvars; clearvars -global;	% clear all variables
clc;                         	% clear the command terminal
format shortG;                 	% picks most compact numeric display
format compact;                	% suppress excess blank lines


%% import "cases"
    
% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 127);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["UID", "iso2", "iso3", "code3", "FIPS", "Admin2", "Province_State", "Country_Region", "Lat", "Long_", "Combined_Key", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "VarName27", "VarName28", "VarName29", "VarName30", "VarName31", "VarName32", "VarName33", "VarName34", "VarName35", "VarName36", "VarName37", "VarName38", "VarName39", "VarName40", "VarName41", "VarName42", "VarName43", "VarName44", "VarName45", "VarName46", "VarName47", "VarName48", "VarName49", "VarName50", "VarName51", "VarName52", "VarName53", "VarName54", "VarName55", "VarName56", "VarName57", "VarName58", "VarName59", "VarName60", "VarName61", "VarName62", "VarName63", "VarName64", "VarName65", "VarName66", "VarName67", "VarName68", "VarName69", "VarName70", "VarName71", "VarName72", "VarName73", "VarName74", "VarName75", "VarName76", "VarName77", "VarName78", "VarName79", "VarName80", "VarName81", "VarName82", "VarName83", "VarName84", "VarName85", "VarName86", "VarName87", "VarName88", "VarName89", "VarName90", "VarName91", "VarName92", "VarName93", "VarName94", "VarName95", "VarName96", "VarName97", "VarName98", "VarName99", "VarName100", "VarName101", "VarName102", "VarName103", "VarName104", "VarName105", "VarName106", "VarName107", "VarName108", "VarName109", "VarName110", "VarName111", "VarName112", "VarName113", "VarName114", "VarName115", "VarName116", "VarName117", "VarName118", "VarName119", "VarName120", "VarName121", "VarName122", "VarName123", "VarName124", "VarName125", "VarName126", "VarName127"];
opts.VariableTypes = ["double", "categorical", "categorical", "double", "double", "string", "categorical", "categorical", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts = setvaropts(opts, [6, 11], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [2, 3, 6, 7, 8, 11], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
timeseriescovid19confirmedUS = readtable("..\..\data\novel-corona-virus-2019-dataset\time_series_covid_19_confirmed_US.csv", opts);


% Clear temporary variables
clear opts

CA_idx = ismember(timeseriescovid19confirmedUS{:, 7}, 'California');
TX_idx = ismember(timeseriescovid19confirmedUS{:, 7}, 'Texas');

col_idx = 14;
num_cols = size(timeseriescovid19confirmedUS,2)-col_idx;
t1 = datetime(2020,1,25,8,0,0);
t2 = datetime(2020,5,16,8,0,0);
t = t1:t2;

daily_total = zeros(num_cols,2);
for ii = 1:num_cols
    daily_total(ii,1) = sum(timeseriescovid19confirmedUS{CA_idx==1,ii+col_idx});
    daily_total(ii,2) = sum(timeseriescovid19confirmedUS{TX_idx==1,ii+col_idx});
end

daily_diff = zeros(num_cols,2);
for ii = 13:num_cols
    daily_diff(ii,1) = daily_total(ii,1) - daily_total(ii-1,1);
    daily_diff(ii,2) = daily_total(ii,2) - daily_total(ii-1,2);
end

num_weeks = floor((num_cols-col_idx)/7)+1;
weekly_diff = zeros(num_weeks,2);
weekly_date = t(1:num_weeks)';
idx = 1;
for ii = 1:num_weeks
    weekly_date(ii,1) = t(idx+7);
    weekly_diff(ii,1) = sum(daily_diff(idx:idx+6,1));
    weekly_diff(ii,2) = sum(daily_diff(idx:idx+6,2));
    idx = idx+7;
end

figure
plot(t,daily_total(:,1),...
    t,daily_total(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Cumulative number of cases','Interpreter','latex');
title('Cumulative number of cases vs time','Interpreter','latex');
% jan 21: first covid case in US
vline(t(1),0.65,'b','First COVID-19 case in US')
% jan 31: US blocks travel from china
vline(t(7),0.7,'g','US blocks travel from China')
% march 11: US borders closed
vline(t(47),0.75,'r','US borders closed')
% march 13: national emergency declared
vline(t(49),0.8,'m','National emergency declared')
% march 17: workforce asked to stay home
vline(t(53),0.85,'b','Workforce asked to stay home')
% april 1: lock-down
vline(t(68),0.9,'g','Lock-down')
% may 1: texas re-opens
vline(t(98),0.95,'r','Texas re-opens')


figure
plot(t,daily_diff(:,1),...
    t,daily_diff(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Daily number of new cases','Interpreter','latex');
title('Daily number of new cases vs time','Interpreter','latex');
% jan 21: first covid case in US
vline(t(1),0.65,'b','First COVID-19 case in US')
% jan 31: US blocks travel from china
vline(t(7),0.7,'g','US blocks travel from China')
% march 11: US borders closed
vline(t(47),0.75,'r','US borders closed')
% march 13: national emergency declared
vline(t(49),0.8,'m','National emergency declared')
% march 17: workforce asked to stay home
vline(t(53),0.85,'b','Workforce asked to stay home')
% april 1: lock-down
vline(t(68),0.9,'g','Lock-down')
% may 1: texas re-opens
vline(t(98),0.95,'r','Texas re-opens')

figure
plot(weekly_date,weekly_diff(:,1),...
    weekly_date,weekly_diff(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Weekly number of new cases','Interpreter','latex');
title('Weekly number of new cases vs time','Interpreter','latex');


%% import deaths
% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 128);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["UID", "iso2", "iso3", "code3", "FIPS", "Admin2", "Province_State", "Country_Region", "Lat", "Long_", "Combined_Key", "Population", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "VarName27", "VarName28", "VarName29", "VarName30", "VarName31", "VarName32", "VarName33", "VarName34", "VarName35", "VarName36", "VarName37", "VarName38", "VarName39", "VarName40", "VarName41", "VarName42", "VarName43", "VarName44", "VarName45", "VarName46", "VarName47", "VarName48", "VarName49", "VarName50", "VarName51", "VarName52", "VarName53", "VarName54", "VarName55", "VarName56", "VarName57", "VarName58", "VarName59", "VarName60", "VarName61", "VarName62", "VarName63", "VarName64", "VarName65", "VarName66", "VarName67", "VarName68", "VarName69", "VarName70", "VarName71", "VarName72", "VarName73", "VarName74", "VarName75", "VarName76", "VarName77", "VarName78", "VarName79", "VarName80", "VarName81", "VarName82", "VarName83", "VarName84", "VarName85", "VarName86", "VarName87", "VarName88", "VarName89", "VarName90", "VarName91", "VarName92", "VarName93", "VarName94", "VarName95", "VarName96", "VarName97", "VarName98", "VarName99", "VarName100", "VarName101", "VarName102", "VarName103", "VarName104", "VarName105", "VarName106", "VarName107", "VarName108", "VarName109", "VarName110", "VarName111", "VarName112", "VarName113", "VarName114", "VarName115", "VarName116", "VarName117", "VarName118", "VarName119", "VarName120", "VarName121", "VarName122", "VarName123", "VarName124", "VarName125", "VarName126", "VarName127", "VarName128"];
opts.VariableTypes = ["double", "categorical", "categorical", "double", "double", "string", "categorical", "categorical", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts = setvaropts(opts, [6, 11], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [2, 3, 6, 7, 8, 11], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
timeseriescovid19deathsUS = readtable("..\..\data\novel-corona-virus-2019-dataset\time_series_covid_19_deaths_US.csv", opts);


% Clear temporary variables
clear opts


CA_idx = ismember(timeseriescovid19deathsUS{:, 7}, 'California');
TX_idx = ismember(timeseriescovid19deathsUS{:, 7}, 'Texas');

col_idx = 15;
num_cols = size(timeseriescovid19deathsUS,2)-col_idx;
t1 = datetime(2020,1,25,8,0,0);
t2 = datetime(2020,5,16,8,0,0);
t = t1:t2;

daily_total = zeros(num_cols,2);
for ii = 1:num_cols
    daily_total(ii,1) = sum(timeseriescovid19deathsUS{CA_idx==1,ii+col_idx});
    daily_total(ii,2) = sum(timeseriescovid19deathsUS{TX_idx==1,ii+col_idx});
end

daily_diff = zeros(num_cols,2);
for ii = 13:num_cols
    daily_diff(ii,1) = daily_total(ii,1) - daily_total(ii-1,1);
    daily_diff(ii,2) = daily_total(ii,2) - daily_total(ii-1,2);
end

num_weeks = floor((num_cols-col_idx)/7)+1;
weekly_diff = zeros(num_weeks,2);
weekly_date = t(1:num_weeks)';
idx = 1;
for ii = 1:num_weeks
    weekly_date(ii,1) = t(idx+7);
    weekly_diff(ii,1) = sum(daily_diff(idx:idx+6,1));
    weekly_diff(ii,2) = sum(daily_diff(idx:idx+6,2));
    idx = idx+7;
end

figure
plot(t,daily_total(:,1),...
    t,daily_total(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Cumulative number of deaths','Interpreter','latex');
title('Cumulative number of deaths vs time','Interpreter','latex');
% jan 21: first covid case in US
vline(t(1),0.65,'b','First COVID-19 case in US')
% jan 31: US blocks travel from china
vline(t(7),0.7,'g','US blocks travel from China')
% march 11: US borders closed
vline(t(47),0.75,'r','US borders closed')
% march 13: national emergency declared
vline(t(49),0.8,'m','National emergency declared')
% march 17: workforce asked to stay home
vline(t(53),0.85,'b','Workforce asked to stay home')
% april 1: lock-down
vline(t(68),0.9,'g','Lock-down')
% may 1: texas re-opens
vline(t(98),0.95,'r','Texas re-opens')

figure
plot(t,daily_diff(:,1),...
    t,daily_diff(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Daily number of new deaths','Interpreter','latex');
title('Daily number of new deaths vs time','Interpreter','latex');
y=get(gca,'ylim');
ylim([0 y(2)])
% jan 21: first covid case in US
vline(t(1),0.65,'b','First COVID-19 case in US')
% jan 31: US blocks travel from china
vline(t(7),0.7,'g','US blocks travel from China')
% march 11: US borders closed
vline(t(47),0.75,'r','US borders closed')
% march 13: national emergency declared
vline(t(49),0.8,'m','National emergency declared')
% march 17: workforce asked to stay home
vline(t(53),0.85,'b','Workforce asked to stay home')
% april 1: lock-down
vline(t(68),0.9,'g','Lock-down')
% may 1: texas re-opens
vline(t(98),0.95,'r','Texas re-opens')

figure
plot(weekly_date,weekly_diff(:,1),...
    weekly_date,weekly_diff(:,2))
datetick('x', 'dd/mmm/yyyy', 'keepticks','keeplimits')
legend('California','Texas','Location','NW')
xlabel('Time (days)','Interpreter','latex');
ylabel('Weekly number of new deaths','Interpreter','latex');
title('Weekly number of new deaths vs time','Interpreter','latex');

dock_all_figures
save_all_figs_OPTION('timeseries','png')

