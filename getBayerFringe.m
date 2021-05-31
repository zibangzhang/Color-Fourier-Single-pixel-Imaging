function ColorFringe = getBayerFringe(fringe)
	[mRow, nCol] = size(fringe);
	
	%% Color imaging
	RedMaskSingleton = [0 1; 0 0];
	GreenMaskSingleton = [1 0; 0 1];
	BlueMaskSingleton = [0 0; 1 0];

	%% chromatic masks
	RedMask = repmat(RedMaskSingleton, [mRow/2, nCol/2]);
	GreenMask = repmat(GreenMaskSingleton, [mRow/2, nCol/2]);
	BlueMask = repmat(BlueMaskSingleton, [mRow/2, nCol/2]);
	
	ColorFringe(:,:,1) = RedMask .* fringe;
	ColorFringe(:,:,2) = GreenMask .* fringe;
	ColorFringe(:,:,3) = BlueMask .* fringe;
end