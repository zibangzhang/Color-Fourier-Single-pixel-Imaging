function [ orderMatFilename ] = getOrderMatFilename( mRow, nCol, PathStr )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    orderMatFilename = sprintf('%sOrderMat_%d_%d.mat', PathStr, mRow, nCol);
end

