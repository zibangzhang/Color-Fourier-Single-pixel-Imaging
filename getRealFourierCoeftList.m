function RealFourierCoeftList = getRealFourierCoeftList(mRow, nCol)
    if mod(mRow, 2) == 1 && mod(nCol, 2) == 1                              %����Ϊ����������ҲΪ������modΪȡ��
        RealFourierCoeftList = [ceil(mRow/2) ceil(nCol/2)];                %ʵֵ����Ҷϵ��������
    else
        if mod(mRow, 2) == 0 && mod(nCol, 2) == 0                          %��Ϊż������Ϊż��
             RealFourierCoeftList = [1        1;  ...                      %ʵֵ����Ҷϵ����������ųɹ���ľ����һ��
                                     1        nCol/2+1; ...
                                     mRow/2+1   1; ...
                                     mRow/2+1 nCol/2+1];
        else
            if mod(mRow, 2) == 1 && mod(nCol, 2) == 0                      %����Ϊ����������Ϊż��
                 RealFourierCoeftList = [ceil(mRow/2)   nCol/2+1; ...      %ʵֵ����Ҷϵ����������ųɹ���ľ����һ��
                                         ceil(mRow/2)   1];
            else                                                           %��Ϊż������Ϊ����
                 RealFourierCoeftList = [mRow/2+1       ceil(nCol/2); ...  %ʵֵ����Ҷϵ����������ųɹ������ĵ�һ��
                                         1              ceil(nCol/2)];
            end
        end
    end
end