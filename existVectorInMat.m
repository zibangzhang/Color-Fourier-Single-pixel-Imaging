function [ existence ] = existVectorInMat( vector, mat )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
mRow = size(mat, 1);                                     %��ȡʵֵ������Ҷϵ���㣩�����������С��mRow��size(A,1)��ʾ����A���������
pz  = ones(mRow, 1) * vector - mat;                      %����һ��mRowһ�е�ȫ1����
existence = logical(size(find(sum(abs(pz)')' == 0), 1)); %
end

