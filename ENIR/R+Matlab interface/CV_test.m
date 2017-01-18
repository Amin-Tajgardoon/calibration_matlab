% dataPath = 'C:\Users\mot16\projects\master\output\gsk_444563_NB_allVars_ATP_noMedicine_noPID_G9_YTE_PTE.csv';
%dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_NoMedicine_discrete_age_tempr_MATCH_ONLY_ColNameFixed_NaiveBayes_validation_output_YTE_PTE.csv';
%dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_NoMedicine_discrete_age_tempr_MATCH_ONLY_ColNameFixed_GreedyBDeU_validation_output_YTE_PTE.csv';
%dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_NoMedicine_discrete_age_tempr_MATCH_ONLY_ColNameFixed_replacedNullsInR_removedConstants_HC_K2_output_YTE_PTE.csv';
dataPath = 'C:\Users\mot16\projects\master\output\gsk_108134_NoMedicine_discrete_age_tempr_MATCH_ONLY_ColNameFixed_replacedNullsInR_removedConstants_GTT_K2_output_YTE_PTE.csv';

data = csvread(dataPath,1,0);
Y = data(:,1);
P = data(:,2);

kfold = 10;
cv = cvpartition(Y,'k',kfold); % stratified cv

M_enir = [];
M_enir.RMSE = zeros(cv.NumTestSets,1);
M_enir.AUC = zeros(cv.NumTestSets,1);
M_enir.ACC = zeros(cv.NumTestSets,1);
M_enir.MCE = zeros(cv.NumTestSets,1);
M_enir.ECE = zeros(cv.NumTestSets,1);

M_init = [];
M_init.RMSE = zeros(cv.NumTestSets,1);
M_init.AUC = zeros(cv.NumTestSets,1);
M_init.ACC = zeros(cv.NumTestSets,1);
M_init.MCE = zeros(cv.NumTestSets,1);
M_init.ECE = zeros(cv.NumTestSets,1);

PTE_enir = zeros(cv.NumObservations, 1);

for i = 1:cv.NumTestSets
    trIdx = cv.training(i);
    teIdx = cv.test(i);
    M_init(i) = getMeasures(P(trIdx), Y(trIdx));
    ENIR = build(P(trIdx), Y(trIdx));
    PTE_enir(teIdx) = predict(ENIR, P(teIdx), 1);
    M_enir(i) = getMeasures(PTE_enir(teIdx), Y(teIdx));
end

MT_init = struct2table(M_init);
MT_enir = struct2table(M_enir);

mean_init = [];
mean_init.RMSE = mean(MT_init.RMSE);
mean_init.AUC = mean(MT_init.AUC);
mean_init.ACC = mean(MT_init.ACC);
mean_init.MCE = mean(MT_init.MCE);
mean_init.ECE = mean(MT_init.ECE);

disp('Initial performance: ')
mean_init

mean_enir = [];
mean_enir.RMSE = mean(MT_enir.RMSE);
mean_enir.AUC = mean(MT_enir.AUC);
mean_enir.ACC = mean(MT_enir.ACC);
mean_enir.MCE = mean(MT_enir.MCE);
mean_enir.ECE = mean(MT_enir.ECE);

disp('ENIR performace: ')
mean_enir






