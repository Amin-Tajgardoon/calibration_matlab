%dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_ALL_VARS_MATCH_ONLY_NB_validation_output_YTE_PTE.csv';
dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_NoMedicine_discrete_age_tempr_MATCH_ONLY_ColNameFixed_replacedNullsInR_removedConstants_HC_K2_output_YTE_PTE.csv';
data = csvread(dataPath,1,0);
YTE = data(:,1);
PTE = data(:,2);

disp('probability measures : ')
m_0 = getMeasures(PTE,YTE)

options.N0 = 2;
BBQ = build(PTE, YTE, options);

PTE_bbq = predict(BBQ, PTE, 1);

disp('Performance of Calibrated Probabilities using BBQ : ')
M_bbq = getMeasures(PTE_bbq,YTE)
