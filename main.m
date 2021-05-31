% Simulation for color Fourier single-pixel imaging
% 05/31/2021

close all
clear all
clc
TimeStamp = datestr(now, 'YYmmDD_HHMMSS');

%% SWITCH
SW_NOISE = 0;                                                              % 0: noiseless, 1: noisy

%% Parameters
nStepPS = 3;                                                               % n-step phase-shifting
Phaseshift = 120;                                                           % phase shift
Amplitude = 1;                                                             % amplitude of sin. pattern
SamplingRatio = 1;                                                      % e.g. sampling ratio
SamplingPath = 'circular';                                                  % sprial, diamond, circular

% Get input image
[imgFile pathname] = uigetfile({'*.bmp;*.jpg;*.tif;*.png;*.gif'','...
    'All Image Files';'*.*','All Files'});                                 
InputImg = im2double(imread([pathname imgFile]));    
figure,imshow(InputImg);title('Input image'); axis image;                

[mRow, nCol, nBand] = size(InputImg);                                           
if nBand ~= 3
    error('Input image is not a color image.');
end

[fxMat, fyMat] = meshgrid([0:1:nCol-1]/nCol, [0:1:mRow-1]/mRow);           % generate coordinates in Fourier domain (not neccessary)
fxMat = fftshift(fxMat);                                                   
fyMat = fftshift(fyMat);                                                   

OrderMat = getOrderMat(mRow, nCol, SamplingPath);                              % generate sampling path in Fourier domain
[nCoeft,tmp] = size(OrderMat);                                            
nCoeft = round(nCoeft * SamplingRatio);                                

InitPhaseArr = getInitPhaseArr(nStepPS, Phaseshift);                       
IntensityMat = zeros(mRow, nCol, nStepPS);                                 

RealFourierCoeftList = getRealFourierCoeftList(mRow, nCol);                

if SW_NOISE
    ReponseNoise = rand(nCoeft * nStepPS) * 2;                             % add noise
end

%% Main loop for simulating time-varying patterns illumiantion and single-pixel detection
tic;                                                                       
                                                                           
for iCoeft = 1:nCoeft                                                      
    iRow = OrderMat(iCoeft,1);                                             
    jCol = OrderMat(iCoeft,2);                                             
    
    fx = fxMat(iRow,jCol);                                                 
    fy = fyMat(iRow,jCol);                                                 

    IsRealCoeft = existVectorInMat( [iRow jCol], RealFourierCoeftList );   
    
     for iStep = 1:nStepPS                                               
        if IsRealCoeft == 1 && iStep > 2                                   
            if nStepPS == 3                                                
                IntensityMat(iRow,jCol,iStep) = IntensityMat(iRow,jCol,2); 
            end
            if nStepPS == 4                                                
                IntensityMat(iRow,jCol,iStep) = 0;                         
            end
            continue;                                                      
        end
        
        [ Pattern ] = getFourierPattern( Amplitude, mRow, nCol, fx, fy, InitPhaseArr(iStep) );
        PatternColor = getBayerFringe(Pattern);
        
        IntensityMat(iRow, jCol, iStep) = sum(sum(sum(InputImg .* PatternColor)));
    end
end

toc;                                                                     

%% Show and save results
[img, spec] = getFSPIReconstruction( IntensityMat, nStepPS, Phaseshift );  

figure, imshow(img); caxis([0 1]); axis image; colormap gray; title('Reconstructed Img');
figure, specshow(spec);                                                     % show Fourier spectrum in a log scale

% Color reconstruction
imgColor = im2double(demosaic(uint8(img * 255), 'grbg'));
figure, imshow(imgColor);

PSNR = psnr(imgColor, InputImg);                                                
SSIM = ssim(imgColor, InputImg);
RMSE = rmse(InputImg, imgColor);

fprintf('PNSR = %f\nSSIM = %f\nRMSE = %f\n', PSNR, SSIM, RMSE);