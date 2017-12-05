function data()
    data_set1 = normrnd(-5,5,[400,2]);
    data_set2 = normrnd(5,3,[400,2]);
    data_set = [data_set1; data_set2];
    csvwrite('data.csv',data_set);
    plot(data_set(:,1),data_set(:,2),'r.')
end