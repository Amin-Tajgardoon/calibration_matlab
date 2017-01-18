dataPath = 'C:\Users\mot16\projects\master\output\gsk_444563_NB_allVars_ATP_noMedicine_noPID_G9_YTE_PTE.csv';
data = csvread(dataPath,1,0);
YTE = data(:,1);
PTE = data(:,2);

disp('NaiveBayes probability measures : ')
m_0 = getMeasures(PTE,YTE)

ENIR = build(PTE, YTE);
PTE_enir = predict(ENIR, PTE, 1);

disp('Performance of Calibrated Probabilities using ENIR : ')
M_enir = getMeasures(PTE_enir, YTE)
