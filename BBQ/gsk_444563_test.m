dataPath = 'C:\Users\mot16\projects\master\output\gsk_444563_NB_allVars_ATP_noMedicine_noPID_G9_YTE_PTE.csv';
data = csvread(dataPath,1,0);
YTE = data(:,1);
PTE = data(:,2);

m_0 = getMeasures(PTE,YTE);

options.N0 = 2;
BBQ = build(PTE, YTE, options);

PTE_bbq = predict(BBQ, PTE, 1);
M_bbq = getMeasures(PTE_bbq,YTE);
