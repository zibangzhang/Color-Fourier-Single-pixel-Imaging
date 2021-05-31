function [ Pattern ] = getFourierPattern( amp, mRow, nCol, fx, fy, initPhase )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    PATTERN_GENERATION_MODE = 1;
    
    switch PATTERN_GENERATION_MODE
        case 1                                                             %ѡ��1
            fxArr = fftshift([0:nCol-1] / nCol);                           %������Ƶ�ʶ��۱任���fxArr
            fyArr = fftshift([0:mRow-1] / mRow);                           %������Ƶ�ʶ��۱任���fyArr
            
            iRow = find(fyArr == fy);                                      %�ѣ�����ʱ�������ͣ�����λ��fy��fyArr���ҳ���0Ԫ�ظ�iRow (findΪ�ҳ���0Ԫ�أ�
            jCol = find(fxArr == fx);                                      %�ѣ�����ʱ�������ͣ�����λ��fx��fxArr���ҳ���0Ԫ�ظ�jCol
            
            spec = zeros(mRow, nCol);                                      %����һ��mRow nCol��ȫ����󲢸�spec
            spec(iRow,jCol) = amp * mRow * nCol * exp(1i*initPhase);       %
            Pattern = (amp + amp * real(ifft2(ifftshift(spec)))) / 2;      %�õ�����Ҷ����ͼ����ʵ��
        case 2
            [X,Y]=meshgrid(linspace(0,nCol-1,nCol), linspace(0,mRow-1,mRow));%ѭ�������ȼ���x,y����
            Pattern = (amp*exp(1i*(2*pi*(fx*X+fy*Y)+initPhase))+1)/2;      %��
            Pattern = real(Pattern);                                       %�õ�����Ҷ����ͼ����ʵ��
    end
    
end

