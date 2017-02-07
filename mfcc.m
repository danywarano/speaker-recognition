%----------------------------mfcc------------------------------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------

function[ceps]=mfcc(input,fs)
l=length(input);
%30= 30;
%numCepstra=13;
lowerFilterFreq = 80.00;
samplingRate=fs;
%upperFilterFreq=5000;
samplePerFrame=256;
bin= zeros(1,256);

 % calculate FFT for current frame
    f=fft(input);
% calculate magnitude spectrum
for k = 1:l
   
	%bin(k) = sqrt(real(f(k)) * real(f(k)) + imag(f(k))* imag(f(k)));
    a=abs(f(k));
	bin(k)=a*a;
end
cbin = zeros(30+ 2);
cbin(1) =round(lowerFilterFreq / samplingRate* samplePerFrame);% cbin0
		cbin(length(cbin) ) = samplePerFrame / 2;
		for  i = 1:30% from cbin1 to cbin23
			fc = centerFreq(i);%center freq for i th filter
			cbin(i) =round(fc / samplingRate * samplePerFrame);
		end

[fbank] = melFilter(bin, cbin);
[f]= nonLinearTransformation(fbank);
 [ceps] = dct(f);
 
 
% ******************************inverseMel*********************************
function [output]=inverseMel(x) 
	temp = power(10, x / 2595) - 1;
	output= 700 * temp;
	
%*******************************freqToMel********************************
function [mel]=freqToMel(freq) 
		mel= 2595 * log10(1 + freq / 700);
	
%*******************************centerFreq*********************************
	function [output]=centerFreq(i) 
		melFLow = freqToMel(80.0);
		melFHigh = freqToMel(5000);
		temp = melFLow + ((melFHigh - melFLow) / (30+ 1))* i;
		output= inverseMel(temp);
	
	
	
 %********************* performs nonlinear transformation******************
	 % takes fbank
	  %return f log of filter back
	 
	function [f] =nonLinearTransformation( fbank) 
		l=length(fbank);
		 f = fbank;
		FLOOR = -50;
		for i = 1:l
			f(i) = log(fbank(i));
			if (f(i) < FLOOR) 
				f(i) = FLOOR;
			end
		end
		
	%*************************melfilter**********************************
	function [fbank]=melFilter(bin, cbin) 
		temp = zeros(1,32);
		for k = 2:30
			num1 = 0.0;
			 num2 = 0.0;
			for i = cbin(k-1):cbin(k)
				num1 =num1 + (i - cbin(k-1)+ 1) / (cbin(k) - cbin(k-1 ) + 1)* bin(i);
			end

			for i = cbin(k) + 1:cbin(k + 1)
				
				num2 =num2 + (1 - ((i - cbin(k)) / (cbin(k + 1) - cbin(k) + 1)))* bin(i);
			end

			temp(k) = num1 + num2;
		end
		fbank = zeros(1,30);
		for  i = 2: 32
			fbank(i)= temp(i);
		end


%***********************************dct***********************************
function [ceps]=dct(f)
    numCepstra=13;
    M=30;

        ceps= zeros(1,numCepstra);
        %perform DCT
        for  n = 1:numCepstra

            for i = 1: M
                ceps(n)=ceps(n)+ f(i)* cos(pi * (n) / M * (i - 0.5));
            end
        end

%***********************************************************************
	
	


